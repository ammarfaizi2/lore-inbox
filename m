Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTI2UUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 16:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264703AbTI2UUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 16:20:48 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:20110 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264285AbTI2UUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 16:20:47 -0400
Date: Mon, 29 Sep 2003 22:20:45 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Brian Gerst <bgerst@didntduck.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: -mregparm=3 (was  Re: [PATCH] i386 do_machine_check() is redundant.
In-Reply-To: <1064775868.5045.4.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0309292214100.3276@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org>
 <1064775868.5045.4.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Use machine_check_vector in the entry code instead.
> >
> > This is wrong. You just lost the "asmlinkage" thing, which means that it
> > breaks when asmlinkage matters.
> >
> > And yes, asmlinkage _can_ matter, even on x86. It disasbles regparm, for
> > one thing, so it makes a huge difference if the kernel is compiled with
> > -mregparm=3 (which used to work, and which I'd love to do, but gcc has
> > often been a tad fragile).
>
> gcc 3.2 and later are supposed to be ok (eg during 3.2 development a
> long standing bug with regparm was fixed and now is believed to work)...
> since our makefiles check gcc version already... this can be made gcc
> version dependent as well for sure..

They are still buggy. gcc 3.3.1 miscompiles itself with -mregparm=3
(without -O or -O2 it works). (I am too lazy to spend several days trying
to find exactly which function in gcc was miscompiled, maybe I do it one
day). gcc 2.95.3 compiles gcc 3.3.1 with -mregparm=3 -O2 correctly.
gcc 3.4 doesn't seem to be better.

gcc 2.7.2.3 has totally broken -mregparm=3, even quite simple programs
fail.

Mikulas
