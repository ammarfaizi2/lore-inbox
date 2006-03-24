Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWCXSFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWCXSFK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWCXSFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:05:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:32141 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751293AbWCXSFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:05:08 -0500
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 06/13] powerpc: cell interrupt controller updates
Date: Fri, 24 Mar 2006 19:05:03 +0100
User-Agent: KMail/1.9.1
Cc: Arnd Bergmann <abergman@de.ibm.com>, hpenner@de.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, stk@de.ibm.com,
       benh@kernel.crashing.org, cbe-oss-dev@ozlabs.org
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com> <20060323203521.862355000@dyn-9-152-242-103.boeblingen.de.ibm.com> <32140afe2349e8f1726d188eb85c780c@bga.com>
In-Reply-To: <32140afe2349e8f1726d188eb85c780c@bga.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200603241905.04356.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 18:43, Milton Miller wrote:
> On Mar 22, 2006, at 5:00 PM, Arnd Bergmann wrote:
> >  static void spider_enable_irq(unsigned int irq)
> >  {
> > +     int nodeid = (irq / IIC_NODE_STRIDE) * 0x10;
> >       void __iomem *cfg = spider_get_irq_config(irq);
> >       irq = spider_get_nr(irq);
> >
> > -     out_be32(cfg, in_be32(cfg) | 0x3107000eu);
> > +     out_be32(cfg, in_be32(cfg) | 0x3107000eu | nodeid);
> >       out_be32(cfg + 4, in_be32(cfg + 4) | 0x00020000u | irq);
> >  }
> >
> 
> I just did a quick read of the code, but my first thought is what if 
> some other node id was previously set?  Perhaps you should mask off 
> some bits before or'ing in the node id?

Good point. The firmware always sets nodeid zero (or the same one that
we set), but I can't see any reason why we should take that for granted.

Thanks,

	Arnd <><
