Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTDKDTm (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 23:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbTDKDTl (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 23:19:41 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13321
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264077AbTDKDTk (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 23:19:40 -0400
Date: Thu, 10 Apr 2003 20:30:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Fixes for ide-disk.c
In-Reply-To: <20030410183730.GB4293@zaurus.ucw.cz>
Message-ID: <Pine.LNX.4.10.10304102027320.12558-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

<rant>
Well you authored the mess^H^H^H^Hwork for the suspend, and it fails the
binary logic of on or off.  You failed to abort the caller for attempting
to set multiple blocks.  Fix the kernel because the caller has to be
assumed dumb and brain dead ... it is user space.
</rant>

Andre Hedrick
LAD Storage Consulting Group


On Thu, 10 Apr 2003, Pavel Machek wrote:

> Hi!
> 
> > > Drive->blocked is a single bit field. Its not a counting lock. Either
> > > we are blocked or not.
> > 
> > Okay. We need a different solution then, but the problem remains - the
> > driver can get multiple, nexted calls to block and unblock. Can it
> > become a counting lock?
> 
> Simplest fix seems to be make sure it only
> reacts to one "suspending level" (suspend_save_state)
> and that really should not be nested.
> (If that nests, fix caller)
> -- 
> 				Pavel
> Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

