Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbTI2Qzw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 12:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbTI2Qzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 12:55:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:48257 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261637AbTI2Qzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 12:55:47 -0400
Date: Mon, 29 Sep 2003 09:51:29 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Nigel Cunningham <ncunningham@clear.net.nz>
cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pm: Revert swsusp to 2.6.0-test3
In-Reply-To: <1064774937.18769.9.camel@laptop-linux>
Message-ID: <Pine.LNX.4.44.0309290938010.968-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Could you also give me some clear direction on where you want me to put
> my 2.4 port. Should it go in kernel/power, or somewhere else? (I'm
> assuming you don't want 3 versions of swsusp?!). I'd like to put it in
> the right place when I start populating swsusp25.bkbits.net, so you're
> not pulling changesets later that only move the code around (I know bk
> reduces the cost, but...).

Please put it in kernel/power/. 

It's completely alright to have three suspend-to-disk implementations. For 
one, porting it does not imply that it will be merged into mainline, as 
is. I would like to see convergence of the competing solutions, and I 
fully intend to leverage the work that you've done and integrate it into 
the core power management code, and the pmdisk implementation. 

The power management core provides, among other things, a framework for 
properly suspending and resuming a system. Persistant state retention is 
one aspect, albeit the largest in terms of importance and sheer size. I 
would like to see backend mechanism for storing state abstracted from the 
snapshotting process. 

This means that there may be several low-level 'drivers' that each deal 
with reading/writing data on a particular format. And, it means that much 
of the overhead of swsusp, etc, can be folded into the core PM code. 

I do not have more technical details about this ATM, but I will work with 
you to make sure things are streamlined as much as possible during and 
after your port.


	Pat

