Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVIDEUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVIDEUH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 00:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVIDEUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 00:20:06 -0400
Received: from smtp.istop.com ([66.11.167.126]:7622 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1750949AbVIDEUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 00:20:05 -0400
From: Daniel Phillips <phillips@istop.com>
To: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Date: Sun, 4 Sep 2005 00:22:36 -0400
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-cluster@redhat.com,
       wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <20050903183241.1acca6c9.akpm@osdl.org> <20050904030640.GL8684@ca-server1.us.oracle.com>
In-Reply-To: <20050904030640.GL8684@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509040022.37102.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 September 2005 23:06, Joel Becker wrote:
>  dlmfs is *tiny*.  The VFS interface is less than his claimed 500
> lines of savings.

It is 640 lines.

> The few VFS callbacks do nothing but call DLM 
> functions.  You'd have to replace this VFS glue with sysfs glue, and
> probably save very few lines of code.
>  In addition, sysfs cannot support the dlmfs model.  In dlmfs,
> mkdir(2) creates a directory representing a DLM domain and mknod(2)
> creates the user representation of a lock.  sysfs doesn't support
> mkdir(2) or mknod(2) at all.

I said "configfs" in the email to which you are replying.

>  More than mkdir() and mknod(), however, dlmfs uses open(2) to
> acquire locks from userspace.  O_RDONLY acquires a shared read lock (PR
> in VMS parlance).  O_RDWR gets an exclusive lock (X).  O_NONBLOCK is a
> trylock.  Here, dlmfs is using the VFS for complete lifetiming.  A lock
> is released via close(2).  If a process dies, close(2) happens.  In
> other words, ->release() handles all the cleanup for normal and abnormal
> termination.
>
>  sysfs does not allow hooking into ->open() or ->release().  So
> this model, and the inherent lifetiming that comes with it, cannot be 
> used.

Configfs has a per-item release method.  Configfs has a group open method.  
What is it that configfs can't do, or can't be made to do trivially?

> If dlmfs was changed to use a less intuitive model that fits 
> sysfs, all the handling of lifetimes and cleanup would have to be added.

The model you came up with for dlmfs is beyond cute, it's downright clever.  
Why mar that achievement by then failing to capitalize on the framework you 
already have in configfs?

By the way, do you agree that dlmfs is too inefficient to be an effective way 
of exporting your dlm api to user space, except for slow-path applications 
like you have here?

Regards,

Daniel
