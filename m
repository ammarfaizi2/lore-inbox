Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbTELPr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTELPr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:47:59 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:37013 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262235AbTELPr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:47:58 -0400
Date: Mon, 12 May 2003 18:00:29 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Dave Jones <davej@codemonkey.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kconfig goodies
Message-ID: <20030512160029.GJ5376@louise.pinerecords.com>
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv> <20030512143207.GA6459@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512143207.GA6459@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [davej@codemonkey.org.uk]
> 
> On Mon, May 12, 2003 at 03:39:11PM +0200, Roman Zippel wrote:
> 
>  > config AGP
>  > 	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
>  > 	default y if GART_IOMMU
>  > 
>  > this can be changed into:
>  > 
>  > config AGP
>  > 	tristate "/dev/agpgart (AGP Support)"
>  > 
>  > config GART_IOMMU
>  > 	bool "IOMMU support"
>  > 	enable AGP
>  > 
>  > This will cause AGP to be selected if GART_IOMMU is selected.
> 
> Looks good. However, will this still offer the CONFIG_AGP tristate
> in the menu? If IOMMU is on, there must be no way to switch off
> the agpgart support on which it depends.

Also, will the config system let the user know that their having
enabled a certain option has affected other options (possibly in
different submenus)?  As things work now, there's no way to tell
if an option has been switched on "by dependency," so in the above
example, in switching GART_IOMMU off after its switching on has
enabled AGP, the system won't know to disable AGP again.  I'm not
convinced this is a nice feature in fact. :)  Maybe we just need
something like grayed-out entries with a comment, for instance:

/* [ ] IOMMU support (needs "/dev/agpgard (AGP Support)") */

-- 
Tomas Szepe <szepe@pinerecords.com>
