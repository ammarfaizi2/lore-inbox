Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270569AbRHNLsB>; Tue, 14 Aug 2001 07:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270572AbRHNLrv>; Tue, 14 Aug 2001 07:47:51 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:41220 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S270569AbRHNLri>; Tue, 14 Aug 2001 07:47:38 -0400
Newsgroups: comp.protocols.time.ntp
CC: linux-kernel@vger.kernel.org
Subject: announce (experimental): Linux-2.4.7(i386/SMP) add-on for PPSkit
From: Ulrich Windl <wiu09524@rrzc5.rz.uni-regensburg.de>
Date: 14 Aug 2001 13:47:49 +0200
Message-ID: <snflmkmyiai.fsf@rrzc5.rz.uni-regensburg.de>
X-Newsreader: Gnus v5.7/Emacs 20.6
Posted-To: comp.protocols.time.ntp
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following message is a courtesy copy of an article
that has been posted to comp.protocols.time.ntp as well.

Hi,

I've just uploaded an incremental patch (cpuinfo.tar.bz2, 2kB) for the last
experimental PPSkit patch based on Linux-2.4.7 (PPSkit-CVS-2.4.7.bz2).

The stuff lives in ftp.kernel.org:/pub/linux/daemons/ntp/PPS...

In preparation for a smoother time on SMP machines, I've moved the
global scaling factors to convert TSC values to nanoseconds into
struct cpuinfo_x86. So a plain application could now scale TSC values
to absolute time with (almost) no kernel overhead.

The new variables are vnsec_per_cycle and nsec_per cycle. The first is
"virtual time" (as wrong as the board frequency), the latter is
"scaled" to the correct value (e.g. when ntpd updates the kernel's
frequency correction).

What you could do for me is to check if the fields are set for all the
CPUs on a SMP machine. As far as I understood the code, the boot CPU's
values should be copied to the individual CPU's info structures.

The code doesn't perform any better as the code before, but once
having a state per CPU, I can add some more magic. I'd be interested
if someone has an SMP machine to try things.

Also, merging the change to all the other arhitectures is a
significant chunk of work. I wonder if I should try it at all, or if
I'd just continue the i386.

In the past very few people sent feedback for the Alpha, so I have no
clear idea how many people use or like the code.

If you are new to these things and interested in the stuff, get
PPSkit-2.0.0 (at the same location) and read the NTP-FAQ
(http://www.ntp.org/ntpfaq/NTP-a-faq.htm) section ``6.2.4. PPS
Synchronization''.

Regards,
Ulrich
