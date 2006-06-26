Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWFZNHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWFZNHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFZNHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:07:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52627 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932296AbWFZNHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:07:03 -0400
Subject: Re: [PATCH] Kconfig for radio cards to allow VIDEO_V4L1_COMPAT
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910606251040v62675399gdfe438aaac691a5a@mail.gmail.com>
References: <9e4733910606251040v62675399gdfe438aaac691a5a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 26 Jun 2006 10:06:53 -0300
Message-Id: <1151327213.3687.13.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon,

Em Dom, 2006-06-25 às 13:40 -0400, Jon Smirl escreveu:
> In Kconfig all of the radio cards depend on VIDEO_V4L1. But V4L1 has
> been deprecated and replaced with V4L2. V4L2 offers a V4L1
> compatibility layer. Should the Kconfig for these devices be changed
> to depend on (VIDEO_V4L1. || VIDEO_V4L1_COMPAT)? I'm not the
> maintainer for this but they seem to build ok.
No, it isn't. V4L1_COMPAT gets a userspace request, using the obsoleted
V4L1 API and converts into a V4L2 call to be handled by a V4L2 driver. 

All radio stuff at kernel are still using the old obsoleted V4L1 API,
and requires some changes to be V4L2 compliant. The correct fix is to
replace the old calls to V4L2 calls, and include videodev2.h header
instead of videodev.h.

After those changes, we should move the dependencies to be VIDEO_V4L2,
instead of VIDEO_V4L1.

Cheers, 
Mauro.

