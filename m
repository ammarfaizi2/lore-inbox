Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWBZVNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWBZVNf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWBZVNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:13:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:46782 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751407AbWBZVNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:13:34 -0500
Subject: Re: old radeon latency problem still unfixed?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1140982513.24141.118.camel@mindpipe>
References: <1140917787.24141.78.camel@mindpipe>
	 <1140945232.2934.0.camel@laptopd505.fenrus.org>
	 <1140982513.24141.118.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 08:11:33 +1100
Message-Id: <1140988293.3982.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> AFAICT it's more like trading 3D performance for having audio work at
> all.  Other video drivers that were too aggressive and caused audio
> dropouts (VIA) were fixed, even though there was a slight performance
> cost.

In addition, the radeon DRI shouldn't do active spinning like that in
"normal" circumstances ... it should instead block on interrupts. if it
does, I suppose that could safely be considered as a bug in the radeon
DRM/DRI driver. It will do such loops on engine reset and such, which
happen on X launch, VT switches or in case of lockups... I have to
double check what happens in the code path used for 2d/3d transitions
though, those might be a problem.

Ben.


