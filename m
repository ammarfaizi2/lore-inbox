Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSGIKUS>; Tue, 9 Jul 2002 06:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSGIKUR>; Tue, 9 Jul 2002 06:20:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32957 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313638AbSGIKUO>;
	Tue, 9 Jul 2002 06:20:14 -0400
Date: Tue, 9 Jul 2002 12:22:49 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH] 2.4 IDE core for 2.5
Message-ID: <20020709102249.GA20870@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've forward ported the 2.4 IDE core (well 2.4.19-pre10-ac2 to be exact)
to 2.5.25. It consists of 7 separate patches:

00_25ide-compile-1
	Fix 2.5 IDE compilation problem with ide_fix_driveid()

05_25pci-ids-1
	Add missing 2.4 IDE adapter pci ids

10_24ide-core-1
	Add 2.4 IDE core, modified for 2.5 changes

15_24-misc-bits-1
	various bits and pieces to make 2.4 IDE core work

20_split-ide-config-1
	Split 2.4 and 2.5 IDE configuration

25_ide-build-1
	allow 2.4 and 2.5 ide to be built

30_ide-scsi-1
	Add 2.4 ide-scsi version (note that 2.5 with 2.4 ide calls it
	ide-scsi24.o currently, I'll take patches to rectify that).

Find them all here:

*.kernel.org://pub/linux/kernel/people/axboe/patches/v2.5/2.5.25/

So why did I do this? Well, I needed stable IDE for 2.5 testing and it
was/is clear that 2.5 just isn't quite there yet. I intend to maintain
this patch set until I deem 2.5 IDE stable enough (in code) that I'm
willing to spend time on that instead. So the life span of this patch
depends heavily on that. That said, I know of others who would like to
be able to test 2.5 and not having to worry too much about the
state-of-the-day of the IDE core. This patch set may be useful to them
as well.

Also some notes on why I _didn't_ do this. I didn't do it because I
think Martin is a jerk or because 2.5 IDE is forever doomed. I didn't do
this because Andre twisted my arm. I didn't do this because of some
hidden agenda.

That said, the patch works for me here. I've ripped out ide-tape and
ide-floppy (frankly, I don't think it's worth my time updating these),
but apart from that I think it's 2.4 feature complete. PIO multi count
breaks for multi page bio's, if you intend to use that you should change
MPAGE_BIO_MAX_SIZE as noted in fs/mpage.c. I'll fix that in the next
iteration.

-- 
Jens Axboe

