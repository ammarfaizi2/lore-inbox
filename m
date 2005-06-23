Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVFWVRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVFWVRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVFWVN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:13:29 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:42508 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262692AbVFWVMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:12:51 -0400
Date: Thu, 23 Jun 2005 23:12:42 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH] I2C: add i2c driver for TPS6501x
Message-Id: <20050623231242.0be0c244.khali@linux-fr.org>
In-Reply-To: <11194174663452@kroah.com>
References: <1119417466126@kroah.com>
	<11194174663452@kroah.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, David,

> [PATCH] I2C: add i2c driver for TPS6501x
> 
> This adds an I2C driver for the TPS6501x series of power management
> chips. It's used on many OMAP based boards, and this driver has been
> widely used in the Linux-OMAP trees over the last year or so.

There is a pending cleanup patch for this driver. It was posted by David
on the lm-sensors mailing list on May 27th:
  http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012409.html
Greg, Can you please add this patch to your i2c tree?

Note that I am not entierly happy with this driver even after the patch
is applied. It tries to load several times when the initial attempt
fails. That's ugly and inefficient. The retries should be done on failed
bus reads, rather than reloading the driver entirely on each error, so
that as few actions as possible are retried. Or the bus driver could be
improved to deal with errors at a lower level.

David, could you please work on a patch implementing either solution?

Thanks,
-- 
Jean Delvare
