Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWCMTYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWCMTYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWCMTYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:24:34 -0500
Received: from mx.pathscale.com ([64.160.42.68]:50892 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932320AbWCMTYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:24:33 -0500
Subject: Re: [PATCH 18 of 20] ipath - kbuild infrastructure
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: rjwalsh@pathscale.com, rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060313181025.GA13973@stusta.de>
References: <patchbomb.1141950930@eng-12.pathscale.com>
	 <867a396dd518ac63ab41.1141950948@eng-12.pathscale.com>
	 <20060313181025.GA13973@stusta.de>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Mon, 13 Mar 2006 11:24:28 -0800
Message-Id: <1142277868.9032.14.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 19:10 +0100, Adrian Bunk wrote:

> I'm still a bit surprised, since in the rest of the kernel we are even 
> going from -O2 to -Os for getting better performance.
> 
> Robert said he wanted to post some numbers showing that -O3 is 
> measurably better for you [1], but I haven't seen them.

I just ran some numbers.  At large packet sizes, it doesn't matter what
options we use, because we spend all of our time in __iowrite_copy32,
which uses the string copy instructions.

For small packets, my quick tests indicate that -Os gives about 5%
*better* performance than -O3 (using gcc 4 on FC4).  This is in line
with what people have been finding in the kernel in general recently.

So if I change that CFLAGS line from -O3 to -Os, are we in OK
shape?  :-)

> > +_ipath_idstr:="PathScale $(shell date +%F)"
> > +EXTRA_CFLAGS += -DIPATH_IDSTR='$(_ipath_idstr)' -DIPATH_KERN_TYPE=0
> >...
> 
> UTS_VERSION is already available and printed at the top of dmesg.
> I don't see the point in printing it a second time.

Good point.  The idstr stuff is for our out-of-tree drivers.

Thanks,

	<b

