Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTDOWgh (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbTDOWgh 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:36:37 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:60129 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S264129AbTDOWgg 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 18:36:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Robert Love <rml@tech9.net>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Subject: Re: [PATCH] [2.5] include/asm-generic/bitops.h {set,clear}_bit return void
Date: Wed, 16 Apr 2003 00:46:20 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030415174010$3e7e@gated-at.bofh.it> <3E9C7955.7070605@gmx.net> <1050442489.3664.159.camel@localhost>
In-Reply-To: <1050442489.3664.159.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304160046.20778.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 April 2003 23:34, Robert Love wrote:
> > The point of asm-generic is not to use the files, but to give porters a
> > hint about the functionality. Quoting asm-generic/bitops.h:
> >
> > /* For the benefit of those who are trying to port Linux to another
> >  * architecture, here are some C-language equivalents.  You should
> >  * recode these in the native assembly language, if at all possible.
> >  * To guarantee atomicity, these routines call cli() and sti() to
> >  * disable interrupts while they operate.  (You have to provide inline
> >  * routines to cli() and sti().) */
> >
> > Or is this comment wrong, too?
>
> Well, the cli() and sti() part is definitely wrong for 2.5.
>
> It is wrong though to assume that nothing will use these; someone may
> copy them directly (and then they do not work) or someone may #include
> this file.

AFAICS, the meaning of the asm-generic directory has completely changed
during the 2.4/2.5 timeframe. They are now meant to be included from 
other header files, with the exception of unaligned.h and bitops.h.

These two files are now worthless for the purpose they were meant for. When
someone wants to start a new architecture, the maintained architectures
are the place to look at. For example, the parisc and ia64 implementations 
of bitops.h are both generic enough to be used for a new architecture 
and they actually are SMP safe and complete, while the asm-generic 
variant has been broken since linux-2.0!

> I like Arnd's suggestion to just remove these functions and all other
> instances of them -- assuming in fact they are never used.

I actually meant removing the asm-generic/bitops.h file, not the functions.

	Arnd <><
