Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbVCPVTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVCPVTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVCPVTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:19:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21147 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262805AbVCPVSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:18:05 -0500
Date: Wed, 16 Mar 2005 21:17:55 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CON_BOOT
Message-ID: <20050316211755.GS21986@parcelfarce.linux.theplanet.co.uk>
References: <20050315222706.GI21986@parcelfarce.linux.theplanet.co.uk> <20050315143711.4ae21d88.akpm@osdl.org> <20050316130759.GL21986@parcelfarce.linux.theplanet.co.uk> <20050316130948.678ca2f2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316130948.678ca2f2.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 01:09:48PM -0800, Andrew Morton wrote:
> It doesn't sound terribly important - I was just curious, thanks.  We can
> let this one be demand-driven.

OK, thanks ;-)

> I'm surprised that more systems don't encounter this - there's potentially
> quite a gap between console_init() and the bringup of the first real
> console driver.  What happens if we crash in mem_init()?  Am I misreading
> the code, or do we just get no info?

You're spot on, we get no info.  That's why there's a bunch of kludges
around, mostly called early_printk.  But most people use x86 and they
get console output sufficiently early anyway because they know their
serial port is at 0x3f8 ...

I just realised that with CON_BOOT, we could actually get rid of the
__con_initcall loop in tty_io.c and let all the horrible early serial
console stuff disappear.

This console stuff really needs a dedicated maintainer ... wonder if
we can find a sucker ...

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
