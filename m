Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313025AbSDKXqS>; Thu, 11 Apr 2002 19:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313027AbSDKXqR>; Thu, 11 Apr 2002 19:46:17 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:11275 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S313025AbSDKXqR>; Thu, 11 Apr 2002 19:46:17 -0400
Message-ID: <3CB61523.89BE3422@opersys.com>
Date: Thu, 11 Apr 2002 18:58:43 -0400
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16-TRACE i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Linux Trace Toolkit ready for 2.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have prepared a 2.5.7 patch for the Linux Trace Toolkit.

As I had said before, LTT now supports 5 architectures: i386, PPC, S/390, SuperH and MIPS.

For those who are not familiar with LTT, it provides for dynamic tracing of
the Linux kernel. This type of toolset is fundamental when developing applications
that require a clear understanding of the sequence of events that occur. It is, for
instance, impossible to debug any form of inter-process communication using a
conventional debugger. With a trace tool such as LTT, this becomes fairly easy.

Synchronization problem solving and performance measurement are the two broad
categories where LTT is unique in its capabilities.

In order to provide these capabilities, information must be collected at the kernel
level during execution. Hence, trace statements are inserted at key points in the
kernel to collect data. The following is an example statement:

		TRACE_SCHEDCHANGE(prev, next);

This is actually a macro which gets replaced by the following iff tracing is
selected during kernel configuration (otherwise, no code is generated):

#define TRACE_SCHEDCHANGE(OUT, IN) \
           do \
           {\
           trace_schedchange sched_event;\
           sched_event.out       = OUT->pid;\
           sched_event.in        = (uint32_t) IN;\
           sched_event.out_state = OUT->state; \
           trace_event(TRACE_EV_SCHEDCHANGE, &sched_event);\
           } while(0);

trace_event() is a unified trace function which is called by all the instrumented
parts of the kernel. The rest of the mechanics of how information is recorded,
committed and reused is covered in a paper I presented at the 2000 Usenix Annual
Technical Conference entitled "Measuring and Characterizing System Behavior
Using Kernel-Level Event Logging." The complete paper can be found here:
ftp://ftp.opersys.com/pub/LTT/Documentation/ltt-usenix.ps.gz

As said above, LTT does not add any code to the kernel when disabled at config
time. Also, LTT has a very low impact (2.5%) on the system's behavior when activated.
This impact has been studied in the Usenix paper.

LTT has been available for close to 3 years now and has seen many contributions
from IBM, MontaVista, HP and Sony, to name a few. It is already part of a number
of distributions, including MontaVista, Lineo and Debian, with more on the way.

In the past, many have shown interest and support for LTT's inclusion in
the standard kernel tree. I won't fill this mail with names, but Alan Cox,
for instance, is one of them.

The patch is available here:
ftp://ftp.opersys.com/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.7-vanilla-020411-1.14.gz

LTT's home page is:
http://www.opersys.com/LTT

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
