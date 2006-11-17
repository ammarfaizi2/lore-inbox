Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933590AbWKQOOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933590AbWKQOOg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933599AbWKQOOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:14:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41706 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933590AbWKQOOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:14:35 -0500
Subject: Re: [v4l-dvb-maintainer] -mm: cx88-blackbird.c: unused code
	re-added
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061117124238.GV31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061117124238.GV31879@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 17 Nov 2006 12:13:42 -0200
Message-Id: <1163772822.20349.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Em Sex, 2006-11-17 às 13:42 +0100, Adrian Bunk escreveu:
> On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.19-rc5-mm2:
> >...
> >  git-dvb.patch
> >...
> >  git trees
> >...
> 
> Why does this patch re-add the still unused cx88_ioctl_hook and 
> cx88_ioctl_translator in drivers/media/video/cx88/cx88-blackbird.c 
> I removed a few months ago?
Hmm... I think I sent to my -git the patch that reenables it.

Let me explain a little bit about those hooks.

As you know, ivtv is being re-worked to be inserted at kernel. This
includes a complete API review of several ivtv calls. Some of they were
providing stuff already at V4L2 API, but implemented on a different way.
This turned into a huge project, being delayed with the first scheduling
time. First, we've migrated all i2c drivers. Then mpeg decoding. Now, we
are working at mpeg encoding part.

cx88-blackbird provides mpeg outputs for analog tv, in a similar way as
ivtv devices. However, some userspace apps were not implementing the
experimental mpeg support added at V4L2 api for mpeg streams, but
instead, were using an API developed for ivtv.

We received a patch for a cx88-ivtv module that allows using
ivtv-enabled programs to work with cx88-blackbird. 

To avoid causing later regressions of removing IVTV API calls from
kernel, we decided to create the hooks at kernel, and having cx88-ivtv
only at v4l-dvb tree. The proper API calls will be added as soon as ivtv
driver will be finished and the proper api is available to be
incorporated at cx88-blackbird.

Anyway, I've redesigned cx88 to use video_ioctl2 interface, who is
incompatible with the hooks. The newer approach is at:
http://www.linuxtv.org/hg/~mchehab/cx88_ioctls

After merging this branch into the v4l-dvb tree, the patches will be
removed. I intend to apply those changes to 2.6.20, so, there's no need
to worry about this stuff.

>  
> cu
> Adrian
> 
Cheers, 
Mauro.

