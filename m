Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVAJIpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVAJIpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 03:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVAJIpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 03:45:13 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63114 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262154AbVAJIpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 03:45:08 -0500
Date: Mon, 10 Jan 2005 09:45:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hikaru1@verizon.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: ide-cd in 2.6.8-2.6.10 and 2.4.26-2.4.28 high cpu use with dma
Message-ID: <20050110084501.GA31651@suse.de>
References: <20050109105201.GB12497@roll> <20050109105418.GD12497@roll> <20050109123028.GA12753@roll> <1105278277.12004.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105278277.12004.32.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09 2005, Alan Cox wrote:
> On Sul, 2005-01-09 at 12:30, Hikaru1@verizon.net wrote:
> > A minor mistake. I forgot to state explicitly that the problem only appears
> > with writing audio cds. Writing data cds does not cause problems.
> 
> It sets the required alignment of buffers for DMA. The 2.6.10 code is
> correct, the question is who is feeding unaligned buffers to the driver
> layer - the kernel or the SG layer. Which burning interface are you
> using  - /dev/sg  (ie dev=1,0,0) or /dev/hd*  (dev=/dev/hdc etc)

Look at the check, it's also doing length check. And for cdda burning,
you are never going to have 32-byte alignment, hence it false back to
pio.

-- 
Jens Axboe

