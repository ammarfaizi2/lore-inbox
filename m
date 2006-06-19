Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWFSKDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWFSKDx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWFSKDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:03:53 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:47336 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932332AbWFSKDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:03:52 -0400
Date: Mon, 19 Jun 2006 05:57:40 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Kernel panic when re-inserting Adaptec PCMCIA card
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Message-ID: <200606190600_MC3-1-C2D8-23E6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060614022139.21737.qmail@web50208.mail.yahoo.com>

On Tue, 13 Jun 2006 19:21:39 -0700, Alex Davis wrote:

Same panic occurs in 2.6.17rc6:

> Jun 13 17:50:36 siafu kernel: [4295220.230000] pccard: PCMCIA card inserted into slot 0
> Jun 13 17:50:36 siafu kernel: [4295220.230000] pcmcia: registering new device pcmcia0.0
> Jun 13 17:50:37 siafu kernel: [4295220.281000] aha152x: resetting bus...
> Jun 13 17:50:37 siafu kernel: [4295220.637000] aha152x13: vital data: rev=1, io=0xd340
> (0xd340/0xd340), irq=3, scsiid=7, reconnect=enabled,
>  parity=enabled, synchronous=enabled, delay=100, extended translation=disabled
> Jun 13 17:50:37 siafu kernel: [4295220.637000] aha152x13: trying software interrupt, ok.
> Jun 13 17:50:37 siafu kernel: [4295221.638000] scsi13 : Adaptec 152x SCSI driver; $Revision: 2.7 $
> Jun 13 17:50:37 siafu kernel: [4295221.650000]
> Jun 13 17:50:37 siafu kernel: [4295221.650000] aha152x22856: bottom-half already running!?
> Jun 13 17:50:37 siafu kernel: [4295221.650000]
> Jun 13 17:50:37 siafu kernel: [4295221.650000] queue status:
> Jun 13 17:50:37 siafu kernel: [4295221.650000] issue_SC:
> Jun 13 17:50:37 siafu kernel: [4295221.650000] current_SC:
> Jun 13 17:50:37 siafu kernel: [4295221.650000] BUG: unable to handle kernel paging request at
> virtual address 00020016

Something is going very wrong here.  At time .637 it says it is
adapter number 13 (aha152x13.)  Then at .650 it thinks it's
adapter nr. 22856 (!)  Looks like some kind of pointer to the
hostdata is corrupted.

Can you rmmod the driver after removing the card and see if that
helps?

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
