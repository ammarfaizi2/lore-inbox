Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbVJ0VxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbVJ0VxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbVJ0VxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:53:15 -0400
Received: from pat.qlogic.com ([198.70.193.2]:63297 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S932649AbVJ0VxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:53:14 -0400
Date: Thu, 27 Oct 2005 14:53:13 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Badari Pulavarty <pbadari@gmail.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.14-rc5-mm1
Message-ID: <20051027215313.GB7889@plap.qlogic.org>
References: <20051024014838.0dd491bb.akpm@osdl.org> <1130186927.6831.23.camel@localhost.localdomain> <20051024141646.6265c0da.akpm@osdl.org> <20051027152637.GC7889@plap.qlogic.org> <20051027190227.GA16211@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051027190227.GA16211@infradead.org>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 27 Oct 2005 21:53:13.0829 (UTC) FILETIME=[D46DE950:01C5DB40]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005, Christoph Hellwig wrote:

> On Thu, Oct 27, 2005 at 08:26:37AM -0700, Andrew Vasquez wrote:
> > qlogicfc attaches to both 2100 and 2200 ISPs.  It seems you're then
> > trying to load qla2xxx driver along with the 2300 and 2200 firmware
> > loader modules.  The pci_request_regions() call during 2200 probing
> > fails.
> 
> Btw, now that devfs is gone and thus DaveM's host renumbering issues
> are modd we'd like to kill qlogicfc.  I vaguely remember people complaing
> qla2xxx made trouble on qla2100 hardware.  Andrew do you have any success
> or error reports for that hardware?

A couple of months ago I had worked with a 2100 user who was having
some serious problems within a configuration.  I was able to reproduce
something similar in-house and (to make a long-story, short), it turns
out there are some error-recovery problems in the firmware version
currently shipping in qla2xxx (1.19.25 TP firmware to be exact).

After numerous trial and error efforts, we were able to find a
reasonbly stable release with which the customer's configuration could
recover and run (1.17.38 EF, quite old).

In any case, formally, QLogic has dropped *all* support for ISP2100
cards, and thus, it's quite difficult to get any type of traction
from the firmware folk to begin to root-cause the failures.

I'm still in the process of ironing out the .bin distribution details
locally, but perhaps once we migrate to firmware-loading exclusively
via request_firmware(), the (small?) contigent of 2100 could use the
EF variant I referenced above.

Could I get another informal count of 2100 users who are still having
problems with qla2xxx?

Regards,
Andrew Vasquez
