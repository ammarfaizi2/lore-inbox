Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVA3H4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVA3H4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 02:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVA3H4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 02:56:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:39903 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261649AbVA3H4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 02:56:53 -0500
Date: Sat, 29 Jan 2005 23:56:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Blazejowski <diffie@gmail.com>
Cc: linux-kernel@vger.kernel.org, Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc2-mm2
Message-Id: <20050129235653.1d9ba5a9.akpm@osdl.org>
In-Reply-To: <9dda349205012923347bc6a456@mail.gmail.com>
References: <9dda349205012923347bc6a456@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Blazejowski <diffie@gmail.com> wrote:
>
> Kernel compile errors here, i think this might be XFS related...
> 
>  fs/built-in.o(.text+0x52a93): In function `linvfs_decode_fh':
>  : undefined reference to `find_exported_dentry'
>  make: *** [.tmp_vmlinux1] Error 1

bix:/home/akpm> grep EXPORT x
CONFIG_XFS_EXPORT=y
CONFIG_EXPORTFS=m

That isn't going to work.  Something like this, perhaps?

--- 25/fs/xfs/Kconfig~a	2005-01-29 23:55:53.643674392 -0800
+++ 25-akpm/fs/xfs/Kconfig	2005-01-29 23:56:26.435689248 -0800
@@ -22,7 +22,8 @@ config XFS_FS
 
 config XFS_EXPORT
 	bool
-	default y if XFS_FS && EXPORTFS
+	depends on XFS_FS
+	select EXPORTFS
 
 config XFS_RT
 	bool "Realtime support (EXPERIMENTAL)"
_

