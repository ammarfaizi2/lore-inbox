Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933138AbWKNIyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933138AbWKNIyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 03:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933244AbWKNIyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 03:54:49 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:63637 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S933138AbWKNIys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 03:54:48 -0500
Message-ID: <45598462.80605@drzeus.cx>
Date: Tue, 14 Nov 2006 09:54:58 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx> <20061114084519.GL15031@kernel.dk>
In-Reply-To: <20061114084519.GL15031@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> SCSI just sets ->queuedata to NULL, if you store your device there you
> may do just that. Or just mark your device structure appropriately,
> there are no special places in the queue for that.
>
>   

I've had another look at it, and I believe I have a solution. There is
one assumption I need to verify though.

After del_gendisk() and after I've flushed out any remaining requests,
is it ok to kill off the queue? Someone might still have the disk open,
so that would mean the queue is gone by the time gendisk's release
function is called.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

