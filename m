Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVDCDlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVDCDlW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 22:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVDCDlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 22:41:22 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:58824 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261179AbVDCDlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 22:41:17 -0500
Subject: Re: iomapping a big endian area
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: "David S. Miller" <davem@davemloft.net>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
References: <1112475134.5786.29.camel@mulgrave>
	 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
	 <20050402183805.20a0cf49.davem@davemloft.net>
	 <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Sat, 02 Apr 2005 21:40:39 -0600
Message-Id: <1112499639.5786.34.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-03 at 04:10 +0100, Matthew Wilcox wrote:
> > SPARC64 can do it in the PTEs, but we just use raw physical
> > addresses in our I/O accessors, and in those load/store instructions
> > we can specify the endianness.
> 
> Ah right.  So you'd prefer an ioread8be() interface?

Actually, ioread8be is unnecessary, but I was planning to add
ioread16/ioread32 and iowritexx be on be variants (equivalent to
_raw_readw et al.)

After all, the driver must know the card is BE, so the routines that
make use of the feature are easily coded into the card, so there's no
real need to add it to the iomem cookie.

Did anyone have a preference for the API?  I was thinking
ioread32_native, but ioread32be is fine too.

James


