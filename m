Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVDDOAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVDDOAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 10:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVDDOAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 10:00:23 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:46814 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261240AbVDDOAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 10:00:13 -0400
Subject: Re: iomapping a big endian area
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1112601039.26086.49.camel@gaston>
References: <1112475134.5786.29.camel@mulgrave>
	 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
	 <20050402183805.20a0cf49.davem@davemloft.net>
	 <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
	 <1112499639.5786.34.camel@mulgrave>
	 <20050402200858.37347bec.davem@davemloft.net>
	 <1112502477.5786.38.camel@mulgrave>  <1112601039.26086.49.camel@gaston>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 08:59:03 -0500
Message-Id: <1112623143.5813.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 17:50 +1000, Benjamin Herrenschmidt wrote:
> I disagree. The driver will never "know" ...

? the driver has to know.  Look at the 53c700 to see exactly how awful
it is.  This beast has byte and word registers.  When used BE, all the
byte registers alter their position (to both inb and readb).

> I don't think it's sane. You know that your device is BE or LE and use
> the appropriate interface. "native" doesn't make sense to me in this
> context.

Well ... it's like this. Native means "pass through without swapping"
and has an easy implementation on both BE and LE platforms.  Logically
io{read,write}{16,32}be would have to do byte swaps on LE platforms.
Being lazy, I'm opposed to doing the work if there's no actual use for
it, so can you provide an example of a BE bus (or device) used on a LE
platform that would actually benefit from this abstraction?

James


