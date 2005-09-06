Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVIFKws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVIFKws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 06:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVIFKws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 06:52:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31146 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964803AbVIFKwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 06:52:47 -0400
Date: Tue, 6 Sep 2005 12:52:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: viro@ZenIV.linux.org.uk
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig fix (BLK_DEV_FD dependencies)
In-Reply-To: <20050906004842.GP5155@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0509061205510.3743@scrub.home>
References: <20050906004842.GP5155@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 6 Sep 2005 viro@ZenIV.linux.org.uk wrote:

> Sanitized and fixed floppy dependencies: split the messy dependencies for
> BLK_DEV_FD by introducing a new symbol (ARCH_MAY_HAVE_PC_FDC), making
> BLK_DEV_FD depend on that one and taking declarations of ARCH_MAY_HAVE_PC_FDC
> to arch/*/Kconfig.  While we are at it, fixed several obvious cases when
> BLK_DEV_FD should have been excluded (architectures lacking asm/floppy.h
> are *not* going to have floppy.c compile, let alone work).

I'm not really a big fan of such dummy symbols, those whole point is to 
only enable dependencies, but are otherwise unsused.
The basic problem is similiar to selects, that one has to grep the whole 
Kconfig to find out what modifies the dependencies of a symbol.

If we really want to describe dependencies like this, I'd prefer to extend 
the Kconfig syntax for this:

config FOO
	allow BAR

config BAR
	option hidden

The hidden option would explicitly hide the symbol, unless otherwise 
allowed.

bye, Roman
