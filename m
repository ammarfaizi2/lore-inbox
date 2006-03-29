Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWC2UmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWC2UmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 15:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWC2UmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 15:42:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10817 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750839AbWC2UmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 15:42:23 -0500
Date: Wed, 29 Mar 2006 22:42:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060329204216.GB13476@suse.de>
References: <20060329122841.GC8186@suse.de> <442A8883.9060909@garzik.org> <Pine.LNX.4.64.0603291159150.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603291159150.15714@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, Linus Torvalds wrote:
> 
> 
> On Wed, 29 Mar 2006, Jeff Garzik wrote:
> > 
> > 1) What are the consequences of doing
> > 
> > 	if (f_op->splice_write)
> > 		f_op->splice_write(...);
> > 	else
> > 		generic_file_splice_write(...);
> > 
> > to cause sys_splice() to default to supported?
> 
> I'd actually much prefer a number of filesystems just adding he 
> "generic_file_splice_write()" thing. If it works for them (and it usually 
> will), it's a one-liner. And it won't do wrong things on filesystems that 
> have special rules (inode re-validate for networked filesystems etc).
> 
> > 2) Do you really have to test f_op itself for NULL?  Is that a stealth
> > closed-file check or something?  I would be surprised if f_op was ever really
> > NULL.
> 
> Hmm.. I agree that f_op probably should never be NULL (a struct file with 
> a NULL f_op is pretty useless), but it is a test that we historically have 
> had. So it's probably best to keep for consistency, and if somebody wants 
> to, they can clean up all the other tests too (in the read/write/lseek 
> paths).
> 
> I'm inclined to apply this patch (well, I'd like the fixed one). The whole 
> splice() thing has been rolling around in my head for years, and the pipe 
> support infrastructure for it has been around for over a year now in 
> preparation for this.
> 
> And the patch actually looks pretty clean to me.

Go ahead, as mentioned there are a few little extra fixes in the git
repo. The remaining changes I had in mind don't require anything
massive, so...

-- 
Jens Axboe

