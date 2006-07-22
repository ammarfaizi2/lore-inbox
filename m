Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWGVGWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWGVGWk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 02:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWGVGWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 02:22:40 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:2436 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932075AbWGVGWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 02:22:39 -0400
Date: Sat, 22 Jul 2006 09:22:37 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: alan@lxorguk.ukuu.org.uk, tytso@mit.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
In-Reply-To: <20060721171922.602706f9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0607220918070.13537@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0607201504040.18901@sbz-30.cs.Helsinki.FI>
 <20060721171922.602706f9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2006 15:07:30 +0300 (EEST)
Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > This patch implements the revoke(2) and frevoke(2) system calls for all
> > types of files.
> >
> > ...
> >
> > -	file = fget_light(fd, &fput_needed);
> > +	file = fget(fd);
 
On Fri, 21 Jul 2006, Andrew Morton wrote:
> This is sad.

There are alternatives, playing games with ->f_op, creating fake struct 
file, and doing IS_REVOKED if-else in the paths, but I think this is by 
far the simplest way to do it. So in the Andrew scale of sads, how 
sad is it, exactly?-)
 
On Thu, 20 Jul 2006 15:07:30 +0300 (EEST)
Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > +static int revoke_files(struct task_struct *owner, struct inode *inode,
> > +			struct file *exclude, struct list_head *to_close)
> > +{
> > ...
> > +	spin_lock(&files->file_lock);
> > ...
> > +		revoked = kmalloc(sizeof(*revoked), GFP_KERNEL);
 
On Fri, 21 Jul 2006, Andrew Morton wrote:
> This is bad.

Indeed, I'll come up with a better one as soon as I sort out the mmap 
takedown issues.

Thanks Andrew.

					Pekka
