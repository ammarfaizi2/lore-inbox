Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUDCAt5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 19:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUDCAt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 19:49:57 -0500
Received: from mail.shareable.org ([81.29.64.88]:23702 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261462AbUDCAt4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 19:49:56 -0500
Date: Sat, 3 Apr 2004 01:49:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040403004947.GI653@mail.shareable.org>
References: <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <406DE280.6050109@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406DE280.6050109@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Could you not change it back to a normal inode when refcount becomes 1? 

You can only do that if the cowid object has a pointer to the last
remaining reference to it.  That's possible, but more complicated and
would incur a little more I/O per cow operation.

> Or if you didn't want to do that always (say if you knew there would 
> be more references being created soon) you could at least have some kind 
> of cleanup tool that you could manually run on a filesystem to clean it up?

fsck could do it.  It's not a big deal though: simply looking up the
inode through the last remaining path can also clean it up.  Until
them, it's very little space used: the same as a short symlink.

-- Jamie
