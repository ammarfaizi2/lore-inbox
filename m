Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263261AbVFXLDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263261AbVFXLDt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbVFXK6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:58:48 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:9882 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263247AbVFXK5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:57:00 -0400
Date: Fri, 24 Jun 2005 16:24:10 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] files: change fd_install assertion
Message-ID: <20050624105410.GE4804@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050624105011.GB4804@in.ibm.com> <20050624105209.GC4804@in.ibm.com> <20050624105318.GD4804@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624105318.GD4804@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Change the fds[fd] != NULL check in fd_install() to be a BUG_ON.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 fs/open.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN fs/open.c~change-fd-install-assert fs/open.c
--- linux-2.6.12-mm1-fix/fs/open.c~change-fd-install-assert	2005-06-25 16:43:02.000000000 +0530
+++ linux-2.6.12-mm1-fix-dipankar/fs/open.c	2005-06-25 16:43:02.000000000 +0530
@@ -931,8 +931,7 @@ void fastcall fd_install(unsigned int fd
 	struct fdtable *fdt;
 	spin_lock(&files->file_lock);
 	fdt = files_fdtable(files);
-	if (unlikely(fdt->fd[fd] != NULL))
-		BUG();
+	BUG_ON(fdt->fd[fd] != NULL);
 	rcu_assign_pointer(fdt->fd[fd], file);
 	spin_unlock(&files->file_lock);
 }

_
