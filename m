Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVDDHyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVDDHyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 03:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVDDHyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 03:54:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:7601 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261155AbVDDHxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 03:53:51 -0400
Subject: Re: iomapping a big endian area
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1112502477.5786.38.camel@mulgrave>
References: <1112475134.5786.29.camel@mulgrave>
	 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
	 <20050402183805.20a0cf49.davem@davemloft.net>
	 <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
	 <1112499639.5786.34.camel@mulgrave>
	 <20050402200858.37347bec.davem@davemloft.net>
	 <1112502477.5786.38.camel@mulgrave>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 17:50:39 +1000
Message-Id: <1112601039.26086.49.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-02 at 22:27 -0600, James Bottomley wrote:
> On Sat, 2005-04-02 at 20:08 -0800, David S. Miller wrote:
> > > Did anyone have a preference for the API?  I was thinking
> > > ioread32_native, but ioread32be is fine too.
> > 
> > I think doing foo{be,le}{8,16,32}() would be consistent with
> > our byteorder.h interface names.
> 
> Thinking about this some more, I know of no case of a BE bus connected
> to a LE system, nor do I think anyone would ever create such a beast, so
> our only missing interface is for a BE bus on a BE system.

It's more a matter of the device than the bus imho... 

> Thus, I think io{read,write}{16,32}_native are better interfaces ...

I disagree. The driver will never "know" ...

> they basically mean pass memory operations without byte swaps, so
> they're well defined on both BE and LE systems and correspond exactly to
> our existing _raw_{read,write}{w,l} calls (principle of least surprise).

I don't think it's sane. You know that your device is BE or LE and use
the appropriate interface. "native" doesn't make sense to me in this
context.

Ben.


