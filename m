Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbUL3Jy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUL3Jy5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUL3Jy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:54:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23558 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261601AbUL3Jyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 04:54:52 -0500
Date: Thu, 30 Dec 2004 09:54:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC block removable flag
Message-ID: <20041230095448.A9500@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <41D3646F.5050408@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41D3646F.5050408@drzeus.cx>; from drzeus-list@drzeus.cx on Thu, Dec 30, 2004 at 03:14:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 03:14:07AM +0100, Pierre Ossman wrote:
> A MMC card is a highly removable device. This patch makes the block 
> layer part of the MMC layer set the removable flag.

I have this patch also floating around, but I've decided it isn't needed.
I believe this flag is to indicate that we have removable media for a
block device rather than to indicate that the block device can be removed.

However, when we insert and remove a MMC card, we create and destroy the
block device itself.  Therefore, as far as the block layer is concerned,
the device itself is being inserted and removed, so telling the block
layer that the media is removable is just silly - you can't separate the
flash media from the on-board MMC controller.

(Note: any block device can be removed - you just rmmod the module
supplying the block device driver, but this doesn't mean we mark all
block devices with GENHD_FL_REMOVABLE.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
