Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbSKGCiQ>; Wed, 6 Nov 2002 21:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbSKGCiP>; Wed, 6 Nov 2002 21:38:15 -0500
Received: from thunk.org ([140.239.227.29]:10659 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S266295AbSKGCiN>;
	Wed, 6 Nov 2002 21:38:13 -0500
Date: Wed, 6 Nov 2002 21:44:42 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alexander Viro <viro@math.psu.edu>
Cc: Christopher Li <chrisl@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix bug in ext3 htree rename: doesn't delete old name, leaves ino with bad nlink
Message-ID: <20021107024442.GA11010@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alexander Viro <viro@math.psu.edu>,
	Christopher Li <chrisl@vmware.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Ext2 devel <ext2-devel@lists.sourceforge.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20021106224112.GA10130@think.thunk.org> <Pine.GSO.4.21.0211061746410.10405-100000@steklov.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211061746410.10405-100000@steklov.math.psu.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 05:47:40PM -0500, Alexander Viro wrote:
> 
> HUH?
> 
> ->rename() holds ->i_sem on both directories.  So do all other directory
> methods.  What the hell is going on there?

What's going on is that had a brain-fart, and forgot about inode
semaphore that's held by the VFS layer.  Chris, sorry about that;
there is no need retry multiple times.  We only need to retry once, in
the case where the node gets split.

						- Ted

