Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268913AbUHMA3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268913AbUHMA3p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268914AbUHMA3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:29:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:53500 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S268913AbUHMA2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:28:07 -0400
Date: Thu, 12 Aug 2004 17:27:56 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Subject: Re: [patch] 2.6 -- add IOI Media Bay to SCSI quirk list
Message-ID: <20040813002756.GA21763@beaverton.ibm.com>
References: <200408122137.i7CLbGU13688@ra.tuxdriver.com> <20040812225118.GA20904@beaverton.ibm.com> <411BF6A5.2030306@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411BF6A5.2030306@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 07:00:53PM -0400, John W. Linville wrote:
> Patrick Mansfield wrote:
> 
> >We seem to be getting quite a few of these. In theory we could add a line
> >like this for every multi-lun SCSI device.
> > 
> >
> 
> Isn't that what the quirk list is for?

We should not add to the list for devices that behave as expected. I would
hope the number of borken BLIST_NOLUN devices is much smaller than the number
of good BLIST_FORCELUN devices.

The list is backwards compatible, so we have flags in there that are not
required, like BLIST_FORCELUN.

> >Can you instead try booting with scsi_mod.max_luns=8 (or such) or build
> >with SCSI_MULTI_LUN enabled?
> > 
> >
> 
> That works for my box, but what about for others?  Like those who may 
> have both a multi-lun device and a single-lun device that hangs on a 
> non-zero lun?  What about the average luser who can't be bothered to 
> hack-up his startup scripts or *gasp* rebuild his kernel?

Users should first set max_luns (or use a kernel built with
SCSI_MULTI_LUN), and then if they find a device that breaks have it added
to the quirks as BLIST_NOLUN. In the meantime they can boot using the
devinfo flag with BLIST_NOLUN.

I do not recall any reports (on linux-scsi) of devices that can't handle
LUN 0 requests, there is no change in the number of SCSI_NOLUN devices
from 2.4.21 to 2.6 (but I didn't check older kernels).

I had thought it was best to build without SCSI_MULTI_LUN, but given
the lack of SCSI_NOLUN additions, most users are better off with it on.

> It seems like the quirk list is there for a reason.  If we start 
> rejecting certain devices, then what is the criteria for a device to 
> actually make it on the list?

Only add borken devices to the list, so it is a list of bad devices rather
than a list of good ones.

-- Patrick Mansfield
