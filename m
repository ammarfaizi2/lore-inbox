Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263580AbUEHLYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUEHLYh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 07:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbUEHLYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 07:24:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:42901 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263580AbUEHLYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 07:24:35 -0400
Date: Sat, 8 May 2004 04:24:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how long does it take to init the scheduler?
Message-Id: <20040508042410.68491878.akpm@osdl.org>
In-Reply-To: <20040508110959.GA1374@suse.de>
References: <20040508105311.GA15577@suse.de>
	<20040508035934.46101a9b.akpm@osdl.org>
	<20040508110959.GA1374@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> wrote:
>
> That leads to another question. usermodehelper_init() is now an initcall.
>  all the binfmt stuff is also an initcall. We had a patch (for debugging)
>  that turned init_elf_binfmt() into core_initcall.
>  Can we change that as well, so one could finally run stuff via the
>  driver hotplug events? init_script_binfmt() should be also
>  core_initcall, so you can run scripts. But I havent looked at the
>  dependencies for the binfmt stuff.



We may as well make usermodehelper_init() core_initcall as well, to make
sure its services are avaialble to all the other initcall levels.



diff -puN kernel/kmod.c~usermodehelper_init-use-core_initcall kernel/kmod.c
--- 25/kernel/kmod.c~usermodehelper_init-use-core_initcall	2004-05-08 04:22:23.119603600 -0700
+++ 25-akpm/kernel/kmod.c	2004-05-08 04:22:28.096846944 -0700
@@ -269,4 +269,4 @@ static __init int usermodehelper_init(vo
 	BUG_ON(!khelper_wq);
 	return 0;
 }
-__initcall(usermodehelper_init);
+core_initcall(usermodehelper_init);

_

