Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272997AbTHPPAc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273000AbTHPPAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:00:32 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:40147 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272997AbTHPPA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:00:26 -0400
Date: Sat, 16 Aug 2003 17:00:36 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: jeff millar <wa1hco@adelphia.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 _still_ cannot mount root fs
Message-ID: <20030816150036.GA23277@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: jeff millar <wa1hco@adelphia.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030813061546.GB24994@gamma.logic.tuwien.ac.at> <00ac01c36193$72c892a0$6401a8c0@wa1hco> <20030813123010.GA7274@www.13thfloor.at> <00bb01c36198$51cba650$6401a8c0@wa1hco> <20030813132429.GA7551@www.13thfloor.at> <009b01c362d5$13838b90$6401a8c0@wa1hco> <20030815030013.GA9587@www.13thfloor.at> <00a401c3632a$80dd2a20$6401a8c0@wa1hco> <20030815132619.GB3695@www.13thfloor.at> <000a01c3638e$2c7a6330$6401a8c0@wa1hco>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <000a01c3638e$2c7a6330$6401a8c0@wa1hco>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jeff!

On Fri, Aug 15, 2003 at 08:34:37PM -0400, jeff millar wrote:
> Redhat's 2.4.20 will boot with root=/dev/hda3 pointing to an ext3
> filesystem, without an initrd, with the following message
> 
>    ext2fs warning (device IDE0(3,3) )  ext2_read_super: mounting ext3
> filesystem as ext2
>    VFS: mounted root (ext2 filesystem) readonly
> 
> So I assumed that 2.6.0-test3 will also work with ext3 compiled as a module.
> I tried the various suggestions root=/dev/hda3, root=0303, root=03:03
> without any luck.
> 
> I then tested a suggestion that ext3 should get compiled in but get the same
> results
> 
> Herbert's debug patch produced the same messages with ext3 compiled in.
> 
> Any suggestions for what to try next?

appended a short patch, which goes ontop of my other
debug patch ... this time, please concentrate on the
%% lines and the lines immediately above and below ...

best,
Herbert

> jeff

--- linux-2.6.0-test3-debug/init/do_mounts.c	2003-08-13 15:15:23.000000000 +0200
+++ linux-2.6.0-test3-debug-P1/init/do_mounts.c	2003-08-16 16:57:02.000000000 +0200
@@ -277,7 +277,11 @@
 	get_fs_names(fs_names);
 retry:
 	for (p = fs_names; *p; p += strlen(p)+1) {
-		int err = do_mount_root(name, p, flags, root_mount_data);
+                int err;
+                
+                printk("%%%% do_mount_root() >%s<,>%s<, %08x ...\n", name, p, flags);
+                err = do_mount_root(name, p, flags, root_mount_data);
+                printk("%%%% ret = %d\n", err);
 		switch (err) {
 			case 0:
 				goto out;

