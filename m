Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTDPXEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 19:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTDPXEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 19:04:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40585 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261874AbTDPXEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 19:04:37 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.67 - small AIO bug fix
Date: Wed, 16 Apr 2003 16:14:39 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_FWLGR6MCU0X5OID8PLFQ"
Message-Id: <200304161614.39720.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_FWLGR6MCU0X5OID8PLFQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Here is a small bug fix for AIO. get_user_pages() takes number=20
of pages to map as argument. (not in bytes)

Please apply.

Thanks,
Badari
--------------Boundary-00=_FWLGR6MCU0X5OID8PLFQ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="aio.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="aio.fix"

--- linux-2.5.67/fs/aio.c	Wed Apr 16 15:58:06 2003
+++ linux-2.5.67.new/fs/aio.c	Wed Apr 16 15:58:25 2003
@@ -148,7 +148,7 @@ static int aio_setup_ring(struct kioctx 
 
 	dprintk("mmap address: 0x%08lx\n", info->mmap_base);
 	info->nr_pages = get_user_pages(current, ctx->mm,
-					info->mmap_base, info->mmap_size, 
+					info->mmap_base, nr_pages, 
 					1, 0, info->ring_pages, NULL);
 	up_write(&ctx->mm->mmap_sem);
 

--------------Boundary-00=_FWLGR6MCU0X5OID8PLFQ--

