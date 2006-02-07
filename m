Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWBGBSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWBGBSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWBGBSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:18:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36031 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932430AbWBGBSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:18:37 -0500
Date: Tue, 7 Feb 2006 12:17:56 +1100
From: David Chinner <dgc@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Jackson <pj@sgi.com>, ak@suse.de, clameter@engr.sgi.com,
       akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060207011756.GT43335175@melbourne.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602061811.49113.ak@suse.de> <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com> <200602061936.27322.ak@suse.de> <20060206184330.GA22275@elte.hu> <20060206120109.0738d6a2.pj@sgi.com> <20060206200506.GA13466@elte.hu> <20060206154537.a3e8cc25.pj@sgi.com> <20060207001902.GA18830@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207001902.GA18830@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 01:19:02AM +0100, Ingo Molnar wrote:
> 
> * Paul Jackson <pj@sgi.com> wrote:
> 
> > First it might be most useful to explain a detail of your proposal 
> > that I don't get, which is blocking me from considering it seriously.
> > 
> > I understand mount options, but I don't know what mechanisms (at the 
> > kernel-user API) you have in mind to manage per-directory and per-file 
> > options.
> 
> well, i thought of nothing overly complex: it would have to be a 
> persistent flag attached to the physical inode. Lets assume XFS added 
> this - e.g. as an extended attribute. That raw inode attribute/flag gets 
> inherited by dentries, and propagates down into child dentries.

XFS already has inheritable inode attributes, and they work in a
different (conflicting) manner. Currently when you set certain
attributes on a directory inode, then all directories and files
created within the directory inherit a certain attribute(s) at create
time. See xfsctl(3).

Having no flag set means to use the filesystem default, not "use
the parent config". Flags are also kept on the inode, not the
dentries. We should make sure that the interfaces do
not conflict.

>  - default: the vast majority of inodes would have no flag set
> 
>  - some would have a 'cache:local' flag
> 
>  - some would have a 'cache:global' flag

Easy to add to XFS and to propagate back to the linux inode if
you use the current semantics that XFS supports. How the
memory allocator works from there is up to you...

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
