Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130393AbRAFTgZ>; Sat, 6 Jan 2001 14:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbRAFTgO>; Sat, 6 Jan 2001 14:36:14 -0500
Received: from dial-206-102-3-202.easystreet.com ([206.102.3.202]:61190 "EHLO
	enzo.localdomain") by vger.kernel.org with ESMTP id <S132862AbRAFTgE>;
	Sat, 6 Jan 2001 14:36:04 -0500
Date: Sat, 6 Jan 2001 11:35:52 -0800
From: BJerrick@easystreet.com
Message-Id: <200101061935.f06JZqx18624@enzo.localdomain>
To: aeb@cwi.nl, linux-kernel@vger.kernel.org, p_gortmaker@yahoo.com
Subject: 500 ms offset in i386 Real Time Clock setting
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Neither hwclock nor the /dev/rtc driver takes the following comment from
set_rtc_mmss() in arch/i386/kernel/time.c into account.  As a result, using
hwclock --systohc or --adjust always leaves the Hardware Clock 500 ms ahead of
the System Clock:

     * In order to set the CMOS clock precisely, set_rtc_mmss has to be
     * called 500 ms after the second nowtime has started, because when
     * nowtime is written into the registers of the CMOS clock, it will
     * jump to the next second precisely 500 ms later. Check the Motorola
     * MC146818A or Dallas DS12887 data sheet for details.

(It looks like the only thing that does account for it is the 11-minute
STA_UNSYNC updater in do_timer_interrupt(), in arch/i386/kernel/time.c .)

Shouldn't there be some kernel interface that hides this machine-dependency
from user-level code; i.e., that sets time more precisely?

Bruce Jerrick
Portland, Oregon, USA
email:   bjerrick@easystreet.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
