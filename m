Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWFUELe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWFUELe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 00:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWFUELe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 00:11:34 -0400
Received: from 1wt.eu ([62.212.114.60]:6665 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1750966AbWFUELd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 00:11:33 -0400
Date: Wed, 21 Jun 2006 06:05:57 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060621040557.GA13586@1wt.eu>
References: <20060618223736.GA4965@1wt.eu> <dmlb92lmehf2jufjuk8emmh63afqfmg5et@4ax.com> <20060619040152.GB2678@1wt.eu> <fvbc92higiliou420n3ctjfecdl5leb49o@4ax.com> <20060619080651.GA3273@1wt.eu> <20060619220405.GA16251@dmt> <20060619230007.GA6471@1wt.eu> <20060619234506.GA2763@dmt> <20060620222357.GA11862@1wt.eu> <4b6h92h0hvj929o5kas004jagjaiii8t0p@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b6h92h0hvj929o5kas004jagjaiii8t0p@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

On Wed, Jun 21, 2006 at 11:09:15AM +1000, Grant Coady wrote:

> >What puzzles me is how are we supposed to up(&nd.dentry->d_inode->i_sem) if
> >dentry->d_inode can become NULL ? simply by keeping a copy of it ? I thought
> >that the down() protected the whole thing, but may be that's stupid anyway.
> >I've been running rc1 without this patch for a few hours and during kernel
> >compiles without a problem, so I'm not sure about what to think about the
> >other changes which were apparently harmless too :-/
> 
> So what's the final fixup?  Last two patches don't seem to cause the 
> problems previously reported by me.  They don't play together though, 
> so I'll add my general sense of confusion to this issue ;)  

:-)
Marcelo's patch applies to sys_unlink(). It prevents sys_unlink() from
oopsing while releasing the inode's semaphore after vfs_unlink() has
nullified the inode pointer.

Mine did nearly the same within vfs_unlink(), where you got your original
oopses.

> Should I run the thing (which patch?) and compile a hundred kernels 
> or something to see what (if anything) breaks.  Shortest day of year 
> here, I don't mind running the test box as part of room heating :o)

If you want to heat your room, you should effectively apply both
patches, then run a hundred kernel compiles. Removing the "-pipe"
option to gcc would help a lot since it will have to create temp files.

> Thanks,
> Grant.

Thanks for your time,
Willy

