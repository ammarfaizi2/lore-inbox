Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVAKMgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVAKMgV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 07:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVAKMgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 07:36:21 -0500
Received: from aun.it.uu.se ([130.238.12.36]:9111 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262730AbVAKMgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 07:36:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16867.51258.916944.195917@alkaid.it.uu.se>
Date: Tue, 11 Jan 2005 13:36:10 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Bernard Blackham <bernard@blackham.com.au>
Cc: Pavel Machek <pavel@ucw.cz>, Shaw <shawv@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Screwy clock after apm suspend
In-Reply-To: <20050111011611.GE4641@blackham.com.au>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com>
	<20050109224711.GF1353@elf.ucw.cz>
	<200501092328.54092.shawv@comcast.net>
	<20050110074422.GA17710@mussel>
	<20050110105759.GM1353@elf.ucw.cz>
	<20050110174804.GC4641@blackham.com.au>
	<20050111001426.GF1444@elf.ucw.cz>
	<20050111011611.GE4641@blackham.com.au>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernard Blackham writes:
 > Looking harder, in arch/i386/kernel/apm.c the system time is also
 > saved and restored in a very similar way to timer_suspend/resume.
 > Would this account for the time drift in APM mode? (sleep time being
 > accounted for twice?)

No, apm.c's update to xtime is absolute, just like time.c's.
Doing both is pointless but not harmful. (I've already tried
with apm.c's xtime update commented out, but the time-warp
bug remained.)

My 0.02 SEK says it's the jiffies update that's broken.
