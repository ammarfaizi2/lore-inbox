Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbUCSABm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbUCSAAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:00:53 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:1956 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263337AbUCRX77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:59:59 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Date: Thu, 18 Mar 2004 15:59:42 -0800
User-Agent: KMail/1.6.1
References: <1079651064.8149.158.camel@arrakis> <200403181537.10060.jbarnes@sgi.com> <9860000.1079653397@flay>
In-Reply-To: <9860000.1079653397@flay>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403181559.42332.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 March 2004 3:43 pm, Martin J. Bligh wrote:
> > It's probably not too late to change this to
> > pcibus_to_nodemask(pci_bus *), or pci_to_nodemask(pci_dev *), there
> > aren't that many callers, are there (my grep is still running)?
> 
> It probably shouldn't have anything to do with PCI directly either,
> so .... ;-) My former thought was that you might just want the most
> local memory for DMAing into.

Right, we want local memory (or potentially remote memory) for DMA,
but what about interrupt redirection?  Some chipsets don't support
interrupt round robin, and just target interrupts at one CPU.  In that
case (and probably the round robin case too), you want to know which
CPU(s) to send the interrupt at.  Can't immediately think of other
in-kernel uses though (administrators will of course want to be able
to locate a given PCI device in a multirack system, but that's another
subject--one that Martin Hicks posted on yesterday).

Jesse

