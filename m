Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVACGYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVACGYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 01:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVACGYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 01:24:14 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:20606 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261394AbVACGYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 01:24:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Mon, 3 Jan 2005 01:23:58 -0500
User-Agent: KMail/1.6.2
Cc: Roey Katz <roey@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <200501022206.50265.dtor_core@ameritech.net> <Pine.NEB.4.61.0501030536110.14662@sdf.lonestar.org>
In-Reply-To: <Pine.NEB.4.61.0501030536110.14662@sdf.lonestar.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501030123.58884.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 January 2005 12:37 am, Roey Katz wrote:
> Dmitry,
> 
> I have the contents of 'kern.log' at:
> 
>    http://roey.freeshell.org/mystuff/kernel/kern.log-2.6.10
> 

The following looks very suspicious:

Jan  2 23:05:17 tits kernel: drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [4842]
Jan  2 23:05:17 tits kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1, timeout) [4866]
Jan  2 23:05:17 tits kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1, timeout) [4874]
Jan  2 23:05:17 tits kernel: drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1, timeout) [4882]
Jan  2 23:05:17 tits kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [4882]
Jan  2 23:05:17 tits kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [4894]
Jan  2 23:05:17 tits kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [4894]
Jan  2 23:05:17 tits kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [4906]

atkbd driver tries to get ID from the attached device but although the
controller responds with valid keyboard ID it also for some reason indicates
that the connected device times out. Wierd...

Could you try booting with "acpi=off"?

-- 
Dmitry
