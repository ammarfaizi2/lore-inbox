Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVAPUyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVAPUyc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVAPUyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:54:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:44229 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262603AbVAPUya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:54:30 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, brking@us.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050116044823.GA55143@muc.de>
References: <1105641991.4664.73.camel@localhost.localdomain>
	 <20050113202354.GA67143@muc.de>
	 <1105645491.4624.114.camel@localhost.localdomain>
	 <20050113215044.GA1504@muc.de>
	 <1105743914.9222.31.camel@localhost.localdomain>
	 <20050115014440.GA1308@muc.de>
	 <1105750898.9222.101.camel@localhost.localdomain>
	 <1105770012.27411.72.camel@gaston>
	 <1105829883.15835.6.camel@localhost.localdomain>
	 <1105848104.27436.97.camel@gaston>  <20050116044823.GA55143@muc.de>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 07:53:17 +1100
Message-Id: <1105908798.27436.102.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 05:48 +0100, Andi Kleen wrote:
> > Right. Though I think the "will be back soon" and "is invisible" are
> > pretty much the same thing. That is, in both our cases (BIST and pmac
> > PM), we want the device to still be visible to userland, as it actually
> > exist, should be properly detected by userland config tools etc..., but
> > may only be actually enabled when the interface is opened/used for PM
> > reasons.
> 
> I just request that this shouldn't be done in the low level pci_config_read_*
> functions. Please keep them simple and lean. If you want such complex 
> semantics for user space do it in a separate layer.

What is complex in there ? I agree it's not convenient to do this from
the very low level ones that don't take the pci_dev * as an argument,
but from the higher level ones that does, the overhead is basically to
test a flag in the pci_dev, I doubt it will be significant in any way
performance wise, especially compared to the cost of a config space
access...

Ben.


