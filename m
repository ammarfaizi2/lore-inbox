Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLOPpY>; Fri, 15 Dec 2000 10:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLOPpO>; Fri, 15 Dec 2000 10:45:14 -0500
Received: from d06lmsgate-2.uk.ibm.com ([195.212.29.2]:48777 "EHLO
	d06lmsgate-2.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S129348AbQLOPpL>; Fri, 15 Dec 2000 10:45:11 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Message-ID: <802569B6.0053B0D6.00@d06mta06.portsmouth.uk.ibm.com>
Date: Fri, 15 Dec 2000 15:13:16 +0000
Subject: Re: Question about RTC interrupts on i386
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




You can get some interesting side effects if you incease the clock speed.
I'm not saying that Linux will suffer, but I have seen problems on other
Intel based systems - it all depends on what you do with the clock
interrupt.

Increasing the seed will give a finer grained pre-emption capability. I
assume you're talking about the free-running timer on IRQ0 and not the TOD
clock on IRQ8 - both of these are driven from the same chip. If this is the
case then the preblems I referred to arise when the PIC is programed in
strict priority order. IRQ0 will  be the highest priority interrupt, which
meanse lower priotiy devices that are running asynchronously may overrun
inbound because they can't get their interrupts serviced quickley enough.
For a server or desktop use you want you high priority interrupts to be
infrequenlty occuring. Real-time systems may legitimately have a different
requirement.

I'm not sure there's any particular advantage to the TOD clock on IRQ 8.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Lee Reynolds <kelticman1972@yahoo.com> on 15/12/2000 04:04:04

Please respond to Lee Reynolds <kelticman1972@yahoo.com>

To:   Linux Kernel Maillist <linux-kernel@vger.kernel.org>
cc:
Subject:  Question about RTC interrupts on i386




I'm reading the book Linux Internals by Moshe Bar.
Early on he describes the use of the real time clock
to generate an interrupt 100 times a second.  He
explains that this value was chosen early in the
development cycle of the linux kernel and is therefore
relatively low compared to what current hardware can
make good use of.  He mentions that the alpha port of
linux uses a 1024Hz interrupt rate and that patches
have been made for the Intel kernel to give it the
same rate while maintaining the interrupt rate that
appears to userland  programs such as top at 100Hz.

I'm just wondering what the benefits of increasing
this value are and whether these patches are going to
be included in 2.4?

Thanks,
Lee Reynolds

__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
