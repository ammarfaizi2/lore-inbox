Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVERVE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVERVE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVERVE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:04:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:12174 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262371AbVERVD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:03:56 -0400
Date: Wed, 18 May 2005 14:04:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lubo_ Dole_el <lubosd@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "loop device recursion avoidance" patch causes difficulties
Message-Id: <20050518140440.415228e5.akpm@osdl.org>
In-Reply-To: <73e1f59805051704216bc4c78f@mail.gmail.com>
References: <73e1f59805051704216bc4c78f@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lubo_ Dole_el <lubosd@gmail.com> wrote:
>
> I've created a bugreport at http://bugme.osdl.org/show_bug.cgi?id=4472
> and I was advised to write to this list.
> 
> A patch called "loop device recursion avoidance" which appeared in
> 2.6.11 kernel has complicated ISO image mounting from another mounted
> media.

Does this help?


diff -puN drivers/block/loop.c~loop-recusrion-avoidance-fix drivers/block/loop.c
--- 25/drivers/block/loop.c~loop-recusrion-avoidance-fix	Wed May 18 14:03:14 2005
+++ 25-akpm/drivers/block/loop.c	Wed May 18 14:03:14 2005
@@ -765,10 +765,8 @@ static int loop_set_fd(struct loop_devic
 			goto out_putf;
 
 		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
-		if (l->lo_state == Lo_unbound) {
-			error = -EINVAL;
-			goto out_putf;
-		}
+		if (l->lo_state == Lo_unbound)
+			break;
 		f = l->lo_backing_file;
 	}
 
_

