Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVBNPMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVBNPMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 10:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVBNPMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 10:12:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64926 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261443AbVBNPMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 10:12:46 -0500
Date: Mon, 14 Feb 2005 15:12:44 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Christophe Lucas <c.lucas@ifrance.com>
Cc: kernel-janitors@lists.osdl.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH] drivers/char/watchdog/* : pci_request_regions
Message-ID: <20050214151244.GF29917@parcelfarce.linux.theplanet.co.uk>
References: <20050214150111.GH20620@rhum.iomeda.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214150111.GH20620@rhum.iomeda.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 04:01:11PM +0100, Christophe Lucas wrote:
> If PCI request regions fails, then someone else is using the
> hardware we wish to use. For that one case, calling
> pci_disable_device() is rather rude.
> See : http://www.ussg.iu.edu/hypermail/linux/kernel/0502.1/1061.html

Actually, that isn't necessarily true.  If the request_regions call fails,
that can mean there's a resource conflict.  If so, leaving the device
enabled is the worst possible thing to do as we'll now have two devices
trying to respond to the same io accesses.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
