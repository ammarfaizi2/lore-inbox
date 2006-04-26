Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWDZXWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWDZXWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWDZXWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:22:12 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:17582 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750726AbWDZXWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:22:12 -0400
Subject: Re: [PATCH] drivers/scsi/sd.c: fix uninitialized variable in
	handling medium errors
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml@rtr.ca, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060426161444.423a8296.akpm@osdl.org>
References: <200604261627.29419.lkml@rtr.ca>
	 <1146092161.12914.3.camel@mulgrave.il.steeleye.com>
	 <20060426161444.423a8296.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 18:22:03 -0500
Message-Id: <1146093723.12914.16.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 16:14 -0700, Andrew Morton wrote:
> It'd be nice to have something simple-and-obvious for the
> simple-and-obvious -stable maintainers.  That's if we think -stable needs
> this fixed.

Well .. the original will do for that.  

> > +				int sector_size_div =
> > +					512 / SCpnt->device->sector_size;
> > +				error_sector /= sector_size_div;
> 
> You sure about this bit?

Yes.  If the <hardware sector size> is < 512 bytes then to convert the
listed error sector to the standard 512 byte sector size block index, we
have to divide (512/<hardware sector size>).

James


