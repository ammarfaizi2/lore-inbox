Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbUBTPKb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUBTPKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:10:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:61668 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261272AbUBTPK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:10:26 -0500
Date: Fri, 20 Feb 2004 07:15:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, greg@kroah.com,
       akpm@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB update for 2.6.3
In-Reply-To: <20040219233214.56f5b0ce.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0402200714270.1107@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com> <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
 <1077256996.20789.1091.camel@gaston> <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
 <1077258504.20781.1121.camel@gaston> <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
 <1077259375.20787.1141.camel@gaston> <Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org>
 <20040219230407.063ef209.davem@redhat.com> <1077261041.20787.1181.camel@gaston>
 <20040219233214.56f5b0ce.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, David S. Miller wrote:
> On Fri, 20 Feb 2004 18:10:41 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Hrm... so if the USB device drivers are actually doing the dma mapping
> > themselves, it make sense for them to pass their own struct device, no ?
> 
> That's right, at least that was the idea.

No. That would be _fundamentally_ wrong.

There's no way a USB device can do DMA in the first place. It has no DMA 
controller, and no way to read/write memory except through the USB host.

So it is the host - and only the host - that matters. Anything else is a 
bug.

		Linus
