Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVHLTtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVHLTtz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVHLTtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:49:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35088 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751267AbVHLTtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:49:53 -0400
Date: Fri, 12 Aug 2005 20:49:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] fix ucb1x00 support on collie
Message-ID: <20050812204946.D21152@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
References: <20050731134617.GA25906@elf.ucw.cz> <20050731164245.B20106@flint.arm.linux.org.uk> <20050807150802.C22977@flint.arm.linux.org.uk> <20050812111103.GD1826@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050812111103.GD1826@elf.ucw.cz>; from pavel@suse.cz on Fri, Aug 12, 2005 at 01:11:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 01:11:03PM +0200, Pavel Machek wrote:
> You still do:
> 
> Ser4MCCR0 = data->mccr0 | 0x7f7f;
> 
> ...I'm not sure, but it seems to me I want MMCR0 to be set to
> 0x60000. Would it be better to move 7f7f constant (what is it, anyway)
> to machine-specific code?

I do this because we want the MCP bus running at the lowest sample
speed initially.  When the drivers have initialised, they will call
mcp_sa1100_set_telecom_divisor() and mcp_sa1100_set_audio_divisor()
to set these fields appropriately.

They aren't machine specific.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
