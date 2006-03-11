Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752084AbWCKIE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbWCKIE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 03:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbWCKIE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 03:04:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38331 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752084AbWCKIE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 03:04:57 -0500
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: garloff@suse.de, linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20060310235103.4e9c9457.akpm@osdl.org>
References: <20060310155738.GL5766@tpkurt.garloff.de>
	 <20060310145605.08bf2a67.akpm@osdl.org>
	 <1142061816.3055.6.camel@laptopd505.fenrus.org>
	 <20060310234155.685456cd.akpm@osdl.org>
	 <1142063254.3055.9.camel@laptopd505.fenrus.org>
	 <20060310235103.4e9c9457.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 09:04:54 +0100
Message-Id: <1142064294.3055.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 23:51 -0800, Andrew Morton wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > 
> > > 
> > > > but yeah by this time we should just bite the bullet and rename the
> > > > variable rather than move it about
> > > 
> > > That wouldn't help - we'll still break existing scripts.
> > 
> > why? (I mean the KERN_ to FS_ rename in the kernel, that's not exported
> > to userland anywhere)
> 
> oic.  What are you expecting here?  Reading skills?

lesson to self: only speak in diff -u form before morning coffee


the setuid-dumpable sysctl got misplaces due to a patch glitch. But it's
part of the ABI now for some time so we need to keep it. This patch at
least renames the variable inside the kernel to match the new place, and
puts a comment in place to indicate that it's a known glitch

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

diff -purN linux-2.6.16-rc5/include/linux/sysctl.h linux-2.6.16-rc5-setuid/include/linux/sysctl.h
--- linux-2.6.16-rc5/include/linux/sysctl.h	2006-02-27 09:13:31.000000000 +0100
+++ linux-2.6.16-rc5-setuid/include/linux/sysctl.h	2006-03-11 09:02:13.000000000 +0100
@@ -144,7 +144,6 @@ enum
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
-	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 };
@@ -759,6 +758,9 @@ enum
 	FS_AIO_NR=18,	/* current system-wide number of aio requests */
 	FS_AIO_MAX_NR=19,	/* system-wide maximum number of aio requests */
 	FS_INOTIFY=20,	/* inotify submenu */
+			/* Note: the following got misplaced but this mistake is 
+			   now part of the ABI */
+	FS_SETUID_DUMPABLE=21, /* int: behaviour of dumps for setuid core */
 };
 
 /* /proc/sys/fs/quota/ */
diff -purN linux-2.6.16-rc5/kernel/sysctl.c linux-2.6.16-rc5-setuid/kernel/sysctl.c
--- linux-2.6.16-rc5/kernel/sysctl.c	2006-02-27 09:13:31.000000000 +0100
+++ linux-2.6.16-rc5-setuid/kernel/sysctl.c	2006-03-11 09:01:19.000000000 +0100
@@ -1022,7 +1022,7 @@ static ctl_table fs_table[] = {
 #endif	
 #endif
 	{
-		.ctl_name	= KERN_SETUID_DUMPABLE,
+		.ctl_name	= FS_SETUID_DUMPABLE,
 		.procname	= "suid_dumpable",
 		.data		= &suid_dumpable,
 		.maxlen		= sizeof(int),


