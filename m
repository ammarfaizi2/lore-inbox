Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVEMWnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVEMWnF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVEMWmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:42:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:34533 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262603AbVEMWgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:36:15 -0400
Date: Fri, 13 May 2005 15:36:12 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Lameter <christoph@lameter.com>, dely.l.sy@intel.com
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mingo@elte.hu, kenneth.w.chen@intel.com,
       shai@scalex86.org
Subject: Re: [RFC][PATCH] timers fixes/improvements
Message-ID: <20050513223611.GB15601@kroah.com>
References: <424D373F.1BCBF2AC@tv-sign.ru> <424E6441.12A6BC03@tv-sign.ru> <Pine.LNX.4.58.0505091312490.27740@graphe.net> <20050509144255.17d3b9aa.akpm@osdl.org> <Pine.LNX.4.58.0505091449580.29090@graphe.net> <42808B84.BCC00574@tv-sign.ru> <Pine.LNX.4.58.0505101212350.20718@graphe.net> <4281DC03.36011256@tv-sign.ru> <Pine.LNX.4.58.0505110804540.10451@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505110804540.10451@graphe.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 08:12:16AM -0700, Christoph Lameter wrote:
> We found that this has nothing to do with the timer patches. There is a
> scribble in pcie_rootport_aspm_quirk that overwrites ptype_all.

Ick.

> quirk_aspm_offset[GET_INDEX(pdev->device, dev->devfn)]= cap_base + 0x10;
> 
> does the evil deed. The array offset calculated by GET_INDEX is out of
> bounds.
> 
> The definition of GET_INDEX is suspect:
> 
> #define GET_INDEX(a, b) (((a - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + b)
> 
> should this not be
> 
> #define GET_INDEX(a, b) ((((a) - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + \
> 				((b) & 7))
> 
> ?

Dely, any thoughts about this, or know who would know about it?

thanks,

greg k-h
