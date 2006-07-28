Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbWG1RO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWG1RO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161186AbWG1RO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:14:27 -0400
Received: from smtp.reflexsecurity.com ([72.54.64.74]:1742 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id S1161098AbWG1RO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:14:26 -0400
Date: Fri, 28 Jul 2006 13:13:57 -0400
From: Jason Lunz <lunz@falooley.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] amd74xx: implement suspend-to-ram
Message-ID: <20060728171357.GB17549@knob.reflex>
References: <200607281646.31207.rjw@sisk.pl> <1154105517.13509.153.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154105517.13509.153.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 05:51:55PM +0100, Alan Cox wrote:
> This beings in the IDE power step code. You should do that as a step
> before the win_idleimmediate I suspect. Theory is right, diagnosis is
> right, implementation is in the wrong place.
> 
> You'll make a lot more people happy by fixing it in ide-io

OK, I'll see about moving it there. Will this still be
controller-specific, or are you suggesting this is something ide ought
to do globally?

I poked around in ide-io.c a little while writing the patch, but my
assumption so far has been that the core ide suspend is OK wrt s2ram,
since I never hear IDE cited as the reason for s2ram failure. Usually
it's ACPI or video problems.

I'm beginning to suspect that the real problem is that everyone who
experiences ide-related hangs when attempting s2ram switches to s2disk,
which sidesteps ide problems since the ide controller stays alive
throughout the process and gets reinitialized on resume. So I guess
ide/s2ram problems could be more common than is widely known.

Jason
