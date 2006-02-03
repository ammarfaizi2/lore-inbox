Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWBCOKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWBCOKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWBCOKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:10:20 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:35547 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1750842AbWBCOKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:10:19 -0500
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       nigel@suspend2.net, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 00/10] [Suspend2] Modules support.
In-Reply-To: <58cb370e0602030546q2ea4b70bq1dc66306d5ef1b12@mail.gmail.com>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202115907.GH1884@elf.ucw.cz> <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <1138916079.15691.130.camel@mindpipe> <20060202142323.088a585c.akpm@osdl.org> <20060203105100.GD2830@elf.ucw.cz> <58cb370e0602030322u4c2c9f9bm21a38be6d35d2ea6@mail.gmail.com> <20060203113543.GA3056@elf.ucw.cz> <20060203113543.GA3056@elf.ucw.cz> <58cb370e0602030546q2ea4b70bq1dc66306d5ef1b12@mail.gmail.com>
Date: Fri, 3 Feb 2006 14:10:13 +0000
Message-Id: <E1F51dd-0005cc-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> This is untrue as Linux has support for setting IDE controller
> and drives.  It was added by Benjamin Herrenschmidt in late
> 2.5.x or early 2.6.x (I don't remember exact kernel version).

In generic_ide_resume, rqpm.pm_step gets set to
ide_pm_state_start_resume and ide_do_drive_cmd gets called. This ends up
being passed through to start_request. start_request waits for the BSY
bit to go away. On the affected hardware I've seen, this never happens
unless the ACPI calls are made. As far as I can tell, there's nothing in
the current driver code that does anything to make sure that the bus is
in a state to accept commands at this point - the pci drivers don't (for
the most part) seem to have any resume methods. Calling the ACPI _STM
method before attempting to do this magically makes everything work.
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
