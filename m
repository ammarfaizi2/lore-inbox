Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSG1KaH>; Sun, 28 Jul 2002 06:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSG1KaH>; Sun, 28 Jul 2002 06:30:07 -0400
Received: from science.horizon.com ([192.35.100.1]:37450 "HELO
	science.horizon.com") by vger.kernel.org with SMTP
	id <S315746AbSG1KaH>; Sun, 28 Jul 2002 06:30:07 -0400
Date: 28 Jul 2002 10:33:11 -0000
Message-ID: <20020728103311.25018.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen asked for:
> waitonmonotonicallyincreasingnonadjustablehighres64bittime()

Well, take the POSIX clock_gettime() interface and add clock_waittime().
Oh, wait.. they already did it.  clock_nanosleep().

The POSIX folks realized that people want a variety of tiemrs, and
so the functions take a clockid_t first argument, which is just an enum.
They defined two values, but leave the field open to others:
- CLOCK_MONOTONIC, which is what you want.  Unspecified epoch
  (possibly boot time), and never gets adjusted
- CLOCK_REALTIME, which is the classig time() UTC time.

Extensions define CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID.

The clock weenies are welcome to add CLOCK_TAI, CLOCK_GPS, CLOCK_UTS
(see Markus Kuhn's suggestion), CLOCK_UTC (with some "better" leap-second
handling), CLOCK_FREQADJUST (uses frequency but not phase adjustments),
CLOCK_NOSTEP (frequency and phase adjustments, but doesn't step),
and anything else you like.

Astronomers might add CLOCK_UT1, CLOCK_UT0, CLOCK_SIDERIAL, CLOCK_TDB,
CLOCK_TDT, CLOCK_TCG, CLOCK_TCB, and maybe a few things I haven't thought
of.  The interface doesn't require that all of these be implemented in
the kernel, of course.
