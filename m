Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272779AbSISUF6>; Thu, 19 Sep 2002 16:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272784AbSISUF6>; Thu, 19 Sep 2002 16:05:58 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:15891 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S272779AbSISUF5>; Thu, 19 Sep 2002 16:05:57 -0400
Date: Thu, 19 Sep 2002 22:10:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] In-kernel module loader 1/7
In-Reply-To: <20020919183843.GA16568@kroah.com>
Message-ID: <Pine.LNX.4.44.0209192048350.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 19 Sep 2002, Greg KH wrote:

> > I already said often enough, a module has only to answer the simple
> > question: Is it safe to unload the module?
>
> And with a LSM module, how can it answer that?  There's no way, unless
> we count every time someone calls into our module.  And if you do that,
> no one will even want to use your module, given the number of hooks, and
> the paths those hooks are on (the speed hit would be horrible.)

Check Rusty's first patch. You basically have to uninstall all the hooks
first, then you have to wait for all running processes to advance enough,
that you can be sure a caller advanced far enough to a synchronization
point within the module (e.g. a try_module_get()). At this point you can
be sure whether you have module users or not.
Note that Rusty's patch doesn't help LSM at all, because he didn't
introduce the separate stop/exit calls.

> I'm with Rusty, just don't let people unload modules, unless you are
> running a development kernel, and "obviously" know what you are doing.

For the majority of modules unloading can be implemented safely and simple
modules don't have to care about module races, as long as the interfaces
they are using are safe.

bye, Roman

