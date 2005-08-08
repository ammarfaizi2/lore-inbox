Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVHHRhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVHHRhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVHHRhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:37:55 -0400
Received: from havoc.gtf.org ([69.61.125.42]:5018 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932139AbVHHRhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:37:53 -0400
Date: Mon, 8 Aug 2005 13:37:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Carlos Pardo <Carlos.Pardo@siliconimage.com>
Cc: Tejun Heo <htejun@gmail.com>, Edward Falk <efalk@google.com>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Raymond Liu <Raymond.Liu@siliconimage.com>
Subject: Re: [PATCH linux-2.6.13-rc3] SATA: rewritten sil24 driver
Message-ID: <20050808173748.GA22580@havoc.gtf.org>
References: <2E9B8131C44AF746B1E06BF9B15A434B045D7F93@zima.siliconimage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E9B8131C44AF746B1E06BF9B15A434B045D7F93@zima.siliconimage.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 10:31:45AM -0700, Carlos Pardo wrote:
> One question. Do the open source driver support pass-through commands ? if so, how ? If you do not support it, are you planning to implement pass-through commands sometime in the future ?

I don't know about sata_sil24 in particular.  In general, there is a
patch in the "libata-dev.git" repository that supports ATA passthru, and
this is scheduled to be merged into the main 2.6.x kernel as soon as
some bugs are fixed.

sata_sil24 definitely needs to support this ATA passthru feature.

As implemented, each SATA driver is simply a generic ATA command engine,
for any command.  struct ata_taskfile (linux/ata.h) has a field that
indicates the command protocol used for command delivery (pio, dma,
no-data, etc.).  Each driver should execute ATA commands based on the
specified ATA protocol.

	Jeff



