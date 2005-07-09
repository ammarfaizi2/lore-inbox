Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263160AbVGIHeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbVGIHeS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 03:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbVGIHeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 03:34:18 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:46525 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S263160AbVGIHeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 03:34:17 -0400
Date: Sat, 9 Jul 2005 09:34:18 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
cc: 7eggert@gmx.de, Jeremy Laine <jeremy.laine@polytechnique.org>,
       linux-kernel@vger.kernel.org,
       "v4l @pop3.web.de>> Linux and Kernel Video" 
	<video4linux-list@redhat.com>
Subject: Re: OOPS: frequent crashes with bttv in 2.6.X series (inc. 2.6.12)
In-Reply-To: <42CEB58E.5030401@brturbo.com.br>
Message-ID: <Pine.LNX.4.58.0507090923550.4231@be1.lrz>
References: <4nrlt-8po-15@gated-at.bofh.it> <4nrlt-8po-13@gated-at.bofh.it>
 <E1DqYg4-0001fC-VN@be1.7eggert.dyndns.org> <42CEB58E.5030401@brturbo.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, Mauro Carvalho Chehab wrote:

> 	It looks to be an old reported trouble with bttv cards.
> 
> 	There is a doc at kernel that treats this subject. It is at:
> 		Documentation/video4linux/bttv/README.freeze
> 
> 
> 	Overlay works by transfering data from BTTV card directelly to Video Card.
> 
> 	This looks to be problem related to DMA troubles on some motherboards.

I've found the no_overlay parameter to be promising, but it seems to be 
unused by the driver:

$ grep -r no_overlay drivers/*
drivers/media/video/bttv-cards.c:static unsigned int no_overlay=-1;
drivers/media/video/bttv-cards.c:module_param(no_overlay, int, 0444);
drivers/media/video/bttv-cards.c:               if (UNSET == no_overlay) {
drivers/media/video/bttv-cards.c:                       no_overlay = 1;
$

It seems some patch has removed that feature, and I have no grepable pile 
of patches here nor an idea (except for google) where I can get one.
-- 
Top 100 things you don't want the sysadmin to say:
80. I cleaned up the root partition and now there's LOTS of free space.
