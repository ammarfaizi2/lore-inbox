Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264150AbTDWSBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264166AbTDWSBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:01:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264150AbTDWSBE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:01:04 -0400
Date: Wed, 23 Apr 2003 14:15:55 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andrew Kirilenko <icedank@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Searching for string problems
In-Reply-To: <200304232105.38722.icedank@gmx.net>
Message-ID: <Pine.LNX.4.53.0304231412450.25545@chaos>
References: <200304231958.43235.icedank@gmx.net> <Pine.LNX.4.53.0304231311460.25222@chaos>
 <200304232105.38722.icedank@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Andrew Kirilenko wrote:

> Hello!
>
> > If you need to search the whole BIOS for that string, you need to
> > set up an outer loop using an unused register which starts at
> > the offset of the BIOS and increments by one byte everytime
> > you can't find the string. This value gets put into %di, instead
> > of the absolute number specified above.
> >
> > Like:
> >
> > scan:	movw	%cs, %ax
> > 	movw	%ax, %ds
> > 	movw	%ax, %es
> > 	movw	$where_in_BIOS_to_start, %bx
> > 	cld
> > 1:	movw	$cl_id_str, %si		# Offset of search string
> > 	movw	$cl_id_end, %cx		# Offset of string end + 1
> > 	subw	%si, %cx		# String length
> > 	decw	%cx			# Don't look for the \0
> > 	movw	%bx, %di		# ES:DI = where to look
> > 	repz	cmpsb			# Loop while the same
> > 	jz	found			# Found the string
> > 	incb	%bx			# Next starting offset
> > 	cmpb	$_BIOS_END, %bx		# Check for limit
> > 	jb	1b			# Continue
> > never_found_anywhere:
> >
> > found:
>
> I've written something similar to this before - and it wont' work, so I've
> reimplemented it. The problem is, that I don't know how to set ES properly. I
> only know, that BIOS data (and code) is located in 0xe000..0xf000 (real
> address).
>

Yeah. So. I set ES and DS to be exactly where CS is. This means that
if your &!)(^$&_ code executes it will work. So, instead of trying
it, you just blindly ignore it and state that it won't work.

Bullshit. I do this for a living and I gave you some valuable time
which you rejected out-of-hand. Have fun.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

