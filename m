Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUIBJV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUIBJV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUIBJV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:21:28 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:38317 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S268042AbUIBJUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:20:51 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: adaplas@pol.net
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Thu, 2 Sep 2004 11:23:25 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408312133.40039.ornati@fastwebnet.it> <200409011355.52999.ornati@fastwebnet.it> <200409020410.22617.adaplas@hotpop.com>
In-Reply-To: <200409020410.22617.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021123.26299.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 September 2004 22:10, Antonino A. Daplas wrote:
> On Wednesday 01 September 2004 19:55, Paolo Ornati wrote:
> > > This patch sets info->var.yres_virtual to the maximum upon driver
> > > load. If this works, it's possible to get sub-1 second scrolling
> > > speed.
> > >
> > > Reverse the previous patch first, then apply this patch.
> >
> > Results for 2.6.9-rc1 + your patch (time cat MAINTAINERS):
> >
> > CONFIG_FB_3DFX_ACCEL=n
> > ~1.27 s
> >
> > CONFIG_FB_3DFX_ACCEL=y
> > ~0.18 s
> >
> > BUT with CONFIG_FB_3DFX_ACCEL enabled I get strange video
> > "corruptions" (like bitmaps with random colors) that go away simply
> > swithcing to another console and than back to the previous.
>
> Might be a clipping problem?  Maybe we need to set an upper limit
> to vyres, don't know for sure.
>
> Try doing an fbset -vyres 800, then keep doubling the number until
> you get the artifacts.  If possible, do it for other bpp.

Doing some tests I've discovered that BPP doesn't influence this behavior 
(kernel 2.6.9-rc1 + your patch, CONFIG_FB_3DFX_ACCEL=y):

BPP   800    1600    3200    6400	<-- VYRES
8         OK       OK       OK       X
16       OK       OK       OK       X
24       OK       OK       OK       X
32       OK       OK       OK       X

The upper limit for VYRES (after a lot of tests) seems to be around 
4100/4200 (with 4100 all seems OK while with 4200 there are some 
corruptions). This is the same for all BPP.

I don't understand why I have this problem only with 
CONFIG_FB_3DFX_ACCEL=y...

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.8-gentoo-r3)
