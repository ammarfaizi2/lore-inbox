Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267993AbUHPWnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267993AbUHPWnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUHPWnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:43:23 -0400
Received: from cantor.suse.de ([195.135.220.2]:48040 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267994AbUHPWnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:43:05 -0400
Date: Tue, 17 Aug 2004 00:39:38 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: /bin/ls: cannot read symbolic link /proc/$$/exe: Permission denied
Message-ID: <20040816223938.GA9133@suse.de>
References: <20040816133730.GA6463@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040816133730.GA6463@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Aug 16, Olaf Hering wrote:

> 
> For some reasons ls -l /proc/$$/exe doesnt work all time for me,
> with 2.6.8.1 on ppc64. Sometimes it does, sometimes not. No pattern.
> A few printks show that this check in proc_pid_readlink() triggers
> an -EACCES:
> 
>         current->fsuid != inode->i_uid
> 
> proc_pid_readlink(755) error -13 ntptrace(11408) fsuid 100 i_uid 0 0
> sys_readlink(281) ntptrace(11408) error -13 readlink

A better one, clear both new fields, just in case.


diff -p -purN linux-2.6.8.1.omfg/fs/compat.c linux-2.6.8.1/fs/compat.c
--- linux-2.6.8.1.omfg/fs/compat.c	2004-08-14 12:55:31.000000000 +0200
+++ linux-2.6.8.1/fs/compat.c	2004-08-17 00:33:36.000000000 +0200
@@ -1390,6 +1390,8 @@ int compat_do_execve(char * filename,
 	bprm.sh_bang = 0;
 	bprm.loader = 0;
 	bprm.exec = 0;
+	bprm.interp_flags = 0;
+	bprm.interp_data = 0;
 	bprm.security = NULL;
 	bprm.mm = mm_alloc();
 	retval = -ENOMEM;

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
