Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVDQXqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVDQXqQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 19:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVDQXqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 19:46:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:12931 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261564AbVDQXqH (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 19:46:07 -0400
Date: Sun, 17 Apr 2005 15:03:17 -0700
From: Greg KH <greg@kroah.com>
To: Derek Cheung <derek.cheung@sympatico.ca>
Cc: "'Randy.Dunlap'" <rddunlap@osdl.org>, "'Andrew Morton'" <akpm@osdl.org>,
       Linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Message-ID: <20050417220317.GD3178@kroah.com>
References: <20050411200318.GA25550@kroah.com> <001d01c5408f$18238850$1501a8c0@Mainframe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d01c5408f$18238850$1501a8c0@Mainframe>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 09:12:53PM -0400, Derek Cheung wrote:
> OK, hope this patch can satisfy everyone :-)
> 
> The following is the diffstat of the enclosed patch file:
> 
>  drivers/i2c/busses/Kconfig       |   10 
>  drivers/i2c/busses/Makefile      |    1 
>  drivers/i2c/busses/i2c-mcf5282.c |  414
> +++++++++++++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-mcf5282.h |   46 ++++
>  include/asm-m68knommu/m528xsim.h |   42 +++
>  5 files changed, 513 insertions(+)
> 
> I did:
> 
> a) remove all trailing spaces in the files
> b) re-align the switch statement
> c) change a return statement
> d) change some white space intents to TABs
> e) insert a break for the I2C_SMBUS_PROC_CALL, thanks for spotting it
> f) fix the mcf5282lite wording in Kconfig
> 
> I did not:
> 
> g) use the ioremap. This is because Coldfire is a CPU without MMU and
> there is no difference between virtual and physical memory. In fact, the
> ioremap routine in the m68knommu is simply a stub routine that returns
> the input address argument for compatibility reason. Also, all other
> Coldfire CPU include files such as the m5307sim.h uses the volatile
> declaration method. 
> So, I hope this is acceptable to the Linux kernel maintainers

No, do not do this.  Even the i386 platform can get away with doing this
kind of io memory addressing, but drivers do not do that, as they are
not portable.  The first time someone wants to use this kind of i2c
adapter on a non-coldfire chip, they will have to rewrite the driver,
not acceptable.

Also, you did not include a good Changelog entry, nor a Signed-off-by:
line, and you attached the file in a mime attachment.

Please fix these issues up.

thanks,

greg k-h
