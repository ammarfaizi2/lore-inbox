Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUIJDSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUIJDSP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUIJDSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:18:15 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:59884 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267625AbUIJDSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:18:12 -0400
Subject: Re: Major XFS problems...
From: Greg Banks <gnb@melbourne.sgi.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jakob Oestergaard <jakob@unthought.net>,
       Anando Bhattacharya <a3217055@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <16F6CCFE-02D6-11D9-B8B0-000393ACC76E@mac.com>
References: <20040908123524.GZ390@unthought.net>
	 <322909db040908080456c9f291@mail.gmail.com>
	 <20040908154434.GE390@unthought.net>
	 <1094661418.19981.36.camel@hole.melbourne.sgi.com>
	 <20040909140017.GP390@unthought.net>
	 <1094784025.19981.188.camel@hole.melbourne.sgi.com>
	 <16F6CCFE-02D6-11D9-B8B0-000393ACC76E@mac.com>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1094786694.19981.209.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 10 Sep 2004 13:24:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 13:04, Kyle Moffett wrote:
> On Sep 09, 2004, at 22:40, Greg Banks wrote:
> > Like I said, knfsd does unnatural things to the dcache.
> 
> Perhaps there needs to be a standard API that knfsd can use to do many
> of the (currently) non-standard dcache operations.  This would likely be
> useful for other kernel-level file-servers that would be useful to have
> (OpenAFS? Coda?).  Of course, I could just be totally ignorant of some
> nasty reason for the unstandardized hackery, but it doesn't hurt to
> ask. :-D

In 2.6 there is an API and knfsd code is less interwoven with dcache
internals.  In practice what this means is that the dcache code paths
which are only exercised by NFS move from NFS code into fs/dcache.c
and fs/exportfs/ and have a pretty wrapper but are not any less
unnatural or NFS-specific.  The problem is the need to convert an NFS
file handle off the wire (which contains an inode number) into a dentry.
This kind of bottom-up construction of dentry paths is *painful* as
the dcache really wants to grow from an fs root down.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


