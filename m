Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966348AbWKNUsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966348AbWKNUsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966349AbWKNUsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:48:39 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:8342 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S966348AbWKNUsi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:48:38 -0500
Message-ID: <455A2BAF.6010200@drzeus.cx>
Date: Tue, 14 Nov 2006 21:48:47 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx> <20061114084519.GL15031@kernel.dk> <45598462.80605@drzeus.cx> <20061114104844.GA15340@flint.arm.linux.org.uk> <4559A99B.6070207@drzeus.cx> <20061114114120.GC22178@kernel.dk> <4559D3F1.1010400@drzeus.cx>
In-Reply-To: <4559D3F1.1010400@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> How about this patch? It is basically the same as the previous, but it
> also sets queuedata to NULL and tests for that. It does not address if
> someone still has dependencies on the queue but hasn't gotten itself a
> reference (as I haven't gotten any word on if that is a problem):

Ok, I've done some more digging through the block layer. A lot of voodoo
in there, but gendisk seems to make sure it has its own reference to the
queue.

As gendisk drops it reference to the queue in del_gendisk(), I have to
assume that is would be invalid for any part of kernel to look at
disk->queue at this point (since it might now have been released).

So I think this patch should cover all bases. It cleanly kills of our
extra thread and also handles any requests that might be left behind.

I hope you can look at this soon as I'm eager to get rid of this oops.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
