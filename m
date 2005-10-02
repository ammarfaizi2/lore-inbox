Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVJBWIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVJBWIu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 18:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVJBWIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 18:08:50 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:25357 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750726AbVJBWIu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 18:08:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Jx35qFsiUx+RyDGEb1zQZGrpx2pxsplurXnKove+zmu5es3BHU4tcVXTYEfM3lxmqHPNnwoUAsGDR4wBVhydOx6tTLr5AU2DM38D/DU3idZ/n2/QDfHl+pockAoncaxIvX/NGcp8qX18e59fUHOYUIuc3tJkiNDGM0wm7qr375Q=
Message-ID: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com>
Date: Sun, 2 Oct 2005 15:08:49 -0700
From: David Leimbach <leimy2k@gmail.com>
Reply-To: David Leimbach <leimy2k@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: /etc/mtab and per-process namespaces
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been just playing around with the v9fs work and private
namespaces from yesterday's [October 1, 2005] top of tree from Linus'
git archive and I was looking at /etc/mtab's reaction to having
multiple namespaces with bind mounts.

I have a directory ("slash") and bind it to "/" in a new namespace
created with a clone call.  /etc/mtab then has a line appended to it
for this bind.

/ /home/dave/slash none rw,bind 0 0

Then in the "global default" namespace I do the same thing.  This adds
yet another line to my /etc/mtab with exactly the same contents.

I then exited both shells and /etc/mtab is left with both lines:

/ /home/dave/slash none rw,bind 0 0
/ /home/dave/slash none rw,bind 0 0

Did I just "leak" a namespace or is mtab just way off from reality now?

Also, if I check the procfs it seems to have no record of either of
these binds ever occurring.  [/proc/mounts]

Also, does it make sense to even think about adding a pid column
number for the "private" namespaces or perhaps just to mark it as
"priv" or something to that effect.

It's not clear to me what the best way to deal with this would be. 
Right now it appears to be broken or at least very inconsistent.

I can think of a lot of ways to use private namespaces to avoid
conflicts with software installations... much like the DragonFlyBSD
folks use variant symlinks to have two-level data about what version
of libx libx.so links to.  I just think private namespaces make this a
bit more elegant to handle, especially in the context of Xen and
upcoming virtualization hardware from Intel and AMD.  As such I find
this feature of linux [and Plan 9/Inferno - where it came from] to be
pretty important.


- Dave
