Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319493AbSIMCc6>; Thu, 12 Sep 2002 22:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319503AbSIMCc6>; Thu, 12 Sep 2002 22:32:58 -0400
Received: from web40510.mail.yahoo.com ([66.218.78.127]:52504 "HELO
	web40510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319493AbSIMCc6>; Thu, 12 Sep 2002 22:32:58 -0400
Message-ID: <20020913023744.78077.qmail@web40510.mail.yahoo.com>
Date: Thu, 12 Sep 2002 19:37:44 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Possible bug and question about ide_notify_reboot in drivers/ide/ide.c (2.4.19)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ide_notify_reboot function contains the following code fragment:


		for (unit = 0; unit < MAX_DRIVES; ++unit) {
			drive = &hwif->drives[unit];
			if (!drive->present)
				continue;

			/* set the drive to standby */
			printk("%s ", drive->name);
			if (event != SYS_RESTART)
				if (drive->driver != NULL && DRIVER(drive)->standby(drive))
				continue;

			if (drive->driver != NULL && DRIVER(drive)->cleanup(drive))
				continue;
		}

The standby() function returns 0 on success, and non-zero on failure. If standby() returns
failure status, the cleanup() call is skipped. Is this intentional?

Second, why do we need to put the disks on standby before halting? I ask because putting
the disks on standby puts my hard drives into a coma!! When I power up after a halt, I have
to go into the BIOS and force auto-detect to wake them back up. I've removed the "standby"
code and things seem to be functioning normally. I have an Epox 8K7A motherboard with two
Maxtor Hard drives (model 5T040H4).


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
