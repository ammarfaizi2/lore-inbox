Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S.rDHOT168807>; Sat, 15 May 1999 04:55:59 -0400
Received: by vger.rutgers.edu id <S.rDChR155998>; Fri, 14 May 1999 23:34:53 -0400
Received: from mail13.digital.com ([192.208.46.30]:2232 "EHLO mail13.digital.com") by vger.rutgers.edu with ESMTP id <S.rD5Ya156476>; Fri, 14 May 1999 15:27:34 -0400
Date: Fri, 14 May 1999 16:09:21 -0400 (EDT)
From: Phillip Ezolt <ezolt@perf.zko.dec.com>
To: Andrea Arcangeli <andrea@e-mind.com>
cc: linux-kernel@vger.rutgers.edu, jg@pa.dec.com, greg.tarsa@digital.com
Subject: Great News!! Was: [RFT] 2.2.8_andrea1 wake-one  
In-Reply-To: <Pine.LNX.4.05.9905122212150.9331-100000@laser.random>
Message-ID: <Pine.OSF.3.96.990514153735.2195A-100000@perf.zko.dec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu
X-UIDL: 926758553.38176.20441

Hi all, (especially Andrea)
	I've been doing some more SPECWeb96 tests, and with Andrea's
patch to 2.2.8 (ftp://e-mind.com/pub/andrea/kernel/2.2.8_andrea1.bz)

**On identical hardware, I get web-performance nearly identical to Tru64!**

Previously, Linux response times had been 100ms while tru64 had been ~4ms. 

However, with this patch applied, linux reponse times almost mirror Tru64. 

Tru64	~4ms
2.2.5	~100ms
2.2.8 	~9ms
2.2.8_a ~4ms

I realize that 2.3.1 has a more efficient wakeone patch applied, and haven't
yet had a chance to try it.  (Maybe tonight)

Time spent in schedule has decreased, as shown by this Iprobe data:

2.2.8 (pure)

Begin            End                                    Sample Image Total
Address          Address          Name                   Count   Pct   Pct
-------          -------          ----                   -----   ---   ---
0000000000000000-0000000120006F2F /usr/bin/httpd        121077        19.2 
0000000120041A00-00000001200433FF   ap_vformatter        14777  12.2   2.3 
FFFFFC0000300000-00000000FFFFFFFF vmlinux               428086        67.9 
FFFFFC0000315FA0-FFFFFC00003160DF   do_entInt            40185   9.4   6.4 
FFFFFC0000327D20-FFFFFC000032805F   schedule            126434  29.5  20.0 
FFFFFC00003B9CC0-FFFFFC00003BA0BF   tcp_v4_rcv           11701   2.7   1.9 
FFFFFC00003DB3A0-FFFFFC00003DBA5F   make_request          6879   1.6   1.1 
FFFFFC00004446E0-FFFFFC0000444ABF   do_csum_partial      27835   6.5   4.4 
                                    _copy_from_user           
FFFFFC0000445340-FFFFFC0000445513   __copy_user           9722   2.3   1.5 


2.2.8 (w/2.2.8_andrea1.bz)

Begin            End                                    Sample Image Total
Address          Address          Name                   Count   Pct   Pct
-------          -------          ----                   -----   ---   ---
0000000000000000-0000000120006F2F /usr/bin/httpd        121882        22.5 
0000000120041A00-00000001200433FF   ap_vformatter        15166  12.4   2.8 
0000020000590000-0000020000772FFF /lib/libc-2.0.7.so     66412        12.2 
00000200005F4E20-00000200005F4F7F   memcpy                6168   9.3   1.1 
FFFFFC0000300000-00000000FFFFFFFF vmlinux               343294        63.2 
FFFFFC0000316020-FFFFFC000031615F   do_entInt            42469  12.4   7.8 
FFFFFC0000327DA0-FFFFFC000032811F   schedule             37676  11.0   6.9 
FFFFFC0000328120-FFFFFC00003281FF   __wake_up            21703   6.3   4.0 
FFFFFC00003AF940-FFFFFC00003AFA7F   wait_for_connect      5489   1.6   1.0 
FFFFFC00003BA3C0-FFFFFC00003BA7BF   tcp_v4_rcv            7012   2.0   1.3 
FFFFFC0000444F80-FFFFFC000044535F   do_csum_partial      27679   8.1   5.1 
                                    _copy_from_user           
FFFFFC0000445BE0-FFFFFC0000445DB3   __copy_user           9188   2.7   1.7 

The number of SPECWeb96 MaxOps per second have jumped has well.

**Please, put the wakeone patch into the 2.2.X kernel if it isn't already. **

--Phil

Compaq                              HPSD/Benchmark Performance Engineering
Phillip.Ezolt@compaq.com                            ezolt@perf.zko.dec.com


On Wed, 12 May 1999, Andrea Arcangeli wrote:

> On Fri, 7 May 1999, Andrea Arcangeli wrote:
> 
> >I'll provide you a patch shortly to try out.
> 
> Phillip, could you try it out:
> 
> 	ftp://e-mind.com/pub/andrea/kernel/2.2.8_andrea1.bz2
> 
> under heavy web load? (should run fine on alpha too as far as stock-2.2.8
> is just fine too)
> 
> Note: it has also my wake-one on accept that just address completly the
> overscheduling problem. But to achieve performances by it you must make
> sure that _all_ apache tasks are sleeping in accept(2) and not in
> flock(2)/fcntl(2)/whatever. Maybe you'll need to patch apache to achieve
> that (I also seen a patch floating on the list, maybe you only need to
> grap such patch and apply/reverse it over the apache tree).
> 
> I would like if you would make comparison with a clean 2.2.8 (or with
> pre-2.3.1 even if I have not seen it yet).
> 
> Andrea Arcangeli
> 
> 
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
