Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbRE3Czd>; Tue, 29 May 2001 22:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262584AbRE3CzX>; Tue, 29 May 2001 22:55:23 -0400
Received: from f57.law3.hotmail.com ([209.185.241.57]:24845 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262580AbRE3CzN>;
	Tue, 29 May 2001 22:55:13 -0400
X-Originating-IP: [65.25.173.87]
From: "John William" <jw2357@hotmail.com>
To: nivedita@sequent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Abysmal RECV network performance
Date: Wed, 30 May 2001 02:55:06 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F57chplw8IfbyyOxmQp000170f7@hotmail.com>
X-OriginalArrivalTime: 30 May 2001 02:55:06.0708 (UTC) FILETIME=[EEA6E940:01C0E8B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Nivedita Singhvi <nivedita@sequent.com>
>To: jw2357@hotmail.com
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Abysmal RECV network performance
>Date: Mon, 28 May 2001 23:45:28 -0700 (PDT)
<snip>
>While we didnt use 2.2 kernels at all, we did similar tests
>on 2.4.0 through 2.4.4 kernels, on UP and SMP. I've used
>a similar machine (PII 333MHz) as well as faster (866MHz)
>machines, and got pretty nifty (> 90Mbs) throughput on
>netperf tests (tcp stream, no disk I/O) over a 100Mb full
>duplex link.  (not sure if there are any P-90 issues).
>
>Throughput does drop with small MTU, very small packet sizes,
>small socket buffer sizes, but only at extremes, for the most
>part throughput was well over 70Mbs. (this is true for single
>connections, you dont mention how many connections you were
>scaling to, if any).

Sorry, yes - I was doing single connection tests with no changes to the 
default Netperf settings. Each machine was running a copy of the server and 
then I ran the test with "netperf -H x.x.x.x" to each machine (or just 
"netperf" for a localhost speed check).

>However, we did run into serious performance problems with
>the Netgear FA311/2 (tulip). Found that the link lost
>connectivity because of card lockups and transmit timeout
>failures - and some of these were silent. However, I moved
>to the 3C905C (3c59x driver) which behaved like a champ, and
>we didnt see the problems any more, so have stuck to that card.
>This was back in the 2.4.0 time frame, and there have many
>patches since then to various drivers, so not sure if the
>problem(s) have been resolved or not (likely to have been,
>extensively reported). Both your cards might actually be
>underperforming..

I'm a little confused here - do you mean the FA310TX ("tulip" driver) or the 
FA311/2 ("natsemi" driver)? I have not had any connection problems with 
either the FA310 or the FA311 cards. I haven't noticed any speed problems 
with the FA311 card, but I haven't benchmarked it, either. The FA310 is so 
horribly slow, I couldn't help but notice. Unfortunately, the same is true 
of the 3cSOHO.

While I am willing to accept that both the FA310 and FA311 cards are 
underperforming, I think it is more than a little strange that the 3cSOHO 
card would turn in the same performance numbers. Also, keep in mind that I 
was only seeing horrible receive performance, TX performance seemed to be 
ok.

I didn't post FTP numbers (both machines are running FTP servers). While the 
FTP performance numbers are probably not as "scientific" as Netperf, they do 
seem to agree from what I have observered. I.e. retrieving files from the 
P-90 machine is ok (~3MB/sec) but sending files to it is very slow 
(~100K/sec). This roughly agrees with the Netperf numbers I saw.

FTP transfers to the FA311 machine (P2-350) are OK in both directions.

>Are you seeing any errors reported in /var/log/messages?
>Are you monitoring your connection via tcpdump, for example?
>You might sometimes see long gaps in transmission...Are
>there any abnormal numbers in /proc/net/ stats? I dont remember
>seeing that high frame errors, although there were a few.

No, I don't see anything in /var/log/messages.

I looked at tcpdump to try and figure it out, and it appeared that the P-90 
was taking a very long time to ACK some packets. I am not a TCP/IP guru by 
any stretch, but my guess at the time was that the packets that were taking 
forever to get ACK'ed were the ones causing a framing error on the P-90, but 
again, I'm not an expert.

The only unusual stat is the framing errors. There are a lot of them under 
heavy receive load. The machine will go for weeks without a single framing 
error, but if I blast some netperf action at it (or FTP send to it, etc.) 
then I get about 1/3 of the incoming packets (to the P-90) with framing 
errors. I see no other errors at all except a TX overrun error (maybe 1 in 
100000 packets).

>HW checksumming for the kind of test you are doing (tcp, mostly
>fast path) will not buy you any real performance gain, the
>checksum is actually consumed by the user-kernel copy routine.

Ok, I'll take your word for it. The P-90 isn't a very fast machine to begin 
with, so I thought it could use all the HW assistance it could get (that and 
the 3cSOHO card was really cheap :-).

I am very disappointed that TCP/IP performance on this machine is so lousy, 
but the problem is clearly with the kernel - just look at the performance 
numbers for 2.4.3 vs 2.2.19 (or 2.2.16). Those numbers aren't exactly great, 
but they are a lot better than 2.4.3.

>You can also run the tests on a profiling kernel and compare
>results...
>
>Nivedita
>
>---
>Nivedita Singhvi                        (503) 578-4580
>Linux Technology Center                 nivedita@us.ibm.com
>IBM Beaverton, OR                       nivedita@sequent.com

Thanks for the assistance. Based on the benchmark information I have, I 
would say that there is a problem with the kernel and would like to pursue 
getting that fixed. I just can't justify why 2.4.3 should be 600% slower 
than 2.2.19.

- John

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

