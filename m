Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271007AbTG1DeL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 23:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272599AbTG1DeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 23:34:11 -0400
Received: from dm4-157.slc.aros.net ([66.219.220.157]:55712 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S271007AbTG1DeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 23:34:10 -0400
Message-ID: <3F249D42.4010003@aros.net>
Date: Sun, 27 Jul 2003 21:49:22 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix 2 byte data leak due to padding
References: <200307272019.h6RKJ1Et029763@hraefn.swansea.linux.org.uk>
In-Reply-To: <200307272019.h6RKJ1Et029763@hraefn.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/fs/stat.c linux-2.6.0-test2-ac1/fs/stat.c
>--- linux-2.6.0-test2/fs/stat.c	2003-07-14 14:11:56.000000000 +0100
>+++ linux-2.6.0-test2-ac1/fs/stat.c	2003-07-23 16:27:42.000000000 +0100
>@@ -106,7 +106,7 @@
> {
> 	static int warncount = 5;
> 	struct __old_kernel_stat tmp;
>-
>+	
> 	if (warncount > 0) {
> 		warncount--;
> 		printk(KERN_WARNING "VFS: Warning: %s using old stat() call. Recompile your binary.\n",
>@@ -116,6 +116,7 @@
> 		warncount = 0;
> 	}
> 
>+	memset(&tmp, 0, sizeof(struct __old_kernel_stat));
>
Wouldn't it be more clear (better) to use sizeof(tmp) here rather than 
sizeof(struct _old_kernel_stat)?

