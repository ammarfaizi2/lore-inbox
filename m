Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbRE2Gp7>; Tue, 29 May 2001 02:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263229AbRE2Gpt>; Tue, 29 May 2001 02:45:49 -0400
Received: from gateway.sequent.com ([192.148.1.10]:22965 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S263228AbRE2Gpi>; Tue, 29 May 2001 02:45:38 -0400
From: Nivedita Singhvi <nivedita@sequent.com>
Message-Id: <200105290645.XAA29714@eng4.sequent.com>
Subject: Re: Abysmal RECV network performance
To: jw2357@hotmail.com
Date: Mon, 28 May 2001 23:45:28 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can someone please help me troubleshoot this problem - 
> I am getting abysmal (see numbers below) network performance 
> on my system, but the poor performance seems limited to receiving 
> data. Transmission is OK. 

[ snip ]

> What kind of performance should I be seeing with a P-90 
> on a 100Mbps connection? I was expecting something in the 
> range of 40-70 Mbps - certainly not 1-2 Mbps. 
> 
> What can I do to track this problem down? Has anyone else 
> had problems like this? 

While we didnt use 2.2 kernels at all, we did similar tests
on 2.4.0 through 2.4.4 kernels, on UP and SMP. I've used
a similar machine (PII 333MHz) as well as faster (866MHz) 
machines, and got pretty nifty (> 90Mbs) throughput on 
netperf tests (tcp stream, no disk I/O) over a 100Mb full
duplex link.  (not sure if there are any P-90 issues).

Throughput does drop with small MTU, very small packet sizes,
small socket buffer sizes, but only at extremes, for the most
part throughput was well over 70Mbs. (this is true for single
connections, you dont mention how many connections you were
scaling to, if any).

However, we did run into serious performance problems with
the Netgear FA311/2 (tulip). Found that the link lost
connectivity because of card lockups and transmit timeout 
failures - and some of these were silent. However, I moved 
to the 3C905C (3c59x driver) which behaved like a champ, and 
we didnt see the problems any more, so have stuck to that card.  
This was back in the 2.4.0 time frame, and there have many 
patches since then to various drivers, so not sure if the
problem(s) have been resolved or not (likely to have been,
extensively reported). Both your cards might actually be
underperforming..

Are you seeing any errors reported in /var/log/messages?
Are you monitoring your connection via tcpdump, for example?
You might sometimes see long gaps in transmission...Are
there any abnormal numbers in /proc/net/ stats? I dont remember
seeing that high frame errors, although there were a few. 

HW checksumming for the kind of test you are doing (tcp, mostly
fast path) will not buy you any real performance gain, the
checksum is actually consumed by the user-kernel copy routine.

You can also run the tests on a profiling kernel and compare
results... 

Nivedita

---
Nivedita Singhvi                        (503) 578-4580
Linux Technology Center                 nivedita@us.ibm.com
IBM Beaverton, OR                       nivedita@sequent.com


