Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVAOUuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVAOUuP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 15:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVAOUuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 15:50:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61454 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262319AbVAOUuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 15:50:05 -0500
Date: Sat, 15 Jan 2005 21:50:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.29-rc2
Message-ID: <20050115205002.GO4274@stusta.de>
References: <20050112151334.GC32024@logos.cnet> <20050114225555.GA17714@steffen-moser.de> <20050115052050.GF4274@stusta.de> <20050115114309.GA7397@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115114309.GA7397@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 09:43:09AM -0200, Marcelo Tosatti wrote:
> 
> Hi Adrian!
> 
> On Sat, Jan 15, 2005 at 06:20:50AM +0100, Adrian Bunk wrote:
> > On Fri, Jan 14, 2005 at 11:55:55PM +0100, Steffen Moser wrote:
> > 
> > >...
> > >  - fsa01 (problem occurs):
> > >...
> > >  | modutils               2.4.5
> > >...
> > >  - gateway (no problem):
> > >...
> > >  | modutils               2.4.12
> > >....
> > 
> > OK, this seems to be the problem:
> > modutils before 2.4.10 don't know about EXPORT_SYMBOL_GPL.
> > 
> > Please upgrade modutils on fsa01 and report whether it fixes the 
> > problem.
> 
> Yes, thats the right solution - however I think it might be worth to have 
> the non-GPL versions. Several old distros ship modutils older than 2.4.10
> - eg SuSE Linux 7.1 (Oct 2001).
>...

Do a grep for EXPORT_SYMBOL_GPL in the 2.4.29-rc2 sources.

It seems for some reason people didn't scream in older 2.4 releases that 
already had the same problem in several places.

I see you have applied both my patch documenting modutils 2.4.10 was 
required and the EXPORT_SYMBOL_GPL -> EXPORT_SYMBOL patch for tty_io.c .

I don't like this mixed approach. IMHO, there are two clean solutions:
1. document modutils 2.4.10 was required, undo the EXPORT_SYMBOL_GPL -> 
   EXPORT_SYMBOL changes in tty_io.c
2. undo the EXPORT_SYMBOL_GPL -> EXPORT_SYMBOL changes in tty_io.c and
   change module.h to #define EXPORT_SYMBOL_GPL to EXPORT_SYMBOL

Both approaches have their obvious advantages and disadvantages, but 
they don't have the flaw that they special case tty_io.c .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

