Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132134AbQLQWmf>; Sun, 17 Dec 2000 17:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132497AbQLQWmY>; Sun, 17 Dec 2000 17:42:24 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3076 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132134AbQLQWmK>;
	Sun, 17 Dec 2000 17:42:10 -0500
Message-ID: <20001217231107.C474@bug.ucw.cz>
Date: Sun, 17 Dec 2000 23:11:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: recursive exports && linux nfs
In-Reply-To: <20001212103652.A13501@cerebro.laendle> <20001215235446.H9506@bug.ucw.cz> <20001217104242.B9034@fuji.laendle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001217104242.B9034@fuji.laendle>; from Marc Lehmann on Sun, Dec 17, 2000 at 10:42:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 2) using: I can do cd /nfs/fs, but the directoy is always empty, and when I
> > >    try to step into a subdirectory I always get "No such file or directory".
> > > 
> > > Thanks a lot for any insights, even if this means "this is not supported"
> > > ;)
> > 
> > This can't be supported, afaict, because nfs handles have limited
> > size.
> 
> Ehrm, did you really read my mail? Most people told me something like
> "recursive exports are not supported" (actually, they are and they work),
> and it seems nobody really read what I wrote :(

They do not work too well. They break guarantee that handles are
persistent across reboots. Recursive exports are huge kludge. They
have to be.

[Sorry, I did not read your mail too carefully]

> My problem is that autofs doesn't work. Example:
> 
> /	reiserfs
> /fs	autofs
> /fs/big	ext2
> 
> When I exportfs /, /fs AND /fs/big then I can mount /fs on another box,
> but it is always empty, even if something (e.g. /fs/big) is mounted and
> can be accessed fine the whole time. Automounting doesn't work, either, of
> course.
> 
> Another (less grave) problem is that exportfs (and/or rpc.nfsd) require
> network access and access to the volume, so they a) mount all automounted
> directories (VERY expensive) and require network access (making all
> clients NOT survive a reboot).
> 

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
