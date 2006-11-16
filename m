Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162129AbWKPArR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162129AbWKPArR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162128AbWKPArR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:47:17 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:48838 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1162129AbWKPArP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:47:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: divy <divy@chelsio.com>
Subject: Re: [PATCH] cxgb3: Chelsio T3 1G/10G ethernet device driver
Date: Thu, 16 Nov 2006 01:46:27 +0100
User-Agent: KMail/1.9.5
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <455BACB8.4010902@chelsio.com>
In-Reply-To: <455BACB8.4010902@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611160146.27412.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 01:11, divy wrote:
> This patch adds support for the latest Chelsio adapter, T3.
>
> Since some files are bigger than the 40kB advertized in the submit
> guidelines, a monolithic patch against 2.6.19-rc5 is posted at the
> following URL: http://service.chelsio.com/kernel.org/cxgb3.patch.bz2
>
> Please advise on any other form you would like to see the code.

You should still attempt to post it as inline email for better review.
The hard limit on mails is 100kb right now, IIRC, so it should be
possible to split it up into smaller chunks for review.

> We wish this patch to be considered for inclusion in 2.6.20. This driver
> will be required by the Chelsio T3 RDMA driver which will be posted for
> review asap.

Two things I noticed on a very brief review:

- The driver is _huge_. Even if your hardware is terribly complicated,
  the fact that you need 600kb to drive it is a hint that you do
  something wrong. In particular, the header files contain hundreds
  of macros that are completely unused. You should get rid of them.

- You define a driver specific multiplexing ioctl method. This is
  something you really shouldn't do in a network driver, since the
  ioctl number will conflict with other drivers. In order to get
  the rest of your code merged, I'd suggest you split out the
  private ioctl handling into a separate patch that you don't submit
  for now, and then we can think of how to replace the interfaces
  with something better, e.g. new driver-independent calls like ioctl
  or ethtool or sysfs, or get rid of them if they turn out to be
  not required.

	Arnd <><
