Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWABWq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWABWq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 17:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWABWq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 17:46:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751116AbWABWqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 17:46:53 -0500
Date: Mon, 2 Jan 2006 14:43:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Ingo Molnar <mingo@elte.hu>, Krzysztof Halasa <khc@pm.waw.pl>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <Pine.LNX.4.61.0601022158170.14613@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0601021439520.3668@g5.osdl.org>
References: <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
 <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org>
 <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu>
 <m3ek3qcvwt.fsf@defiant.localdomain> <Pine.LNX.4.64.0601021105000.3668@g5.osdl.org>
 <20060102201325.GA32464@elte.hu> <Pine.LNX.4.61.0601022158170.14613@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Jan 2006, Jan Engelhardt wrote:

> >* Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >> > For example, I add "inline" for static functions which are only called
> >> > from one place.
> >> 
> >> That's actually not a good practice. Two reasons:
> >> 
> >>  - debuggability goes way down. Oops reports give a much nicer call-chain 
> >>    and better locality for uninlined code.
> 
> When I want to debug, I use
> CFLAGS="-O0 -ggdb3 -fno-inline -fno-omit-frame-pointer"
> for that particular file(s). That sure gets good results. Not sure about 
> who wins in the kernel case: always_inline or -fno-inline.

This is totally not relevant.

99% of all bug-reports happen for non-developers. What developers can and 
can not do from a debuggability standpoint is almost totally 
uninteresting: quite often the developers won't even be able to recreate 
the bug, but have to go on the bug report that comes in from the outside.

And yes, some users are willing to recompile the kernel, and try ten 
different versions, and in general are just worth their weight in gold. 
But many people have trouble even reporting the (short) oops details, much 
less follow up on it. 

So it's actually important that the default config is reasonably easy to 
debug from the oops report. Because it may be the only thing you ever get.

So -O0 and -fno-inline simply isn't practical, because they are not an 
option for a normal kernel. 

		Linus
