Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWJPNnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWJPNnx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWJPNnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:43:52 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:16283 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750754AbWJPNnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:43:52 -0400
Subject: Re: Better resolution using the hrtimers infrastructure
From: Steven Rostedt <rostedt@goodmis.org>
To: John <me@privacy.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <452DFA6D.4030300@privacy.net>
References: <452DFA6D.4030300@privacy.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 16 Oct 2006 09:43:22 -0400
Message-Id: <1161006202.15814.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LKML receives hundreds of emails a day (I go two days without checking,
and I have over 1000 unread messages).  So don't get turned off, if your
email is not replied to so quickly or at all. Just try again, or better
yet CC people who work on stuff related to your question.  I added those
that I know about right off hand but I could have missed a few.

-- Steve

On Thu, 2006-10-12 at 10:18 +0200, John wrote:
> Hello,
> 
> I've been experimenting with the high-resolution timer subsystem on the
> x86 platform (specifically, P4 2.8 GHz) running Linux 2.6.16.28. (LAPIC
> and IOAPIC turned on, pre-emptible kernel, HZ=250)
> 
> I wrote a small app to create a POSIX timer (timer_create(),
> timer_settime(), etc) that fires with a given period. The scheduling
> policy is set to SCHED_RR. After some time, the process writes the
> distribution of "elapsed time between signals" to a file, and exits. I
> then post-process this file to output average time between signals,
> standard deviation, occurences +/- 5 탎 and occurences +/- 10 탎.
> 
> I first compiled a kernel with a resolution of 5000 ns.
> I ran 10 concurrent tasks with T = 500+13*i 탎
> RUNTIME = 40000 s
> 
> AVG=500.0000119875 STDDEV=4.7221250605
> P(495 <= L <= 505) = 0.8177218875
> P(490 <= L <= 510) = 0.9630963875
> 
> AVG=512.9983118837 STDDEV=4.6444950150
> P(508 <= L <= 518) = 0.8248110095
> P(503 <= L <= 523) = 0.9648220375
> 
> AVG=525.9978541435 STDDEV=4.5872769426
> P(521 <= L <= 531) = 0.8294680508
> P(516 <= L <= 536) = 0.9662504459
> 
> AVG=538.9976678278 STDDEV=4.6550001682
> P(534 <= L <= 544) = 0.8233726222
> P(529 <= L <= 549) = 0.9647691136
> 
> AVG=551.9962816176 STDDEV=4.6202416645
> P(547 <= L <= 557) = 0.8261095807
> P(542 <= L <= 562) = 0.9654630987
> 
> AVG=564.9992072061 STDDEV=4.7382868551
> P(560 <= L <= 570) = 0.8201386764
> P(555 <= L <= 575) = 0.9631647119
> 
> AVG=577.9969566710 STDDEV=4.6799294742
> P(573 <= L <= 583) = 0.8199662908
> P(568 <= L <= 588) = 0.9637724766
> 
> AVG=591.0001112558 STDDEV=4.6366848287
> P(586 <= L <= 596) = 0.8273179260
> P(581 <= L <= 601) = 0.9651421699
> 
> AVG=604.0009058943 STDDEV=4.7022062409
> P(599 <= L <= 609) = 0.8253007146
> P(594 <= L <= 614) = 0.9627097645
> 
> AVG=617.0019377040 STDDEV=4.7598557221
> P(612 <= L <= 622) = 0.8164446084
> P(607 <= L <= 627) = 0.9616794710
> 
> 
> I then recompiled my kernel with a resolution of 800 ns.
> I ran 10 concurrent tasks with T = 600+13*i 탎
> RUNTIME = 50000 s
> 
> AVG=599.9986703520 STDDEV=4.3792286239
> P(595 <= L <= 605) = 0.8466944914
> P(590 <= L <= 610) = 0.9707216439
> 
> AVG=612.9981400476 STDDEV=4.1769930447
> P(608 <= L <= 618) = 0.8585605458
> P(603 <= L <= 623) = 0.9756196900
> 
> AVG=625.9983042536 STDDEV=4.2016958416
> P(621 <= L <= 631) = 0.8569019831
> P(616 <= L <= 636) = 0.9753284384
> 
> AVG=638.9985581093 STDDEV=4.2072766644
> P(634 <= L <= 644) = 0.8532895995
> P(629 <= L <= 649) = 0.9746377576
> 
> AVG=651.9989919428 STDDEV=4.1936623871
> P(647 <= L <= 657) = 0.8576286791
> P(642 <= L <= 662) = 0.9757251792
> 
> AVG=664.9976003076 STDDEV=4.2224641203
> P(660 <= L <= 670) = 0.8541156365
> P(655 <= L <= 675) = 0.9748352293
> 
> AVG=677.9992813471 STDDEV=4.2120672530
> P(673 <= L <= 683) = 0.8598737385
> P(668 <= L <= 688) = 0.9752509658
> 
> AVG=690.9987525239 STDDEV=4.2379530226
> P(686 <= L <= 696) = 0.8548963154
> P(681 <= L <= 701) = 0.9744069907
> 
> AVG=703.9993729190 STDDEV=4.3323158412
> P(699 <= L <= 709) = 0.8449093344
> P(694 <= L <= 714) = 0.9731234341
> 
> AVG=717.0005565641 STDDEV=4.2230279084
> P(712 <= L <= 722) = 0.8579009228
> P(707 <= L <= 727) = 0.9744286679
> 
> The resolution (STDDEV) was slightly better, but I un-scientifically
> changed two parameters. (I'll have to run more tests.)
> 
> 
> Finally, I ran only one task with T = 600 탎
> 
> AVG=600.0036125280 STDDEV=1.6630613701
> P(595 <= L <= 605) = 0.9997573360
> P(590 <= L <= 610) = 0.9998031160
> 
> 
> The resolution is markedly better (unsurprisingly).
> 
> Is it possible to improve the resolution? Would an HPET-enabled
> motherboard help? The source code seems to suggest the time stamp
> counter is used over any HPET. I've read that IBM provides high-quality
> HPET, whereas some southbridge manufacturers barely meet the Intel spec.
> Would other hardware (PCI board? PCI-Express board?) help in improving
> the resolution?
> 
> Thanks for reading this far.
> 
> Regards.
> 
> -

