Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269078AbUJKQGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269078AbUJKQGH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269065AbUJKQCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 12:02:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269078AbUJKQBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 12:01:46 -0400
Date: Mon, 11 Oct 2004 09:01:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
In-Reply-To: <20041011101824.GC26677@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.58.0410110857180.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
 <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102115410.3897@ppc970.osdl.org>
 <20041011101824.GC26677@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Pavel Machek wrote:
> 
> Does sparse now have typechecking on enums?

You can mark an enum "bitwise" (by making all of it's values be
"bitwise"), and it will be considered a type of its own, yes. But then you
also cannot do arithmetic on it (which _usually_ is what you want, but not
necessarily always).

(You'd also need to pass in the "-Wbitwise" flag to sparse, to get the
checks).

By the time you mark something "bitwise", you don't even need to use an
enum, btw. You can just do a regular integer typedef and mark the typedef 
to be "bitwise" - that generates a unique type right there. That's what 
the endianness checking does.

		Linus
