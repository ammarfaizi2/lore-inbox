Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVCAOmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVCAOmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 09:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVCAOmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 09:42:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51858 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261928AbVCAOmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 09:42:14 -0500
Date: Tue, 1 Mar 2005 14:42:11 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050301144211.GI28741@parcelfarce.linux.theplanet.co.uk>
References: <422428EC.3090905@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422428EC.3090905@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 05:33:48PM +0900, Hidetoshi Seto wrote:
> Today's patch is 3rd one - iochk_clear/read() interface.
> - This also adds pair-interface, but not to sandwich only readX().
>   Depends on platform, starting with ioreadX(), inX(), writeX()
>   if possible... and so on could be target of error checking.

I'd prefer to see it as ioerr_clear(), ioerr_read() ...

> - Additionally adds special token - abstract "iocookie" structure
>   to control/identifies/manage I/Os, by passing it to OS.
>   Actual type of "iocookie" could be arch-specific. Device drivers
>   could use the iocookie structure without knowing its detail.

Fine.

> If arch doesn't(or cannot) have its io-checking strategy, these
> interfaces could be used as a replacement of local_irq_save/restore
> pair. Therefore, driver maintainer can write their driver code with
> these interfaces for all arch, even where checking is not implemented.

But many drivers don't need to save/restore interrupts around IO accesses.
I think defaulting these to disable and restore interrupts is a very bad idea.
They should probably be no-ops in the generic case.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
