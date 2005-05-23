Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVEWPEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVEWPEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVEWPEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:04:33 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:24070 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261733AbVEWPCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 11:02:52 -0400
To: raven@themaw.net
CC: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
	(raven@themaw.net)
Subject: Re: [VFS-RFC] autofs4 and bind, rbind and move mount requests
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
Message-Id: <E1DaERw-0002cC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 May 2005 17:02:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been investigating a bug report about bind mounting an autofs 
> controlled mount point. It is indeed disastrous for autofs. It would be 
> simple enough it to check and fail silently but that won't give sensible 
> behavior.
> 
> What should the semantics be for these type of mount requests against 
> autofs?
> 
> First, a move mount doesn't make sense as it places the autofs 
> filesystem in a location that is not specified in the autofs map to which 
> it belongs. It looks like the user space daemon would loose contact with 
> the newly mounted filesystem and so it would become useless and probably 
> not umountable, not to mention how the daemon would handle it. I believe 
> that this shouldn't be allowed. What do people think? If we don't treat 
> these as invalid then how should they behave?

Move is very similar to rbind + umount.  So if you find sane semantics
for the rbind case, that should do for move as well.

> Bind mount requests are another question.
> 
> In the case of a bind mount we can find ourselves with a dentry in the 
> bound filesystem that is marked as mounted but can't be followed 
> because the parent vfsmount is in the source filesystem.

I don't understand this.  A bind will just copy a vfsmount and add the
copy to some other place in the mount tree.  It should not matter if
the original mount was automounted or not.  What am I missing?

> Should the automount functionality go along with the bind mount 
> filesystem?

No.  With bind you copy the mount to another place.  Now it has
nothing to do with the automouter, it becomes a perfectly ordinary
mount.

Miklos
