Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030547AbVIPDI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547AbVIPDI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 23:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030577AbVIPDI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 23:08:29 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35291 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030547AbVIPDI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 23:08:28 -0400
Message-ID: <432A3728.6040501@pobox.com>
Date: Thu, 15 Sep 2005 23:08:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkosewsk@gmail.com
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc1 1/3] Add disk hotswap support to libata RESEND
 #3
References: <355e5e5e05091422061a3a9f28@mail.gmail.com>
In-Reply-To: <355e5e5e05091422061a3a9f28@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> Patch 1/3 for libata hotswapping.  Properly masks out interrupts for
> Promise SATAII150 Tx2Plus/Tx4 controllers.  More comments in patch
> header.
> 
> Luke Kosewski
> 
> 
> ------------------------------------------------------------------------
> 
> 15.09.05    Luke Kosewski   <lkosewsk@nit.ca>
> 
> 	* A patch to the sata_promise driver in libata for it to correctly mask
> 	  out hotplug interrupts on SATAII150 Tx4/Tx2 Plus controllers.
> 	* This is resend #3.  It no longer applies to a -mm tree, but to
> 	  2.6.14-rc1.  Therefore, the entry for board_2057x no longer has
> 	  ATA_FLAG_SATA commented out.

You need to add a ->host_stop() hook that frees pdc_host_priv, otherwise 
you have a memory leak on module remove/controller unplug.

Once fixed, this patch could go in immediately, it looks like.

	Jeff



