Return-Path: <linux-kernel-owner+w=401wt.eu-S1751438AbXAOTur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbXAOTur (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbXAOTur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:50:47 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:53986 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbXAOTuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:50:46 -0500
Date: Mon, 15 Jan 2007 14:50:29 -0500
From: Eric Buddington <ebuddington@verizon.net>
Subject: Re: 2.6.20-rc4-mm1 USB (asix) problem
In-reply-to: <1168889276.19899.105.camel@dhollis-lnx.sunera.com>
To: David Hollis <dhollis@davehollis.com>
Cc: ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
Reply-to: ebuddington@wesleyan.edu
Message-id: <20070115195024.GA8135@pool-71-123-103-45.spfdma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
References: <20070113203113.GB14587@pool-71-123-103-45.spfdma.east.verizon.net>
 <1168889276.19899.105.camel@dhollis-lnx.sunera.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 07:27:56PM +0000, David Hollis wrote:
> Do you happen to have a Rev. B1 DLink adapter?  If so, the only change
> that was put in (PHY Select fix) should actually make these devices
> work.  Can you check the top of the ax88772_bind() call in your file and
> see if it has this bit:
> 
>         if ((ret = asix_write_cmd(dev, AX_CMD_SW_PHY_SELECT,
>                                 1, 0, 0, buf)) < 0) {
>                 dbg("Select PHY #1 failed: %d", ret);
>                 goto out2;
>         }
> 
> 
> That '1' after the AX_CMD_SW_PHY_SELECT was the key to that patch.  If
> yours is 1, you could try setting it to 0, though that should make
> things not work.  I'd very interested if it made things work for you.
> BTW, the ramifications of this bug were similar to what you describe:
> the interface would come up, look fine but just wouldn't send or receive
> any packets. The hard lock-ups and such are likely from something else.

I don't know the Rev number of the adapter; I can't get to it physically
today, and I don't see it in dmesg.

The asix_write_cmd argument in question did indeed change from 0 to 1
between 2.6.20-rc3-mm1 and -rc4-mm1. I'll change it back, rebuild,
and test. Probably tomorrow.

Thanks.

-Eric
