Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWBSVuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWBSVuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWBSVuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:50:32 -0500
Received: from mail.gmx.de ([213.165.64.20]:20930 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750809AbWBSVub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:50:31 -0500
X-Authenticated: #704063
Subject: triggering BUGs in 2.6.15-rt16
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 19 Feb 2006 22:50:28 +0100
Message-Id: <1140385829.5057.6.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
while fooling around with 2.6.15-rt16 i got a couple ( ~330 ) of BUG()s,
which i caught via netconsole

http://www.snake-basket.de/linux-2.6.15-rt16_bug_party.log

A grep shows the BUG()s fall into these categories:

BUG: scheduling with  irqs disabled: insmod/0x00000000/8370
BUG: sleeping function called from invalid context insmod(8370) at mm/slab.c:2134
insmod/7573[CPU#0]: BUG in up_mutex at kernel/rt.c:2246
insmod/7573[CPU#0]: BUG in ____up_mutex at kernel/rt.c:1583
BUG: lock wait_list not initialized?

i was trying to fuzz the ioctl() interface, and assumed it might
be a good idea to load as many modules as possible, so i did a

	"for file in */*.ko; do insmod $file; done"

When i noticed the number of BUG()s i did a

	"lsmod | cut -f1 -d " " | xargs rmmod"

which finally switched the box off. In case .config is of
interest just let me know.

Greetings, Eric Sesterhenn

