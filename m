Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVLKTdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVLKTdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVLKTdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:33:15 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:2368 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750818AbVLKTdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:33:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:cc:content-type:content-transfer-encoding:message-id;
        b=ZngrBhrrylomL00zNTsu1y3u1t7dHVfBuMt4e/Rk1XT25l4c7U7/wuoGndT2RI9QXF+T8Pu81Z3KbRHBFFZmQK74DxGEXWy4w5TmrtZmhypqyrVzscgKVQNP0T/2RWNvpkIViUT38aUIHTNE/0Y+lR/UYzvSn/1oev19QvlS7GE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] fs/binfmt_elf: Remove unneeded kmalloc() return value casts
Date: Sun, 11 Dec 2005 20:33:48 +0100
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Disposition: inline
Cc: Eric Youngdale <ericy@cais.com>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512112033.48345.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove unneeded casts of kmalloc() return value in binfmt_elf.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/binfmt_elf.c       |    2 +-
 fs/binfmt_elf_fdpic.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc5-git1-orig/fs/binfmt_elf.c	2005-12-04 18:48:35.000000000 +0100
+++ linux-2.6.15-rc5-git1/fs/binfmt_elf.c	2005-12-11 19:27:55.000000000 +0100
@@ -616,7 +616,7 @@ static int load_elf_binary(struct linux_
 				goto out_free_file;
 
 			retval = -ENOMEM;
-			elf_interpreter = (char *) kmalloc(elf_ppnt->p_filesz,
+			elf_interpreter = kmalloc(elf_ppnt->p_filesz,
 							   GFP_KERNEL);
 			if (!elf_interpreter)
 				goto out_free_file;
--- linux-2.6.15-rc5-git1-orig/fs/binfmt_elf_fdpic.c	2005-12-04 18:48:36.000000000 +0100
+++ linux-2.6.15-rc5-git1/fs/binfmt_elf_fdpic.c	2005-12-11 19:26:41.000000000 +0100
@@ -187,7 +187,7 @@ static int load_elf_fdpic_binary(struct 
 				goto error;
 
 			/* read the name of the interpreter into memory */
-			interpreter_name = (char *) kmalloc(phdr->p_filesz, GFP_KERNEL);
+			interpreter_name = kmalloc(phdr->p_filesz, GFP_KERNEL);
 			if (!interpreter_name)
 				goto error;
 
