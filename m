Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267177AbUFZPy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267177AbUFZPy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 11:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267178AbUFZPy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 11:54:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:24793 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267177AbUFZPy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 11:54:56 -0400
Date: Sat, 26 Jun 2004 08:54:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, george@galis.org
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
In-Reply-To: <1088253429.9831.1449.camel@cube>
Message-ID: <Pine.LNX.4.58.0406260852130.14449@ppc970.osdl.org>
References: <1088253429.9831.1449.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jun 2004, Albert Cahalan wrote:
> 
> You never did come up with an alternative to HZ-guessing
> that would work on those old 1200-HZ Alpha boxes, the ARM
> boxes that ran at 64 HZ and so on.

The fix for those should be that they should all export the same HZ to 
user space, regardless of any internal tick. So that's a kernel bug, in 
that those architectures expose the _internal_ HZ rather than some 
user-visible well-defined one.

> I suppose you can blame the arch maintainers, but user-space has to deal
> with it.

If the user space tools didn't try to deal with it, the architectures 
would probably get fixed in a jiffy. All the support for kernel-to-user HZ 
conversion is there.

So I still maintain that procps should _not_ try to guess HZ. As it is, 
it's a bug, and it helps make excuses for _other_ bugs.

		Linus
