Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310222AbSCFWBq>; Wed, 6 Mar 2002 17:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310219AbSCFWBh>; Wed, 6 Mar 2002 17:01:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5133 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310222AbSCFWBY>;
	Wed, 6 Mar 2002 17:01:24 -0500
Message-ID: <3C8691C9.30FA3C29@mandrakesoft.com>
Date: Wed, 06 Mar 2002 17:01:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire net driver update for 2.4.19pre2
In-Reply-To: <Pine.LNX.4.44.0203061652050.31906-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> On Wed, 6 Mar 2002, Jeff Garzik wrote:
> 
> > There is a bugfix, which I will make locally before submitting:
> > PCI_COMMAND_INVALIDATE should be enabled -after- messing with
> > PCI_CACHE_LINE_SIZE.
> 
> I didn't find anything in the starfire chipset's documentation about this,
> so is there a deeper reason for this ordering? As far as I know, most if
> not all x86 PCI chipsets silently map MWI to MW, so it should only matter
> for non-x86 plaforms, right?

More PCI than a Starfire requirement.

And there are plenty of ia32 platforms that benefit from MWI, too. 
Often its server mobos that support MWI, but some cheaper ones do too.


> And, in general, are there any other tricks one can do to speed up the PCI
> transactions on non-x86 platforms? I'm still getting occasional overruns
> on sparc64 (card receiving packets faster than it can push them over PCI),
> which is somewhat disturbing..

Dynamically tune your RX and TX DMA burst settings when you notice these
conditions...  It is indeed possible to saturate PCI bus bandwidth.

	Jeff


-- 
Jeff Garzik      | Usenet Rule #2 (John Gilmore): "The Net interprets
Building 1024    | censorship as damage and routes around it."
MandrakeSoft     |
