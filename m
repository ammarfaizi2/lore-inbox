Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTGGTMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbTGGTMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:12:39 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:11904 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S264246AbTGGTMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:12:38 -0400
Date: Mon, 7 Jul 2003 21:27:08 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: trond.myklebust@fys.uio.no
Cc: LKML <linux-kernel@vger.kernel.org>, felipe_alfaro@linuxmail.org
Subject: Re: opening symlinks with O_CREAT under latest 2.5.74
Message-ID: <20030707192708.GA2228@vana.vc.cvut.cz>
References: <20030707154628.GA3220@vana.vc.cvut.cz> <1057603769.907.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057603769.907.3.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 08:49:29PM +0200, Felipe Alfaro Solana wrote:
> On Mon, 2003-07-07 at 17:46, Petr Vandrovec wrote:
> > Hi,
> >   couple of things stopped working on my box
> > where I have /dev/vc/XX as symlinks to /dev/ttyXX, and some
> > things use /dev/vc/XX and some /dev/ttyXX. After last update
> > hour ago things which use /dev/vc/XX stopped working for
> > non-root - they now fail with EACCES error if they attempt
> > to redirect its input or output through '>' or '<>' bash
> > redirection operators:
> > 
> > $ touch /tmp/xx
> > $ ln -s /tmp/xx yy
> > $ cat > yy
> > -bash: yy: Permission denied
> > 
> > Strace says:
> > 
> > [pid  3268] open("yy", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = -1 EACCES (Permission denied)

> >   Currently I suspect Trond's LOOKUP_CONTINUE change in 
> > '[PATCH] Add open intent information to the 'struct nameidata', but I
> > did not tried reverting it yet to find whether it is culprit or no. But
> > other changes than these four from Trond looks completely innocent.

Reverting "trond.myklebust@fys.uio.no|ChangeSet|20030704190606|14242" indeed
fixes problem.

> JFYI, on Red Hat 9, I'm having problems when using "vi" to edit a file
> through a symbolic link. For example, I can't save changes with ":wq!"
> in vi when editing "/etc/grub.conf" on my RHL9 box (which is a symbolic
> link to "/boot/grub/grub.conf").

I think that it is unrelated.
						Petr Vandrovec
						vandrove@vc.cvut.cz
