Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWABUNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWABUNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWABUNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:13:34 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:25571 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751012AbWABUNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:13:34 -0500
Date: Mon, 2 Jan 2006 21:13:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102201325.GA32464@elte.hu>
References: <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu> <m3ek3qcvwt.fsf@defiant.localdomain> <Pine.LNX.4.64.0601021105000.3668@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601021105000.3668@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > For example, I add "inline" for static functions which are only called
> > from one place.
> 
> That's actually not a good practice. Two reasons:
> 
>  - debuggability goes way down. Oops reports give a much nicer call-chain 
>    and better locality for uninlined code.

yes, and to improve debuggability, i often do this at the top of 
debugged .c modules:

	#undef inline
	#define inline

to get good stacktraces. So debuggability is i think another argument to 
further decouple 'inline' from 'always inline' - so a global .config 
DEBUG_ option could turn all inlines into real function calls. (we 
already have CONFIG_FRAME_POINTERS to improve stack-trace output, at the 
price of slightly slower code.)

	Ingo
