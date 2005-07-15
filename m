Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263208AbVGOFXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbVGOFXQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 01:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbVGOFXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 01:23:15 -0400
Received: from b.mail.sonic.net ([64.142.19.5]:46299 "EHLO b.mail.sonic.net")
	by vger.kernel.org with ESMTP id S263208AbVGOFVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 01:21:53 -0400
Date: Thu, 14 Jul 2005 22:21:39 -0700
From: David Hinds <dhinds@sonic.net>
To: somshekar.c.kadam@in.abb.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sandisk Compact Flash
Message-ID: <20050715052139.GA7788@sonic.net>
References: <OFF2465F02.D3F1F2D8-ON6525703D.0049BB41-6525703D.004A8B94@in.abb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF2465F02.D3F1F2D8-ON6525703D.0049BB41-6525703D.004A8B94@in.abb.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 07:04:38PM +0530, somshekar.c.kadam@in.abb.com wrote:
> 
> I ma newbie to compactflash driver , I am using mpc862 PPC processor
> on my custom board having 64mb ram running linuxppc-2.4.18 kernel .
> i am using Sandisk Extreme CF 1GB which is 133x high speed, but
> found the performance with other kingston 1GB CF with slower speed ,
> is both same , CF is implemented on pcmcia port , i am not sure what
> is the mode set for transfer , Feature set command is used in which
> it sets the PIO mode or Multiword DMA transfer mode by specifying
> its value in Sector count register , i am not able to understand in
> linux kernel ide driver where this is set , is it by default set ,
> this mode is set or we need to set it , i think we should assign
> this value , right now i am not able to trace this in my code.  ,

All Compact Flash cards, in 16-bit PCMCIA card readers, operate in PIO
mode 1 (polled IO, no DMA), which means you will get only about 1
MB/sec regardless of the card's claimed tranfer speed.  Some cameras
also only support this mode; others will run CF cars in "TrueIDE"
mode, which is required to use the DMA transfer modes.

There are high performance CF card readers that can use TrueIDE mode:
both CardBus ones and Firewire ones.  For example:

http://www.dpreview.com/news/0310/03102103delkincardbustest.asp

It sounds like your card reader is one of the slow 16-bit ones.

-- Dave
