Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTHUA2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 20:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTHUA2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 20:28:08 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:54669
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id S262275AbTHUA2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 20:28:04 -0400
Message-ID: <3F441213.4060906@tupshin.com>
Date: Wed, 20 Aug 2003 17:28:03 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6 -- gnome problem
References: <3F4268C1.9040608@redhat.com> <shszni499e9.fsf@charged.uio.no> <20030820192409.A2868@pclin040.win.tue.nl> <16195.49464.935754.526386@charged.uio.no> <20030820215246.B3065@pclin040.win.tue.nl>
In-Reply-To: <20030820215246.B3065@pclin040.win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:

>It should be. But it isnt. I propose the following patch
>(with whitespace damage):
>
>diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfs/dir.c b/fs/nfs/dir.c
>--- a/fs/nfs/dir.c      Fri Jul 11 00:35:26 2003
>+++ b/fs/nfs/dir.c      Wed Aug 20 22:38:42 2003
>@@ -671,8 +671,10 @@
>        dentry->d_op = &nfs_dentry_operations;
> 
>        /* If we're doing an exclusive create, optimize away the lookup */
>-       if (nfs_is_exclusive_create(dir, nd))
>+       if (nfs_is_exclusive_create(dir, nd)) {
>+               d_add(dentry, NULL);
>                return NULL;
>+       }
> 
>        lock_kernel();
>        error = nfs_cached_lookup(dir, dentry, &fhandle, &fattr);
>
>Andries
>
>  
>
This patch makes the previously posted test work for me, but I'm 
experiencing a differenct NFS regression between 2.4 and 2.6. Whatever 
locking method that gnome2 is using when running home directories over 
nfs is failing when the client is running 2.6. Tried it again, using 
2.6.0-test3 + the above patch, and the results are the same. Gnome 
reports that it failed to lock it's test file, and aborts. It says that 
the error was "no locks available", but I'm not sure whether to believe 
that or not. The only differece is booting between 2.4.x and 2.6.x, and 
it doesn't matter whether the server is running 2.4 or 2.6. Any suggestions?

-Tupshin

