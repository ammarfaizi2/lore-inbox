Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129180AbRBSQmz>; Mon, 19 Feb 2001 11:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbRBSQmp>; Mon, 19 Feb 2001 11:42:45 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43281 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129180AbRBSQmc>; Mon, 19 Feb 2001 11:42:32 -0500
Subject: Re: Linux 2.4.1-ac15
To: prumpf@mandrakesoft.com
Date: Mon, 19 Feb 2001 16:41:26 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        prumpf@parcelfarce.linux.theplanet.co.uk, rusty@linuxcare.com
In-Reply-To: <Pine.LNX.3.96.1010219102959.32729B-100000@mandrakesoft.mandrakesoft.com> from "Philipp Rumpf" at Feb 19, 2001 10:34:49 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UtNQ-0003rp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So you fixed the nonexistent race only.  The real race is that the module

Umm I fixed the small race. You are right that there is a second race.

> uninitialized vmalloc'd (module_map'd) memory), then the module data
> (including the exception table) gets copied.
> The race window is from the first copy_from_user in sys_init_module until
> the second one.

Yep. Obvious answer. Ignore exception tables for modules that are not
MOD_RUNNING.

