Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264972AbUFSAIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264972AbUFSAIf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbUFSAIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:08:10 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:64986 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264972AbUFSAEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 20:04:21 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ian Molton <spyro@f2s.com>
Cc: david-b@pacbell.net, Linux Kernel <linux-kernel@vger.kernel.org>,
       greg@kroah.com, tony@atomide.com, jamey.hicks@hp.com,
       joshua@joshuawise.com
In-Reply-To: <20040619005106.15b8c393.spyro@f2s.com>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.com> <40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com>
	<1087588627.2134.155.camel@mulgrave>
	<20040619002522.0c0d8e51.spyro@f2s.com>
	<1087601363.2078.208.camel@mulgrave> 
	<20040619005106.15b8c393.spyro@f2s.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 19:04:11 -0500
Message-Id: <1087603453.2135.224.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 18:51, Ian Molton wrote:
> Im aware of that but the OHCI core doesnt do that, it uses the DMA API,
> which is entirely reasonable, given its tring to access a DMA-able chunk
> of memory.
> 
> I *could* write a new driver ohci-ioremapped for all these chips but its
> needless duplication which is going to result in bugs bveing fixed in
> one ohci driver and not the other.
> 
> why not simply expand the DMA API to allow DMA to these easily DMA-able
> chips ?

Because the piece of memory you wish to access is bus remote.  Our
current API for bus remote memory requires the use of ioremap and the
accessor functions.  Just because it could be accessed directly on ARM
doesn't mean it can be on all platforms.  The DMA API is a platform
generic API.  To propose an addition to it to make use of this memory,
it would have to work on *all* platforms.

James


