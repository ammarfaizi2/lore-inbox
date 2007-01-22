Return-Path: <linux-kernel-owner+w=401wt.eu-S1751827AbXAVAlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbXAVAlc (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 19:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbXAVAlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 19:41:32 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:17490 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbXAVAlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 19:41:31 -0500
Date: Sun, 21 Jan 2007 16:37:19 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: bjdouma@xs4all.nl
Cc: linux-kernel@vger.kernel.org, osst@riede.org,
       osst-users@lists.sourceforge.net, scsi <linux-scsi@vger.kernel.org>
Subject: Re: OnStream DI30: undescriptive message: CoD != 0 in
 idescsi_pc_intr
Message-Id: <20070121163719.6c4defd8.randy.dunlap@oracle.com>
In-Reply-To: <45B2CC89.1020305@xs4all.nl>
References: <45B2CC89.1020305@xs4all.nl>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2007 03:14:33 +0100 Bauke Jan Douma wrote:

> OnStream Di30 (using ide-scsi and osst drivers), when reading
> or writing I regularly get these kernel messages:
> 
> <3>ide-scsi: CoD != 0 in idescsi_pc_intr
> 
> Let's assume flaky hardware; nothing we can hold the kernel to
> blame for (which is 2.6.19.1) -- it's a good thing it's calling
> our attention.  There's no data corruption, btw.
> 
> However, said message is quite useless because undescriptive
> and too terse.

Not sure that this helps much.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

Expand on a terse ide-scsi message.
Something is confused.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/scsi/ide-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2619-work.orig/drivers/scsi/ide-scsi.c
+++ linux-2619-work/drivers/scsi/ide-scsi.c
@@ -528,7 +528,7 @@ static ide_startstop_t idescsi_pc_intr (
 	ireason.all	= HWIF(drive)->INB(IDE_IREASON_REG);
 
 	if (ireason.b.cod) {
-		printk(KERN_ERR "ide-scsi: CoD != 0 in idescsi_pc_intr\n");
+		printk(KERN_ERR "ide-scsi: CoD(Command/Data flag) != 0(Data) in idescsi_pc_intr\n");
 		return ide_do_reset (drive);
 	}
 	if (ireason.b.io) {

