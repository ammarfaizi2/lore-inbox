Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVAOGWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVAOGWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 01:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVAOGWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 01:22:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:10165 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262224AbVAOGWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 01:22:34 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>, brking@us.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105750898.9222.101.camel@localhost.localdomain>
References: <41E3086D.90506@us.ibm.com>
	 <1105454259.15794.7.camel@localhost.localdomain>
	 <20050111173332.GA17077@muc.de>
	 <1105626399.4664.7.camel@localhost.localdomain>
	 <20050113180347.GB17600@muc.de>
	 <1105641991.4664.73.camel@localhost.localdomain>
	 <20050113202354.GA67143@muc.de>
	 <1105645491.4624.114.camel@localhost.localdomain>
	 <20050113215044.GA1504@muc.de>
	 <1105743914.9222.31.camel@localhost.localdomain>
	 <20050115014440.GA1308@muc.de>
	 <1105750898.9222.101.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 17:20:12 +1100
Message-Id: <1105770012.27411.72.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-15 at 01:01 +0000, Alan Cox wrote:
> On Sad, 2005-01-15 at 01:44, Andi Kleen wrote:
> > Then it won't work with this BIST hardware anyways - if it tries
> > to read config space of a device that is currently in BIST 
> > it will just get a bus abort and no useful information.
> 
> So it should wait to preseve a sane API at least for a short while and
> if the user hasn't specified O_NDELAY. Its a compatibility consideration
> 
> > The only point of this whole patch exercise is to avoid the bus abort
> > to satisfy the more strict hardware error checking on PPC64. On PCs
> > it really won't make any difference.
> 
> I thought Ben wanted to do this for other PPC stuff ?

Yes. On various models, I can turn off some ASIC cells, some of them
being PCI devices. I do that dynamically for power management typically.

Depending on the chipset, tapping one of those "disabled" cells with
config space accesses results in either all 1's or a lockup. On the
former, I currently do nothing special (but that cause problems with
various distro HW detection/configuration tools or the possible problem
with X you mentioned, among others), on the later, I have a special
filter in my pmac low level config space access routines to block access
to those sleeping devices (and currently to return all 1's).

I'm pretty sure similar situations can happen on other archs when
pushing a bit on power management, especially things like handhelds
(though not much of them are PCI based for now).

That's why a "generic" mecanism to hide such devices while providing
cached data on config space read's would be useful to me as well.

Ben.


