Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288925AbSBDL5c>; Mon, 4 Feb 2002 06:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288926AbSBDL5W>; Mon, 4 Feb 2002 06:57:22 -0500
Received: from elin.scali.no ([62.70.89.10]:13067 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S288925AbSBDL5N>;
	Mon, 4 Feb 2002 06:57:13 -0500
Message-ID: <3C5E76FD.BBB2F707@scali.com>
Date: Mon, 04 Feb 2002 12:56:45 +0100
From: Steffen Persvold <sp@scali.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Short question regarding generic_make_request()
In-Reply-To: <Pine.LNX.4.33.0202041315200.4046-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Mon, 4 Feb 2002, Steffen Persvold wrote:
> 
> > [root@damd1 root]# ping sci4
> > PING sci4 (192.168.4.4) from 192.168.4.3 : 56(84) bytes of data.
> > 64 bytes from sci4 (192.168.4.4): icmp_seq=0 ttl=255 time=238 usec
> 
> > For simplicity I'll say ~200usec. When I change the receive handler
> > from a tasklet to a kernel thread, the numbers look like this :
> >
> > [root@damd1 root]# ping sci4
> > PING sci4 (192.168.4.4) from 192.168.4.3 : 56(84) bytes of data.
> > 64 bytes from sci4 (192.168.4.4): icmp_seq=0 ttl=255 time=4.215 msec
> > 64 bytes from sci4 (192.168.4.4): icmp_seq=1 ttl=255 time=5.728 msec
> 
> this shows some sort of wakeup or softirq handling irregularity. A number
> of softirq latency bugs were fixed, i'd suggest to try this with any
> recent kernel (or recent errata kernel rpms).
> 

You are right indeed. I tried a vanilla 2.4.17 kernel at it performs well with a kernel thread (even
better than a tasklet actually) :

TCP STREAM TEST to sci9
Recv   Send    Send                          
Socket Socket  Message  Elapsed              
Size   Size    Size     Time     Throughput  
bytes  bytes   bytes    secs.    MBytes/sec  

262144 262144 262144    10.00     157.73   


Any idea when this bug was fixed (haven't tried the latest RedHat errata kernel yet, but will do).

I guess now that I can use the kernel thread without loosing performance I can start using
generic_make_request() in the block device server.

Thanks for all the help,

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
