Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWEOAHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWEOAHg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 20:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWEOAHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 20:07:36 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:18315
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751416AbWEOAHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 20:07:35 -0400
From: Rob Landley <rob@landley.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Which process context does /sbin/hotplug run in?
Date: Sun, 14 May 2006 20:08:39 -0400
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200605121421.00044.rob@landley.net> <F68E5CEA-AB95-4E1C-9923-0882394AE16E@mac.com>
In-Reply-To: <F68E5CEA-AB95-4E1C-9923-0882394AE16E@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605142008.39420.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 May 2006 3:24 am, Kyle Moffett wrote:
> /
>    /var
>      /var/sub
>      /var/sub2
>        /var/sub2/sub
>        /var/sub2/sub2
>
> The recursion ends there.  Basically with the first bind mount you
> attach the same instance of tmpfs to /tmp and /var, then you move the
> tmpfs from /tmp to the "/sub2" directory in the "/var" tmpfs
> _mountpoint_.  It's kind of confusing behavior; but the directory
> tree and the mount tree are basically kind of separate entities in a
> sense.

I can CD into them endlessly, and both "ls -lR" and "find ." report cycles in 
the tree, which surprised me that they had a specific error message for that, 
actually.  Good enough for me. :)

And I'm not _complaining_ about it.  Just fiddling around with fun stuff.  If 
I get really bored I'll figure a way to split the tree so there are two 
completely unconnected mount trees in different processes.  (Get a private 
namespace that's chrooted into something that somebody else does a umount -l 
on from their space.  Or without using umount -l, just have two processes 
chroot into other mount points which should theoretically garbage collect the 
old root if no processes still references it, which presumably means one of 
the processes is init...)

Don't mind me, I do this for fun.

Rob
-- 
Never bet against the cheap plastic solution.
