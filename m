Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSLFQca>; Fri, 6 Dec 2002 11:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSLFQca>; Fri, 6 Dec 2002 11:32:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64261 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263760AbSLFQc3>;
	Fri, 6 Dec 2002 11:32:29 -0500
Date: Fri, 6 Dec 2002 16:40:05 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: davem@redhat.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021206164005.B16341@parcelfarce.linux.theplanet.co.uk>
References: <200212061619.IAA22144@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212061619.IAA22144@baldur.yggdrasil.com>; from adam@yggdrasil.com on Fri, Dec 06, 2002 at 08:19:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 08:19:25AM -0800, Adam J. Richter wrote:
> On Fri, 2002-12-06, David S. Miller wrote:
> >I think you are solving a non-problem, but if you want me to see your
> >side of the story you need to give me specific examples of where
> >pci_alloc_consistent() is "IMPOSSIBLE".
> 
> 	I am not a parisc developer, but it is apparently the
> case for certain parisc machines with "PCXS/T processors" or
> the "T class" machines, as described by Mathew Wilcox:

Machines built with PCXS and PCXT processors are guaranteed not to have
PCI.  So this only becomes a problem when supporting non-PCI devices.
The devices you mentioned -- 53c700 & 82596 -- are core IO and really do
need to be supported.  There's also a large userbase for these machines,
dropping support for them is not an option.

T class machines don't have PCI slots per se, but they do have GSC
slots into which a card can be plugged that contains a Dino GSC to PCI
bridge and one or more PCI devices.  Examples of cards that are like
this include acenic, single and dual tulip.

On the other hand, it's going to take some really motivated person to
make T class work.  I'm firmly uninterested in it.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
