Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270007AbUJHPC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270007AbUJHPC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270008AbUJHPC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:02:29 -0400
Received: from [69.25.196.29] ([69.25.196.29]:46503 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S270007AbUJHPC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:02:28 -0400
Date: Fri, 8 Oct 2004 11:00:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] TTY flip buffer SMP changes
Message-ID: <20041008150055.GA13870@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Fulghum <paulkf@microgate.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097179099.1519.17.camel@deimos.microgate.com> <1097177830.31768.129.camel@localhost.localdomain> <20041008062650.GC2745@thunk.org> <1097242506.2008.30.camel@deimos.microgate.com> <1097239894.2290.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097239894.2290.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 01:51:36PM +0100, Alan Cox wrote:
> On Gwe, 2004-10-08 at 14:35, Paul Fulghum wrote:
> > It does seem to carry serious overhead (in relation
> > to ring buffers) for devices with small FIFOs.
> 
> Thats one reason I wanted sk_buff like rather than sk_buff. I want
> to be able to recycle buffers back to drivers when the driver thinks
> its the right thing to do.

You can have the driver hang on to the sk_buff for several interrupts
until it decides to push the data to the line displine.  So even if
the FIFO is small, we only have to allocate/deallocate the skbuff only
but rarely, unless someone really needs low_latency --- which should
be but rarely. 

						- Ted
