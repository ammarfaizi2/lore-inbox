Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbUJZBkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbUJZBkA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbUJZBjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:39:40 -0400
Received: from zeus.kernel.org ([204.152.189.113]:471 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262069AbUJZBXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:23:43 -0400
Date: Mon, 25 Oct 2004 15:56:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
Message-Id: <20041025155626.11b9f3ab.akpm@osdl.org>
In-Reply-To: <417D7EB9.4090800@osdl.org>
References: <20041022032039.730eb226.akpm@osdl.org>
	<417D7EB9.4090800@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> I'm trying to spend time on kexec++ this week, but this little BUG
> keeps getting in the way.  Has it already been reported/fixed?
> 
> kernel BUG at arch/i386/mm/highmem.c:42!

oops, we did it again.

--- 25/drivers/ide/ide-taskfile.c~ide_pio_sector-kmap-fix	Mon Oct 25 15:54:35 2004
+++ 25-akpm/drivers/ide/ide-taskfile.c	Mon Oct 25 15:54:48 2004
@@ -304,7 +304,7 @@ static void ide_pio_sector(ide_drive_t *
 	else
 		taskfile_input_data(drive, buf, SECTOR_WORDS);
 
-	kunmap_atomic(page, KM_BIO_SRC_IRQ);
+	kunmap_atomic(buf, KM_BIO_SRC_IRQ);
 #ifdef CONFIG_HIGHMEM
 	local_irq_restore(flags);
 #endif
_

