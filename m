Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSHaPea>; Sat, 31 Aug 2002 11:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSHaPe3>; Sat, 31 Aug 2002 11:34:29 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:23562 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S317589AbSHaPe2>; Sat, 31 Aug 2002 11:34:28 -0400
Date: Sat, 31 Aug 2002 09:57:47 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Greg KH <greg@kroah.com>
Cc: Gabor Kerenyi <wom@tateyama.hu>, linux-kernel@vger.kernel.org,
       Chris Wright <chris@wirex.com>
Subject: Re: extended file permissions based on LSM
Message-ID: <20020831095747.A781@nightmaster.csn.tu-chemnitz.de>
References: <200208310616.04709.wom@tateyama.hu> <20020831052114.GA12082@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020831052114.GA12082@kroah.com>; from greg@kroah.com on Fri, Aug 30, 2002 at 10:21:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 10:21:14PM -0700, Greg KH wrote:
> On Sat, Aug 31, 2002 at 06:16:04AM +0200, Gabor Kerenyi wrote:
> > 
> > In this case we could have some very interesting (useful
> > or not who knows) features. For example if there are two
> > hardlinks for an inode in two different directories, the user
> > could get different rights for the file depending on the
> > path he reaches it.
> 
> I think you can already do this with the existing LSM interface, you can
> always get the dentry for a given inode, right?  

You get ALL dentries for the given inode. But I don't know,
whether such code traversion inode->i_dentry is valid in all situations.

Passing a dentry instead of inode is the easier variant, because
an dentry maps to exactly one inode, if it is a positive one[1]

The mapping from inode to dentries is 1:n and the thing the
poster wants is not possible with that, because the way the user
took to reach this inode is one of the n possibilities and we
don't know which one.

So this is a correctly pointed out design weakness: The way the
user took to reach the inode cannot be taken into account.

Regards

Ingo Oeser

[1] But we should never see permission checks for negative
   dentries, since you cannot access what's not there ;-)
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
