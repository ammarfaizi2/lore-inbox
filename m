Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWGVG7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWGVG7t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 02:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWGVG7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 02:59:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27858 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751288AbWGVG7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 02:59:48 -0400
Date: Fri, 21 Jul 2006 23:59:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: alan@lxorguk.ukuu.org.uk, tytso@mit.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
Message-Id: <20060721235931.e8336001.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0607220918070.13537@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0607201504040.18901@sbz-30.cs.Helsinki.FI>
	<20060721171922.602706f9.akpm@osdl.org>
	<Pine.LNX.4.58.0607220918070.13537@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006 09:22:37 +0300 (EEST)
Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:

> On Thu, 20 Jul 2006 15:07:30 +0300 (EEST)
> Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > > This patch implements the revoke(2) and frevoke(2) system calls for all
> > > types of files.
> > >
> > > ...
> > >
> > > -	file = fget_light(fd, &fput_needed);
> > > +	file = fget(fd);
>  
> On Fri, 21 Jul 2006, Andrew Morton wrote:
> > This is sad.
> 
> There are alternatives, playing games with ->f_op, creating fake struct 
> file, and doing IS_REVOKED if-else in the paths, but I think this is by 
> far the simplest way to do it. So in the Andrew scale of sads, how 
> sad is it, exactly?-)

Sad enough.  Certainly worth an if-else to fix.

> On Thu, 20 Jul 2006 15:07:30 +0300 (EEST)
> Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > > +static int revoke_files(struct task_struct *owner, struct inode *inode,
> > > +			struct file *exclude, struct list_head *to_close)
> > > +{
> > > ...
> > > +	spin_lock(&files->file_lock);
> > > ...
> > > +		revoked = kmalloc(sizeof(*revoked), GFP_KERNEL);
>  
> On Fri, 21 Jul 2006, Andrew Morton wrote:
> > This is bad.
> 
> Indeed, I'll come up with a better one as soon as I sort out the mmap 
> takedown issues.
> 

Why is this approach so different from Tigran's, I wonder.

iirc, one of the things we added file.f_mapping for was revokation, but
this patch doesn't use it.  Please ask Al Viro about this.
