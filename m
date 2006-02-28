Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWB1MJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWB1MJF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWB1MJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:09:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40323 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932503AbWB1MJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:09:02 -0500
Date: Tue, 28 Feb 2006 13:08:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 10/13] ATA ACPI: do taskfile before mode commands
Message-ID: <20060228120843.GC3695@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222140140.0d9e41b7.randy_d_dunlap@linux.intel.com> <20060228115715.GE4081@elf.ucw.cz> <44043C7D.5090207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44043C7D.5090207@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 28-02-06 07:05:17, Jeff Garzik wrote:
> Pavel Machek wrote:
> >On St 22-02-06 14:01:40, Randy Dunlap wrote:
> >
> >>From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> >>
> >>Do drive/taskfile-specific commands before setting the drive mode.
> >>This allows the taskfile to unlock the drive before trying to
> >>set the drive mode.
> >>
> >>Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> >>---
> >>drivers/scsi/libata-core.c |   13 ++++++++++---
> >>1 file changed, 10 insertions(+), 3 deletions(-)
> >>
> >>--- linux-2616-rc4-ata.orig/drivers/scsi/libata-core.c
> >>+++ linux-2616-rc4-ata/drivers/scsi/libata-core.c
> >>@@ -4297,13 +4297,17 @@ static int ata_start_drive(struct ata_po
> >> */
> >>int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
> >>{
> >>+	printk(KERN_DEBUG "ata%d: resume device\n", ap->id);
> >
> >
> >Yep, one more helpful printk. Not. Actually this is four more of them
> >in this patch alone. Please remove your debugging code prior to merge.
> 
> Agreed, with the modification s/remove/limit by ata_msg_xxx/

Please, just remove them. Driver model core already has debugging that
can be enabled and prints what is called.

I do not think we want printk() at begining of every *_resume
function.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
