Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265785AbUFSDuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUFSDuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 23:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265809AbUFSDuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 23:50:24 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:58283 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265785AbUFSDuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 23:50:10 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ian Molton <spyro@f2s.com>
Cc: david-b@pacbell.net, Linux Kernel <linux-kernel@vger.kernel.org>,
       greg@kroah.com, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com
In-Reply-To: <20040619011416.64d16c4e.spyro@f2s.com>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.com> <40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com>
	<1087588627.2134.155.camel@mulgrave>
	<20040619002522.0c0d8e51.spyro@f2s.com>
	<1087601363.2078.208.camel@mulgrave>
	<20040619005106.15b8c393.spyro@f2s.com>
	<1087603453.2135.224.camel@mulgrave> 
	<20040619011416.64d16c4e.spyro@f2s.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 22:49:49 -0500
Message-Id: <1087616990.2078.240.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 19:14, Ian Molton wrote:
> On 18 Jun 2004 19:04:11 -0500
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> 
> > Because the piece of memory you wish to access is bus remote. 
> 
> No, its *not*
> 
> my CPU can write there directly.
> 
> no strings attached.
> 
> the DMA API just only understands how to map from RAM, not anything
> else.

I think you'll actually find that it is.  OHCI is a device (representing
a USB hub), it's attached to the system by some interface that
constitutes a bus (the bus interface transforming the CPU access cycles
to device access cycles, translating interrupts etc.).

But even if you've somehow managed to glue an OHCI directly on to the
system memory controller, from the point of view of the DMA API, the
memory the device contains is still bus remote.  To be useful, the API
has to deal with bus remote memory in all its forms.

James


