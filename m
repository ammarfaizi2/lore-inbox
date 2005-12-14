Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbVLNWSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbVLNWSp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVLNWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:18:44 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:38114 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965025AbVLNWSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:18:44 -0500
Date: Wed, 14 Dec 2005 23:18:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Petr Baudis <pasky@suse.cz>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [PATCH 3/3] [kconfig] Direct use of lxdialog routines by menuconfig
In-Reply-To: <20051212004606.31263.37616.stgit@machine.or.cz>
Message-ID: <Pine.LNX.4.61.0512142155220.1609@scrub.home>
References: <20051212004159.31263.89669.stgit@machine.or.cz>
 <20051212004606.31263.37616.stgit@machine.or.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Dec 2005, Petr Baudis wrote:

> In practice, this means that drawing on the screen is done with _MUCH_
> less overhead now, the screen updates are better optimalized as ncurses
> won't get reset everytime you display something, that also implies that
> the ugly screen flickering is done. As a cute side-effect, the dialogs
> are now rendered on the top of the menu or help panel.  In the future,
> this also gives us much more freedom for enhancing the user interface.

At least in the first version I'd prefer not to do draw the dialogs over 
each other. It's just weird if a string dialog pops up over the help text.
In the next version we should add some infrastructure to properly layer 
windows on top of other (and should also help with resizing).

> Compared to the previous version (from February 2003), this one should be
> less buggy (especially wrt. the escape character handling), should not
> crash while resizing and the resizing should have immediate effect
> (although things can still start looking ugly when you are resizing while
> not in a menu - to fix that properly, more liblxdialog integration is
> required). Also, the code is considerably simplified on few places.

The <esc><esc> as described in mconf.c still produces two exits, which is 
a little annoying if one is used to it. I don't know how easy it is to 
supress that second <esc>.

Otherwise it looks good. Regarding merging please coordinate with Sam and 
if you move it, I'd prefer to keep it in a subdirectory, e.g. just "mv 
scripts/lxdialog scripts/kconfig/lxdialog".

bye, Roman
