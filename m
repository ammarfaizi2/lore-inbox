Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVA0XSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVA0XSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVA0XRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:17:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:14566 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261289AbVA0XQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:16:53 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: brking@us.ibm.com, Andi Kleen <ak@muc.de>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1106841228.14787.23.camel@localhost.localdomain>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com>
	 <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com>
	 <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com>
	 <1105454259.15794.7.camel@localhost.localdomain>
	 <20050111173332.GA17077@muc.de>
	 <1105626399.4664.7.camel@localhost.localdomain>
	 <20050113180347.GB17600@muc.de>
	 <1105641991.4664.73.camel@localhost.localdomain>
	 <20050113202354.GA67143@muc.de>  <41ED27CD.7010207@us.ibm.com>
	 <1106161249.3341.9.camel@localhost.localdomain>
	 <41F7C6A1.9070102@us.ibm.com>  <1106777405.5235.78.camel@gaston>
	 <1106841228.14787.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 10:15:08 +1100
Message-Id: <1106867708.5235.111.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 15:53 +0000, Alan Cox wrote:
> On Mer, 2005-01-26 at 22:10, Benjamin Herrenschmidt wrote:
> > On Wed, 2005-01-26 at 10:34 -0600, Brian King wrote:
> > Well, I honestly think that this is unnecessary burden. I think that
> > just dropping writes & returning data from the cache on reads is enough,
> > blocking userspace isn't necessary, but then, I may be wrong ;)
> 
> Providing the BARs, cmd register and bridge VGA_EN are cached then I
> think you
> are right.

There might be one problem with dropping of writes tho, which has to
do with userland like X doing VGA flip-flip (VGA_EN on bridges and
CMD_IO on devices). But I think that's a non-issues because:

 - For now, nobody is using this interface to hide a VGA device or a
bridge, and I don't see that happening in the near future

 - Eventually, the control of who owns VGA is to be moved to a kernel
driver doing proper arbitration as we discussed previously on several
lists. (BTW. Alan, I've been a bit out of touch with that and Jon is too
busy lately, do you know if there  have been progress or at least
prototype code one could take over from for that ?)

Ben.


