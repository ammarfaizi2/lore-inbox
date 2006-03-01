Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWCAKoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWCAKoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWCAKoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:44:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932178AbWCAKoE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:44:04 -0500
Date: Wed, 1 Mar 2006 02:32:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
       mbligh@mbligh.org, clameter@engr.sgi.com, ebiederm@xmission.com
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060301023235.735c8c47.akpm@osdl.org>
In-Reply-To: <4405723E.5060606@free.fr>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard <laurent.riffard@free.fr> wrote:
>
> Le 01.03.2006 01:21, Andrew Morton a écrit :
>  > Laurent Riffard <laurent.riffard@free.fr> wrote:
>  > 
>  >>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000034
>  > 
>  > 
>  > I booted that thing on five machines, four architectures :(
>  > 
>  > Could people please test a couple more patchsets, see if we can isolate it?
>  > 
>  > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.1.gz
>  > 
>  > is 2.6.16-rc5-mm1 minus:
>  > 
>  > proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
>  > tref-implement-task-references.patch
>  > proc-dont-lock-task_structs-indefinitely.patch
>  > proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
>  > proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
>  > proc-optimize-proc_check_dentry_visible.patch
> 
>  Ok, 2.6.16-rc5-mm1.1 works for me:
>  - I can run java from command line in runlevel 1
>  - I can launch Mozilla in X

Useful, thanks.  So the second batch of /proc patches are indeed the problem.

If you have (even more) time you could test
http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz. 
That's the latest of everything with the problematic sysfs patches reverted
and Eric's recent /proc fixes.

