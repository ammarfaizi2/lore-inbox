Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317693AbSGZN3X>; Fri, 26 Jul 2002 09:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317701AbSGZN3X>; Fri, 26 Jul 2002 09:29:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:45045 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317693AbSGZN3X>; Fri, 26 Jul 2002 09:29:23 -0400
Subject: Re: [PATCH] 2.5-rmap: VM strict overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@elf.ucw.cz>
Cc: Robert Love <rml@tech9.net>, akpm@zip.com.au, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020726103104.GA279@elf.ucw.cz>
References: <1026928763.1116.11.camel@sinai> 
	<20020726103104.GA279@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 15:46:43 +0100
Message-Id: <1027694803.13428.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 11:31, Pavel Machek wrote:
> In what scenario can "strict overcommit" kill?

When the kernel grabs over 50% of RAM. Remember that includes page
tables. I've seen the kernel taking 35% of RAM.

> 
> > +4	-	(NEW) paranoid overcommit. The total address space commit
> > +		for the system is not permitted to exceed swap. The machine
> > +		will never kill a process accessing pages it has mapped
> > +		except due to a bug (ie report it!).
> 
> ...and why is that scenario impossible on "paranoid overcommit"?

You are guaranteed user pages are either discardable or all fit in swap.
If you run out of memory the kernel itself runs out of allocation space
for any kernel owned page.

