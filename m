Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbTEQLZG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 07:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTEQLZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 07:25:06 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:41235 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261417AbTEQLZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 07:25:05 -0400
Date: Sat, 17 May 2003 04:39:46 -0700
From: Andrew Morton <akpm@digeo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: c-d.hailfinger.kernel.2003@gmx.net, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.69-mm6: pccard oops while booting: round 2
Message-Id: <20030517043946.421c8f4a.akpm@digeo.com>
In-Reply-To: <1053169552.613.1.camel@teapot.felipe-alfaro.com>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	<20030514191735.6fe0998c.akpm@digeo.com>
	<1052998601.726.1.camel@teapot.felipe-alfaro.com>
	<20030515130019.B30619@flint.arm.linux.org.uk>
	<1053004615.586.2.camel@teapot.felipe-alfaro.com>
	<20030515144439.A31491@flint.arm.linux.org.uk>
	<1053037915.569.2.camel@teapot.felipe-alfaro.com>
	<20030515160015.5dfea63f.akpm@digeo.com>
	<1053090184.653.0.camel@teapot.felipe-alfaro.com>
	<1053110098.648.1.camel@teapot.felipe-alfaro.com>
	<20030516132908.62e54266.akpm@digeo.com>
	<1053121346.569.1.camel@teapot.felipe-alfaro.com>
	<3EC56173.1000306@gmx.net>
	<1053166275.586.9.camel@teapot.felipe-alfaro.com>
	<20030517031840.486683fc.akpm@digeo.com>
	<1053169552.613.1.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 May 2003 11:37:53.0807 (UTC) FILETIME=[C11521F0:01C31C68]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> Unable to handle kernel paging request at virtual address fceec0d7
>  printing eip:
> c016954f
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c016954f>]     Not tainted VLI
> EFLAGS: 00010246
> EIP is at sys_create_link+0xcf/0x130

bah.   That's totally different :(

But there seems to be a bug in there.

--- 25/fs/sysfs/symlink.c~sysfs_create_link-fix	2003-05-17 04:34:50.000000000 -0700
+++ 25-akpm/fs/sysfs/symlink.c	2003-05-17 04:34:56.000000000 -0700
@@ -80,7 +80,7 @@ int sysfs_create_link(struct kobject * k
 	char * s;
 
 	depth = object_depth(kobj);
-	size = object_path_length(target) + depth * 3 - 1;
+	size = object_path_length(target) + depth * 3 + 1;
 	if (size > PATH_MAX)
 		return -ENAMETOOLONG;
 	pr_debug("%s: depth = %d, size = %d\n",__FUNCTION__,depth,size);




That probably won't fix it though.

