Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbTI2SqX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbTI2SqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:46:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:44225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264443AbTI2SqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:46:22 -0400
Date: Mon, 29 Sep 2003 11:46:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Brian Gerst <bgerst@didntduck.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 do_machine_check() is redundant.
In-Reply-To: <1064775868.5045.4.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0309291142430.3626-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Sep 2003, Arjan van de Ven wrote:
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

Has anybody checked out whether the kernel works with -mregparm=3? I
forget who did a lot of the work on it originally, and it certainly _used_
to work fine. The improvements to both code size and performance were, if 
I remember correctly, measurable but not huge.

One worry (apart from just broken compilers and missing "asmlinkage" 
annotations) is that having compiler-version-dependent calling conventions 
makes for another variable to take into account when chasing down bugs and 
worrying about things like the Nvidia module etc. So it's probably not 
worth doing unless the advantages are clear.

		Linus

