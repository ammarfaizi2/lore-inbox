Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbVCDUlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbVCDUlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbVCDUd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:33:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58122 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263099AbVCDU2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:28:43 -0500
Date: Fri, 4 Mar 2005 21:28:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kai Germaschewski <kai.germaschewski@unh.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       kai@germaschewski.name, Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>, keenanpepper@gmail.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-ID: <20050304202842.GH3327@stusta.de>
References: <1109931797.28203.2.camel@localhost.localdomain> <Pine.LNX.4.44.0503041403470.15777-100000@chaos.sr.unh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0503041403470.15777-100000@chaos.sr.unh.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 02:11:13PM -0500, Kai Germaschewski wrote:
> On Fri, 4 Mar 2005, Rusty Russell wrote:
> 
> > On Wed, 2005-03-02 at 15:00 +0100, Adrian Bunk wrote:
> > > Why doesn't an EXPORT_SYMBOL create a reference?
> > 
> > It does: EXPORT_SYMBOL(x) drops the address of "x", including
> > __attribute_used__, in the __ksymtab section.
> 
> Well, the problem is that this is still an internal reference in the same 
> object file. So ld looks into the lib .a archive, determines that none of 
> the symbols in that object file are needed to resolve a reference and 
> drops the entire .o file. Doing so, it drops the __ksymtab section as 
> well, which otherwise would be used by the kernel to look up that symbol. 
> 
> So it drops the reference and the referencee ;), which is normally fine -- 
> no unresolved symbols occur. Unfortunately, the kernel really needs to 
> know the contents of the __ksymtab sections to correctly export those 
> symbols, but it doesn't reference it in any explicit way.
> 
> I don't think there's an easy fix, except for not putting such objects 
> into an archive/lib, but to link them directly.

Silly question:
What's the advantage of lib-y compared to obj-y?

> --Kai

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

