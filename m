Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbSJBRbj>; Wed, 2 Oct 2002 13:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJBRbj>; Wed, 2 Oct 2002 13:31:39 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:44523 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S261440AbSJBRbh>; Wed, 2 Oct 2002 13:31:37 -0400
Message-ID: <3D9B2EBC.4010102@drugphish.ch>
Date: Wed, 02 Oct 2002 19:37:00 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, netdev <netdev@oss.sgi.com>
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
References: <Pine.LNX.3.96.1020930133306.20863A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>I will do a new round of testing this weekend for a speech I'll be 
>>giving. This time I will include ipchains, iptables (of course I am 
>>willing to apply every interesting patch regarding hash table 
>>optimisation and whatnot you want me to test), nf-hipac, the OpenBSD pf 
>>and of course the work done by Jamal.
>  
> Look forward to any info you can provide.

Unfortunately (as always) there were tons of delays that didn't allow me 
to finish the complete test suite as I hoped I could but I sent some 
information off this list to Jamal and the nf-hipac guys about previous 
test result. See below. I hope I can do more tests this weekend ...

> I particularly like that nf-hipac can be put in and tried in one-to-one
> comparison, that leaves an easy route to testing and getting confidence in
> the code.

Yes and it was very convincing after the first few tests Some prelimiary 
test with raw TCP throughput have given me following really cool results:

TCP RAW throughput 100Mbit/s max MTU:
-------------------------------------
ratz@laphish:~/netperf-2.2pl2 > ./netperf -H 192.168.1.141 -p 6666 -l 60
TCP STREAM TEST to 192.168.1.141
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/s

  87380  16384  16384    60.01      88.03 <------
ratz@laphish:~/netperf-2.2pl2 >


TCP RAW throughput 100Mbit/s max MTU with 10000 non-matching rules + 1 
last matching rule at the end of the FORWARD chain [iptables]:
----------------------------------------------------------------------
ratz@laphish:~/netperf-2.2pl2 > ./netperf -H 192.168.1.141 -p 6666 -l 60
TCP STREAM TEST to 192.168.1.141
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

  87380  16384  16384    60.12       3.28 <------
ratz@laphish:~/netperf-2.2pl2 >


TCP RAW throughput 100Mbit/s max MTU with 10000 non-matching rules + 1 
last matching rule at the end of the FORWARD chain [nf-hipac]:
----------------------------------------------------------------------
ratz@laphish:~/netperf-2.2pl2 > ./netperf -H 192.168.1.141 -p 6666 -l 60
TCP STREAM TEST to 192.168.1.141
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

  87380  16384  16384    60.03      85.78 <------
ratz@laphish:~/netperf-2.2pl2 >


For nf-hipac I also have some statistics:
-----------------------------------------
bloodyhell:/var/FWTEST/nf-hipac # cat /proc/net/nf-hipac
nf-hipac statistics
-------------------

Maximum available memory:          65308672 bytes

Currently used memory:             1764160 bytes

INPUT:
   - INPUT chain is empty

FORWARD:
   - Number of rules:                 10002
   - Total size:                    1033010 bytes
   - Total size (allocated):        1764160 bytes
   - Termrule size:                   80016 bytes
   - Termrule size (allocated):      320064 bytes
   - Number of btrees:                30007
     * number of u32 btrees:          10003
       + distribution of u32 btrees:
                                     [     2,      4]:   10002
                                     [ 16384,  32768]:       1
     * number of u16 btrees:          10002
       + distribution of u16 btrees:
                                     [    1,     2]:   10002
     * number of u8 btrees:           10002
       + distribution of u8 btrees:
                                     [  2,   4]:      18

OUTPUT:
   - OUTPUT chain is empty

bloodyhell:/var/FWTEST/nf-hipac #

Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

