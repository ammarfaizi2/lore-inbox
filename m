Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbQLQKPT>; Sun, 17 Dec 2000 05:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbQLQKPJ>; Sun, 17 Dec 2000 05:15:09 -0500
Received: from p3EE0A7C2.dip.t-dialin.net ([62.224.167.194]:21753 "EHLO
	mail.plan9.de") by vger.kernel.org with ESMTP id <S129733AbQLQKOx>;
	Sun, 17 Dec 2000 05:14:53 -0500
Date: Sun, 17 Dec 2000 10:42:42 +0100
From: Marc Lehmann <pcg@goof.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recursive exports && linux nfs
Message-ID: <20001217104242.B9034@fuji.laendle>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001212103652.A13501@cerebro.laendle> <20001215235446.H9506@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001215235446.H9506@bug.ucw.cz>; from pavel@suse.cz on Fri, Dec 15, 2000 at 11:54:46PM +0100
X-Operating-System: Linux version 2.2.18 (root@fuji) (gcc version pgcc-2.95.2 19991024 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 11:54:46PM +0100, Pavel Machek <pavel@suse.cz> wrote:
> > 2) using: I can do cd /nfs/fs, but the directoy is always empty, and when I
> >    try to step into a subdirectory I always get "No such file or directory".
> > 
> > Thanks a lot for any insights, even if this means "this is not supported"
> > ;)
> 
> This can't be supported, afaict, because nfs handles have limited
> size.

Ehrm, did you really read my mail? Most people told me something like
"recursive exports are not supported" (actually, they are and they work),
and it seems nobody really read what I wrote :(

My problem is that autofs doesn't work. Example:

/	reiserfs
/fs	autofs
/fs/big	ext2

When I exportfs /, /fs AND /fs/big then I can mount /fs on another box,
but it is always empty, even if something (e.g. /fs/big) is mounted and
can be accessed fine the whole time. Automounting doesn't work, either, of
course.

Another (less grave) problem is that exportfs (and/or rpc.nfsd) require
network access and access to the volume, so they a) mount all automounted
directories (VERY expensive) and require network access (making all
clients NOT survive a reboot).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
