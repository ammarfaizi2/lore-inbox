Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWIZJO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWIZJO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 05:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWIZJO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 05:14:26 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:34574 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP
	id S1750769AbWIZJO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 05:14:26 -0400
Subject: Re: [PATCH 0/3] at91_serial: Introduction
From: Andrew Victor <andrew@sanpeople.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060923211417.GB4363@flint.arm.linux.org.uk>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
	 <20060923211417.GB4363@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Multenet Technologies (Pty) Ltd
Message-Id: <1159261584.24659.16.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Sep 2006 11:06:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

> On Wed, Aug 02, 2006 at 04:51:45PM +0200, Haavard Skinnemoen wrote:
> > Another thing: Andrew, are you the official maintainer of this driver?
> > If not, who is?
> 
> I've not heard from Andrew, so I'm not sure what to do about this.  I
> think these changes need validating by someone with the existing driver's
> hardware (iow, AT91RM9200 and/or AT91SAM9261) so we can be sure we don't
> break that support.

For patch 1, I'm not to keen on the:

  +#ifdef CONFIG_AVR32
  +       port->flags |= UPF_IOREMAP;
  +       port->membase = ioremap(pdev->resource[0].start,
  +                               pdev->resource[0].end
  +                               - pdev->resource[0].start + 1);
  +#else

part.  It might be better to pass a flag (in the platform_data
structure) whether we are providing a virtual or a physical address.
(If you want early init on the serial console, then I recommend just
using a static mapping for the DBGU peripheral).

Patch 2 & 3 look correct, but they would need to be tested.


Regards,
  Andrew Victor


