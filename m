Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754602AbWKHR0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbWKHR0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbWKHR0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:26:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4877 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1754602AbWKHR0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:26:48 -0500
Date: Wed, 8 Nov 2006 18:26:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Andi Kleen <ak@suse.de>,
       Jeff Chua <jeff.chua.linux@gmail.com>,
       Aaron Durbin <adurbin@google.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
Message-ID: <20061108172650.GC4729@stusta.de>
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com> <20061107171143.GU27140@parisc-linux.org> <200611080839.46670.ak@suse.de> <20061108122237.GF27140@parisc-linux.org> <Pine.LNX.4.64.0611080803280.3667@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611080803280.3667@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 08:05:18AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 8 Nov 2006, Matthew Wilcox wrote:
> >
> > On Wed, Nov 08, 2006 at 08:39:44AM +0100, Andi Kleen wrote:
> > > ACPI knows the number of busses.
> > 
> > But what if the number of busses increases later, eg by hotplugging
> > a card with a PCI-PCI bridge on it?  Or does it know the number of
> > busses which can be supported by this machine's MMCONFIG region?
> 
> ACPI will give the maximum number.
> 
> However, in this case, the correct thing to do (always _has_ been) is to 
> not use ACPI for _anything_, but just read the base and the size of the 
> MMCONFIG region from the hardware itself.
> 
> Anyway, I do not consider this a regression. MMCONFIG has _never_ worked 
> reliably. It has always been a case of "we can make it work on some 
> machines by making it break on others".

It is a serious regression:

The problem is that with the default CONFIG_PCI_GOANY, MMCONFIG is the 
_first_ method tried.

In practice, this implies that nearly every system possibly affected 
will suffer from a MMCONFIG breakage like the one Jeff observed...

> 			Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

