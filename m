Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVCUWTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVCUWTK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVCUWTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:19:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:20418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261568AbVCUWS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:18:59 -0500
Date: Mon, 21 Mar 2005 14:18:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Alan Curry" <pacman-kernel@manson.clss.net>
Cc: linux-kernel@vger.kernel.org, Egbert Eich <eich@freedesktop.org>
Subject: Re: SVGATextMode on 2.6.11
Message-Id: <20050321141859.22623bf1.akpm@osdl.org>
In-Reply-To: <20050302223859.32722.qmail@manson.clss.net>
References: <20050302223859.32722.qmail@manson.clss.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alan Curry" <pacman-kernel@manson.clss.net> wrote:
>
> With 2.6.11, I can no longer change the cursor with SVGATextMode. Previously,
> a block cursor could be selected by
>   echo Cursor 0-31 >> /etc/TextConfig ; SVGATextMode
> and the cursor would be a block. On all consoles. Forever.
> 
> To accomplish the same thing using the softcursor escape sequences, I must:
> 1. at boot, echo '^[[?8c' to each of /dev/tty1 through /dev/tty63.
> 2. hack terminfo to contain ^[[?8c in place of ^[[?0c
> 3. install the hacked terminfo on all other machines that I will log into
> remotely
> 
> This still isn't quite right: the reset sequence ^[c destroys the block
> cursor because the underline cursor is still the default. An SVGATextMode
> block cursor isn't affected by ^[c -- it truly *becomes* the default, rather
> than being an option that is lost on reset. That's why I've always used
> SVGATextMode to set the cursor: I don't ever want to see an underline cursor
> anywhere, regardless of what terminfo says and /usr/bin/reset does.
> 
> Was SVGATextMode's cursor-setting ability removed as a result of an
> intentional change, or might it get fixed? Or might CUR_DEFAULT become
> tunable? Maybe another control sequence could make the current cursor
> settings the default, like setterm -store does for foreground and background
> colors.
> 
> On another note, the resize function of SVGATextMode has been affected
> strangely too. Sometimes, when resizing the screen to a mode larger than
> 80x25, the video settings come out correctly but the terminal only uses the
> first 25 lines, with the bottom of the screen being blank. This one is hard
> to reproduce. I can reproduce it by doing a full boot (which includes an
> SVGATextMode call from /etc/rcS.d/S60svgatextmode) followed by a manual
> SVGATextMode on tty2. The first one works, and the second one screws up the
> terminal size. When I try to reproduce that series of events without the call
> from /etc/rcS.d, the problem doesn't show up.
> 
> In any case, when that problem _does_ show up, it can be fixed by immediately
> running the same command again, on the same tty where it just screwed up. And
> it never fails twice without an intervening reboot.

This one appears to be a regression introduced by "vgacon fixes to help font restauration in X11", at

http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/video/console/vgacon.c@1.24?nav=index.html|src/|src/drivers|src/drivers/video|src/drivers/video/console|hist/drivers/video/console/vgacon.c

Nobody really owns that code, so one option is to simply revert that
change.

