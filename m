Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTHTRYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbTHTRYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:24:16 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:10765 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262108AbTHTRYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:24:12 -0400
Date: Wed, 20 Aug 2003 19:24:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
Message-ID: <20030820192409.A2868@pclin040.win.tue.nl>
References: <3F4268C1.9040608@redhat.com> <shszni499e9.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shszni499e9.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Aug 19, 2003 at 10:37:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 10:37:50PM -0700, Trond Myklebust wrote:
> >>>>> " " == Ulrich Drepper <drepper@redhat.com> writes:
> 
>      > The result is always, 100% of the time, a failure in ftruncate.
>      > The kernel reports ESTALE.  This has not been a problem in 2.4
>      > and not even in 2.6 until <mumble> months ago.  And of course
>      > it works with local disks.
> 
> There are known bugs in the way we handle readdirplus. That's why it
> only hits NFSv3. Does the following patch fix it?

> +out_zap_parent:
> +	nfs_zap_caches(dir);

I don't think it will. My analysis of yesterday night was:
- no silly rename is done
- this is because d_count equals 1
- this is because we have two different dentries for the same file
- this is caused by the fragment

        /* If we're doing an exclusive create, optimize away the lookup */
        if (nfs_is_exclusive_create(dir, nd))
                return NULL;

in nfs/dir.c.
Do you agree?

Andries


[but I do not understand all details yet]
[may look at it again this evening if you don't tell us what happens]

