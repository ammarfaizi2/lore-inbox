Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVAKSXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVAKSXm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 13:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVAKSTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 13:19:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:60129 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261178AbVAKSTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 13:19:01 -0500
Date: Tue, 11 Jan 2005 10:18:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Dave <dave.jiang@gmail.com>, linux-kernel@vger.kernel.org,
       smaurer@teja.com, linux@arm.linux.org.uk, dsaxena@plexity.net,
       drew.moseley@intel.com
Subject: Re: clean way to support >32bit addr on 32bit CPU
In-Reply-To: <41E40F4A.6020500@osdl.org>
Message-ID: <Pine.LNX.4.58.0501111013060.2373@ppc970.osdl.org>
References: <8746466a050110153479954fd2@mail.gmail.com>
 <Pine.LNX.4.58.0501101607240.2373@ppc970.osdl.org> <41E31D95.50205@osdl.org>
 <Pine.LNX.4.58.0501101722200.2373@ppc970.osdl.org> <41E40F4A.6020500@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jan 2005, Randy.Dunlap wrote:
>
> > Ahh, yes. That's required on pretty much all platforms except x86 and
> > x86-64.
> 
> OK, I don't get it, sorry.  What's different about ARM & MIPS here
> (for PCMCIA)?  Is this historical (so that I'm just missing it)
> or is it a data types difference?

Nothing is different. Pretty much every architecture - except for x86 and
ilk - will at least have the _potential_ for IO ports encoded above the
16-bit mark.

But a lot of architectures won't have PCMCIA (or if they do, they end up
having the whole ISA mapping, and for compatibility reasons they'll end up
making the ports visible to the kernel in the low 16 bits, even if the
actual hw has some other physical translation - I think that's true on
ppc, at least).

So what makes ARM and MIPS special is just the fact that they have PCMCIA, 
but don't necessarily have the traditional ISA mappings. Embedded devices 
and all that. Others either try to hide the fact that they look different, 
or just never cared.

But the right thing is definitely to make an IO port pointer be "unsigned 
int" or even "unsigned long". 

		Linus
