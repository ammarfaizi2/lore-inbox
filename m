Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWBZWxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWBZWxo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWBZWxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:53:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:65215 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751191AbWBZWxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:53:44 -0500
Subject: Re: old radeon latency problem still unfixed?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1140989489.24141.159.camel@mindpipe>
References: <1140917787.24141.78.camel@mindpipe>
	 <1140945232.2934.0.camel@laptopd505.fenrus.org>
	 <1140982513.24141.118.camel@mindpipe>
	 <1140988293.3982.8.camel@localhost.localdomain>
	 <1140989489.24141.159.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 09:53:46 +1100
Message-Id: <1140994427.3982.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 16:31 -0500, Lee Revell wrote:
> On Mon, 2006-02-27 at 08:11 +1100, Benjamin Herrenschmidt wrote:
> > > AFAICT it's more like trading 3D performance for having audio work at
> > > all.  Other video drivers that were too aggressive and caused audio
> > > dropouts (VIA) were fixed, even though there was a slight performance
> > > cost.
> > 
> > In addition, the radeon DRI shouldn't do active spinning like that in
> > "normal" circumstances ... it should instead block on interrupts. if it
> > does, I suppose that could safely be considered as a bug in the radeon
> > DRM/DRI driver. It will do such loops on engine reset and such, which
> > happen on X launch, VT switches or in case of lockups... I have to
> > double check what happens in the code path used for 2d/3d transitions
> > though, those might be a problem.
> 
> What about switching from 2D->3D mode, like when xscreensaver kicks in?
> IIRC people reported audio underruns when that happened but I could
> never narrow it down any further.

Well... as soon as a 3d window appears, the server starts switching all
the time. there might be some spin loop in there remaining...

> If as Arjan said the only lock this driver takes is the BKL then it's
> either a local config issue (ancient kernel or failure to enable preempt
> BKL) or something at the hardware level... I'm waiting for more info
> from the original reporter.

Ben.


