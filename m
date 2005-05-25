Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbVEYRwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbVEYRwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVEYRwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:52:55 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:35820 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261517AbVEYRvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:51:41 -0400
Subject: Re: [PATCH] Fix reference counting for failed SCSI devices
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Hannes Reinecke <hare@suse.de>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <429496C2.3020706@suse.de>
References: <4292F631.9090300@suse.de> <1116975478.7710.28.camel@mulgrave>
	 <4294201D.4070304@suse.de> <1117024043.5071.6.camel@mulgrave>
	 <429473A1.6010402@suse.de> <1117033088.4956.5.camel@mulgrave>
	 <429496C2.3020706@suse.de>
Content-Type: text/plain
Date: Wed, 25 May 2005 13:51:29 -0400
Message-Id: <1117043489.5210.4.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-25 at 17:16 +0200, Hannes Reinecke wrote:
> I guess it's time to convert aic79xx to the spi_transport class.
> Unfortunately my attempt segfaults when removing a device in
> attribute_container_device_trigger(); someone is overwriting the ->match
> function. Oh well, further debugging needed.

Well ... best of luck.  Given the problems incurred doing this for
aic7xxx (mainly in initial inquiry and domain validation, one of which
is outstanding still) it's not going to be easy.

Large segments of the aic79xx driver are identical to the aic7xxx driver
except that all the functions being ahd_ instead of ahc_, so you should
just be able to mirror quite a lot of the aic7xxx updates.  However, you
need to include a large number of rather nasty u320 parameters in the
SPI transport Class (and make sure they're coupled correctly) to get
domain validation to work ... the transport class has also only been
tested on speeds up to u160, so going to u320 will be a first for it
too...

James


