Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271736AbTGXVEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 17:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271737AbTGXVEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 17:04:54 -0400
Received: from aneto.able.es ([212.97.163.22]:53470 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271736AbTGXVEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 17:04:53 -0400
Date: Thu, 24 Jul 2003 23:20:00 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David McCullough <davidm@snapgear.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ihar Philips Filipau <filia@softhome.net>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Message-ID: <20030724212000.GC12002@werewolf.able.es>
References: <3038B2BC-BE10-11D7-B453-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3038B2BC-BE10-11D7-B453-000A95A0560C@us.ibm.com>; from hollisb@us.ibm.com on Thu, Jul 24, 2003 at 21:51:16 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.24, Hollis Blanchard wrote:
> On Thursday, Jul 24, 2003, at 14:37 US/Central, Alan Cox wrote:
> 
> > On Iau, 2003-07-24 at 16:30, Hollis Blanchard wrote:
> >> So you're arguing for more inlining, because icache speculative
> >> prefetch will pick up the inlined code?
> >
> > I'm arguing for short inlined fast paths and non inlined unusual
> > paths.
> >
> >> Or you're arguing for less, because code like get_current() which is
> >> called frequently could have a single copy living in icache?
> >
> > Depends how much the jump costs you.
> 
> And also how big your icache is, and maybe even cpu/bus ratio, etc... 
> which depend on the arch of course.
> 
> So as I saw Ihar suggest earlier in this thread, perhaps there should 
> be two inline directives: must_inline (for code whose correctness 
> depends on it) and could_help_performance_inline. Then different archs 
> could #define could_help_performance_inline as appropriate.
> 

Or you just define must_inline, and let gcc inline the rest of 'inlines',
based on its own rule of functions size, adjusting the parameters
to gcc to assure (more or less) that what is inlined fits in cache of
the processor one is building for...
(this can be hard, help from gcc hackers will be needed...)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre7-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.6mdk))
