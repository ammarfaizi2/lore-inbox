Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVHLTqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVHLTqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVHLTqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:46:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33552 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751265AbVHLTqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:46:25 -0400
Date: Fri, 12 Aug 2005 20:46:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuppc-embedded@freescale.com, vbordug@ru.mvista.com
Subject: Re: [PATCH] cpm_uart: Fix spinlock initialization
Message-ID: <20050812204617.C21152@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@freescale.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuppc-embedded@freescale.com, vbordug@ru.mvista.com
References: <Pine.LNX.4.61.0508121132060.18385@nylon.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0508121132060.18385@nylon.am.freescale.net>; from galak@freescale.com on Fri, Aug 12, 2005 at 11:32:57AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 11:32:57AM -0500, Kumar Gala wrote:
> The lack of spin_lock_init causes badness in the preempt configuration.

Please don't - I have a patch in the wings which fixes this properly.
Unfortunately, its behind a ton of other patches, and I don't want
to try to find all these fixes in each driver.

This is wrong because we will re-initialise it from an indeterminant
state (it might be locked) later during the initialisation.  Let's
fix it properly.

(Since Linus pulled the shutters down when I still had a large chunk
of stuff in my serial tree, my serial patch merging is currently at
a complete standstill.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
