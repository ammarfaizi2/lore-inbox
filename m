Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVBHS5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVBHS5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 13:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVBHS5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 13:57:31 -0500
Received: from gprs215-10.eurotel.cz ([160.218.215.10]:53970 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261627AbVBHS51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 13:57:27 -0500
Date: Tue, 8 Feb 2005 18:51:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: Kylix application no longer works?
Message-ID: <20050208175106.GA1091@elf.ucw.cz>
References: <20050207221107.GA1369@elf.ucw.cz> <20050207145100.6208b8b9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207145100.6208b8b9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I wonder if reverting the patch will restore the old behaviour?

This seems to be minimal fix to get Kylix application back to the
working state... Maybe it is good idea for 2.6.11?

Signed-off-by: Pavel Machek <pavel@suse.cz>
								Pavel

--- clean/fs/binfmt_elf.c	2005-02-03 22:27:19.000000000 +0100
+++ linux/fs/binfmt_elf.c	2005-02-08 18:46:38.000000000 +0100
@@ -803,11 +803,8 @@
 				nbyte = ELF_MIN_ALIGN - nbyte;
 				if (nbyte > elf_brk - elf_bss)
 					nbyte = elf_brk - elf_bss;
-				if (clear_user((void __user *) elf_bss + load_bias, nbyte)) {
-					retval = -EFAULT;
-					send_sig(SIGKILL, current, 0);
-					goto out_free_dentry;
-				}
+				if (clear_user((void __user *) elf_bss + load_bias, nbyte))
+					printk(KERN_ERR "Error clearing BSS, wrong ELF executable? (Kylix?!)\n");
 			}
 		}
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
