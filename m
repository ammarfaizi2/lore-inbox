Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVAOBv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVAOBv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVAOBtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:49:49 -0500
Received: from colin2.muc.de ([193.149.48.15]:7695 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262102AbVAOBoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:44:46 -0500
Date: 15 Jan 2005 02:44:40 +0100
Date: Sat, 15 Jan 2005 02:44:40 +0100
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: brking@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050115014440.GA1308@muc.de>
References: <41E3086D.90506@us.ibm.com> <1105454259.15794.7.camel@localhost.localdomain> <20050111173332.GA17077@muc.de> <1105626399.4664.7.camel@localhost.localdomain> <20050113180347.GB17600@muc.de> <1105641991.4664.73.camel@localhost.localdomain> <20050113202354.GA67143@muc.de> <1105645491.4624.114.camel@localhost.localdomain> <20050113215044.GA1504@muc.de> <1105743914.9222.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105743914.9222.31.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 12:33:08AM +0000, Alan Cox wrote:
> On Iau, 2005-01-13 at 21:50, Andi Kleen wrote:
> > I could see it as a problem when it happens on a bridge, but why
> > should it be a problem when some arbitary, nothing to do with X
> > leaf is temporarily not available? 
> 
> Because X will believe that PCI address range is free and right now in
> some circumstances older X may want to play with PCI layout itself.

Yuck. sounds as broken as it can be. Hopefully nobody uses
such X servers anymore.

Then it won't work with this BIST hardware anyways - if it tries
to read config space of a device that is currently in BIST 
it will just get a bus abort and no useful information.

The only point of this whole patch exercise is to avoid the bus abort
to satisfy the more strict hardware error checking on PPC64. On PCs
it really won't make any difference.

-Andi
