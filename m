Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUJIBmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUJIBmy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 21:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUJIBmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 21:42:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:50605 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266218AbUJIBmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 21:42:53 -0400
Subject: Re: [RFC][PATCH] TTY flip buffer SMP changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041008150055.GA13870@thunk.org>
References: <1097179099.1519.17.camel@deimos.microgate.com>
	 <1097177830.31768.129.camel@localhost.localdomain>
	 <20041008062650.GC2745@thunk.org>
	 <1097242506.2008.30.camel@deimos.microgate.com>
	 <1097239894.2290.13.camel@localhost.localdomain>
	 <20041008150055.GA13870@thunk.org>
Content-Type: text/plain
Message-Id: <1097286154.5592.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 11:42:35 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 01:00, Theodore Ts'o wrote:

> You can have the driver hang on to the sk_buff for several interrupts
> until it decides to push the data to the line displine.  So even if
> the FIFO is small, we only have to allocate/deallocate the skbuff only
> but rarely, unless someone really needs low_latency --- which should
> be but rarely. 

That reminds me... a while ago, I toyed with the idea of having DMA
support in pmac_zilog. The case where it would work well is typically
for things that have a known sized frame. If that information was
provided down to the driver, I could setup the DMA descriptor for
that frame size & have it interrupt me when the frame is complete,
along with a timeout set to the estimated time for receiving such
a frame + X% (I was thinking +20%)

Ben.


