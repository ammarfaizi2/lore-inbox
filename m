Return-Path: <linux-kernel-owner+w=401wt.eu-S1760762AbWLHQZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760762AbWLHQZ0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760761AbWLHQZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:25:26 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:37165 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760759AbWLHQZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:25:25 -0500
Date: Fri, 8 Dec 2006 11:25:23 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jeff Layton <jlayton@poochiereds.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] ensure unique i_ino in filesystems without permanent inode numbers (libfs superblock cleanup)
Message-ID: <20061208162523.GB17707@filer.fsl.cs.sunysb.edu>
References: <457891F4.8030501@redhat.com> <20061208061641.GA24255@filer.fsl.cs.sunysb.edu> <457963B3.3080801@poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457963B3.3080801@poochiereds.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 08:08:03AM -0500, Jeff Layton wrote:
> Josef Sipek wrote:
> >> -	ret = simple_fill_super(sb, IPATHFS_MAGIC, files);
> >> +	ret = simple_fill_super(sb, IPATHFS_MAGIC, files, 1);
> >
> > I don't know...the magic looking 1 and 0 (later in the patch) seem a bit
> > arbitrary. Maybe a #define is in order?
> 
> Yeah, I'm not fond of that, though the comments on simple_fill_super should
> explain it. Basically, I need simple_fill_super to operate in two different
> "modes", and I was using the extra flag to key this. I'm not clear on what
> sort of #define would make sense here. Can you suggest something?
 
First I was thinking about defining 2 constats, but maybe the better thing
to do would be to

1) rename simple_fill_super to __simple_fill_super
2) #define simple_fill_super_foo(...) to __siple_fill_super(....., 0)
3) #define simple_fill_super_bar(...) to __siple_fill_super(....., 1)

(Or equivalent thing using inline functions.)
 
I can't really think of any good name for #define'd flag.

Beware, I'm pretty much just thinking out loud.. :)
 
> >> @@ -399,7 +407,10 @@ int simple_fill_super(struct super_block
> >>  		inode->i_blocks = 0;
> >>  		inode->i_atime = inode->i_mtime = inode->i_ctime =
> >>  		CURRENT_TIME;
> >
> > I'd indent CURRENT_TIME a bit.
> 
> I wasn't planning on touching those parts of the code that don't need to be
> changed, since formatting deltas can make it harder to see the "actual"
> changes in the patch. That should probably be addressed in a follow-on
> patch if you think it needs to be changed.

Oh, sorry, that wasn't your code. You're right about it not being the the
right thing to fix in your patch.

Actually, it looks like another problem created by line-wrapping.

Josef "Jeff" Sipek.

-- 
NT is to UNIX what a doughnut is to a particle accelerator.
