Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130899AbQLQLFd>; Sun, 17 Dec 2000 06:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131880AbQLQLFW>; Sun, 17 Dec 2000 06:05:22 -0500
Received: from tiku.hut.fi ([130.233.228.86]:59664 "EHLO tiku.hut.fi")
	by vger.kernel.org with ESMTP id <S130899AbQLQLFP>;
	Sun, 17 Dec 2000 06:05:15 -0500
Date: Sun, 17 Dec 2000 12:34:32 +0200 (EET)
From: Tuomas Heino <iheino@cc.hut.fi>
To: James Simmons <jsimmons@suse.com>
cc: Pavel Machek <pavel@suse.cz>,
        Frédéric L . W . Meunier 
	<0@pervalidus.net>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SysRq behavior
In-Reply-To: <Pine.LNX.4.21.0012111440460.296-100000@euclid.oak.suse.com>
Message-ID: <Pine.OSF.4.10.10012171228250.25720-100000@smaragdi.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, James Simmons wrote:

> > > When built into the Kernel, by only pressing the
> > > PrintScreen/SysRq the current application is terminated (tested
> > > on a console and GNU screen). Is this just me or I should
> > > expect it?

Well this should happen even when sysrq is NOT compiled into the kernel...

> > Probably bug. Happens for me, too, and it is pretty nasty.

Not a bug - just an easy-to-disable "feature" - read on ;)

> Just played with this bug. It doesn't kill a login shell but does any
> app running on it. I just went looking for where "Quit" is printed
> out. When I press SysRq Quit is printed on the command line. Any ideas?

Well that "print-screen" key is usually bound to ^\ :

% dumpkeys | grep 'e  99'
keycode  99 = Control_backslash
        control alt     keycode  99 = Meta_Control_backslash

Now by default ^\ is bound to sigquit - and should be as quite a few
programs depend on that...

% dumpkeys | grep [^_]Control_backslash
keycode   5 = four             degree           dollar
Control_backslash Control_backslash
        altgr   control keycode  12 = Control_backslash
        control keycode  43 = Control_backslash
keycode  99 = Control_backslash

Looks like there're quite a few ways to generate ^\ - so disabling one of
them won't hurt:

% echo 'keycode  99 = VoidSymbol' | loadkeys

(Note that this leaves all the "modified" versions of sysrq to do whatever
they were already doing - so shift-printscreen will still generate ^\)

In any case putting that somewhere in your bootup scripts should solve it ;)

(or even users' login scripts as Linux allows anyone to screw up the
keyboard mappings - why?!)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
