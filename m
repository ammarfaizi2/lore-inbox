Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbVAPWXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVAPWXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVAPWRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:17:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:25542 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262634AbVAPWPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:15:40 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, brking@us.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050116220714.GA76666@muc.de>
References: <1105645491.4624.114.camel@localhost.localdomain>
	 <20050113215044.GA1504@muc.de>
	 <1105743914.9222.31.camel@localhost.localdomain>
	 <20050115014440.GA1308@muc.de>
	 <1105750898.9222.101.camel@localhost.localdomain>
	 <1105770012.27411.72.camel@gaston>
	 <1105829883.15835.6.camel@localhost.localdomain>
	 <1105848104.27436.97.camel@gaston> <20050116044823.GA55143@muc.de>
	 <1105908798.27436.102.camel@gaston>  <20050116220714.GA76666@muc.de>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 09:14:18 +1100
Message-Id: <1105913658.27410.107.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 23:07 +0100, Andi Kleen wrote:
> > What is complex in there ? I agree it's not convenient to do this from
> > the very low level ones that don't take the pci_dev * as an argument,
> > but from the higher level ones that does, the overhead is basically to
> > test a flag in the pci_dev, I doubt it will be significant in any way
> > performance wise, especially compared to the cost of a config space
> > access...
> 
> For once you cannot block in them.  There are even setups that
> need to (have to) do config space accesses in interrupt handlers.
> The operations done there should be rather light weight.

I don't think we ever want to block in that sense. I think all we need
is the "filter" mecanism, that is drop writes and return cached data on
reads when the device is "offlined"...

Ben.


