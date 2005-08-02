Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVHBMDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVHBMDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVHBMDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:03:45 -0400
Received: from isilmar.linta.de ([213.239.214.66]:22674 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261458AbVHBMDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:03:44 -0400
Date: Tue, 2 Aug 2005 14:03:43 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Obvious bugfix for yenta resource allocation
Message-ID: <20050802120343.GA27763@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Paul Mackerras <paulus@samba.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <17135.24136.268138.511779@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17135.24136.268138.511779@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 09:51:36PM +1000, Paul Mackerras wrote:
> Recent changes (well, dating from 12 July) have broken cardbus on my
> powerbook: I get 3 messages saying "no resource of type xxx available,
> trying to continue", and if I plug in my wireless card, it complains
> that there are no resources allocated to the card.  This all worked in
> 2.6.12.
> 
> Looking at the code in yenta_socket.c, function yenta_allocate_res,
> it's obvious what is wrong: if we get to line 639 (i.e. there wasn't a
> usable preassigned resource), we will always flow through to line 668,
> which is the printk that I was seeing, even if a resource was
> successfully allocated.  It looks to me as though there should be a
> return statement after the two config_writel's in each of the 3
> branches of the if statements, so that the function returns after
> successfully setting up the resource.
> 
> The patch below adds these return statements, and with this patch,
> cardbus works on my powerbook once again.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Sorry for the bug.

	Dominik
