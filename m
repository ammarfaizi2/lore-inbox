Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932797AbWF2Vn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbWF2Vn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbWF2Vn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:43:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63720 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932797AbWF2Vnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:43:55 -0400
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] VIDEO_V4L1 shouldn't be
	user-visible
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060629210829.GG19712@stusta.de>
References: <20060629192124.GD19712@stusta.de>
	 <1151612317.3728.34.camel@praia>  <20060629210829.GG19712@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 29 Jun 2006 18:43:31 -0300
Message-Id: <1151617411.3728.66.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian,
Em Qui, 2006-06-29 às 23:08 +0200, Adrian Bunk escreveu:
> On Thu, Jun 29, 2006 at 05:18:37PM -0300, Mauro Carvalho Chehab wrote:

> I might not understand the issue well enough for getting your point.
> 
> My point is:
> 
> For users (= people compiling their own kernel), the obsolete in-kernel 
> API is an implementation detail.

It is not the in-kernel API, but the userspace API.

V4L1 api cannot handle several needs from userspace. 

For example, V4L1 API, there are just 3 video standards: PAL (you can
read here EU PAL), NTSC (you can read here US NTSC) and SECAM ( you can
read here France). So, api works fine only on two continents. All the
rest of the globe cannot use a V4L1 for a TV device. On V4L2 API, you
can select all known video standards (like for example NTSC/M Korea -
with have some particular issues with audio channels that require some
adjustments at audio decoders).

> When configuring the kernel, the important thing for users is to find 
> the driver for their hardware, not which internal APIs the driver is 
> using.

The user still can still select the proper hardware support, being
warned that the device is obsolete, and a proper legacy application
should be used instead.

I did the comparative between OSS/ALSA and V4L1/V4L2 because the
similarities. Both OSS and V4L1 are obsoleted APIs that need to be
removed from kernel, due to implementation issues. OSS is marked as
depreciated at Kconfig menus. User can include an OSS driver and use it,
but should know that those stuff is obsolete. The same should apply to
video/radio users.

Also, on V4L side, the V4L1 api is stopping V4L development. V4L API 2
is already at kernel since the beginning of kernel 2.6 series, and fixes
several flaws at the old api (V4L1 API were designed on 2.1 series).
Still now, most applications still implement only V4L1, and people do
submit newer v4l1 drivers to us.

We do really go ahead, making V4L2 API the standard.

> The userspace visible part VIDEO_V4L1_COMPAT is something different, 
> and it shouldn't be hidden.

Allowing unselecting V4L1 and V4L1_COMPAT is also very useful for
testing the compliance of applications, helping application developers
as well.

Cheers, 
Mauro.

