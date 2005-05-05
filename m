Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVEEPDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVEEPDD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVEEPDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:03:03 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:21477 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S262127AbVEEPCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:02:45 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm3
Date: Thu, 5 May 2005 16:59:37 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050504221057.1e02a402.akpm@osdl.org>
In-Reply-To: <20050504221057.1e02a402.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505051659.38341.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

build.log:

<snip>
fs/namei.c: In function `vfs_rename':
fs/namei.c:2177: warning: passing arg 1 of `fsnotify_oldname_init' from 
incompatible pointer type
</snip>

trivial fix for when !CONFIG_INOTIFY

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>

--- include/linux/fsnotify.h.orig	2005-05-05 15:56:41.000000000 +0200
+++ include/linux/fsnotify.h	2005-05-05 16:53:11.000000000 +0200
@@ -241,7 +241,7 @@ static inline void fsnotify_oldname_free
 
 #else	/* CONFIG_INOTIFY */
 
-static inline char *fsnotify_oldname_init(struct dentry *old_dentry)
+static inline char *fsnotify_oldname_init(const char *name)
 {
 	return NULL;
 }
