Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUJKClh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUJKClh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 22:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268660AbUJKClh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 22:41:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:40584 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266807AbUJKClf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 22:41:35 -0400
Date: Sun, 10 Oct 2004 19:41:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>
Subject: Re: Totally broken PCI PM calls
In-Reply-To: <1097455528.25489.9.camel@gaston>
Message-ID: <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Benjamin Herrenschmidt wrote:
>
> Any reason why this totally broken code was ever merged upstream ?

Because it fixes a lot of drivers.

> Please, revert that to something sane before 2.6.9...

Nope. There's just too much confusion abou what the state thing means. 
See the TG3 driver, for one, all the USB drivers for another.

The long-term solution is to make this thing be not a number at all, but a 
restricted type (ie a "struct" with one member, or similar) to make sure 
you _cannot_ mis-use it. As it is, most PCI drivers do seem to expect a 
PCI suspend state. 

> I'll bomb it ever and ever again until some sense gets into
> all of this.

If you have the energy to complain about it, maybe you have the energy to 
change it to use a "struct", and fix up all the drivers and verify that 
they actually get it right.

Until that happens, we pass in PCI suspend states, and we _also_ make sure 
that the PCI suspend states "almost match" the PM_SUSPEND_xxx constants, 
so that when there is confusion, it tends to be as benign as possible.

			Linus
