Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbUKSWsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUKSWsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbUKSWqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:46:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:12943 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261669AbUKSWnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:43:21 -0500
Subject: Re: [PATCH] MII bus API for PHY devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
Cc: netdev@oss.sgi.com, Linux Kernel list <linux-kernel@vger.kernel.org>,
       jason.mcmullan@timesys.com, Andy Fleming <AFLEMING@motorola.com>
In-Reply-To: <97DA0EF0-3A70-11D9-B023-000393C30512@freescale.com>
References: <069B6F33-341C-11D9-9652-000393DBC2E8@freescale.com>
	 <9B0D9272-398A-11D9-96F6-000393C30512@freescale.com>
	 <1100820391.25521.14.camel@gaston>
	 <97DA0EF0-3A70-11D9-B023-000393C30512@freescale.com>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 09:43:04 +1100
Message-Id: <1100904184.3856.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 15:18 -0600, Andy Fleming wrote:

> So when you say instantiated, would you consider calling an "attach" 
> function with the phy_id and bus_id of the desired PHY instantiation?  
> I'm fine with that.  The PHY would need to be able to send 
> notifications to the enet controller (currently done through a 
> callback).  I'm interested in ideas on how the notifier could be used 
> (I have a distaste for callbacks).

Look at the notifier lists in include/linux/notifier.h

> Autopoll features sound pretty neat.  I think the system should support 
> that.

But that becomes MAC-dependant again... That means you'd need 1) a way
for the MAC driver to ask the PHY driver what register it wants
autopolled, and a function in the PHY driver for the MAC to call when it
detects a change. Also, autopoll is broken in some MACs...

>   PHY interrupts are supported (they work quite well on my 85xx 
> system), as is timer-based polling.  Do you really think that there are 
> special cases which can't be handled using a library similar to the 
> sungem_phy one?

Nope. I think timer based polling with a sungem-like fallback mecanism
to forced speeds would be nice.

Ben.


