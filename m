Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267819AbUHZXlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267819AbUHZXlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269663AbUHZXjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:39:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:22214 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269671AbUHZXgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:36:08 -0400
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, sensors@Stimpy.netroedge.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040826112343.M51031@linux-fr.org>
References: <10934733881970@kroah.com> <1093485846.3054.65.camel@gaston>
	 <20040826041019.GA8445@kroah.com>  <20040826112343.M51031@linux-fr.org>
Content-Type: text/plain
Message-Id: <1093563199.2170.168.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 09:33:20 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 22:26, Jean Delvare wrote:

> The i2c-keywest driver doesn't define any class for any of its I2C busses. All
> hardware monitoring chips [1] do check the class, so they wont possibly probe
> any chip on the i2c-keywest busses. It happens that on the iBook2, the second
> I2C bus hosts an Analog Devices ADM1030 monitoring chip, for which a driver
> has been developped recently. Without adding the correct class bit
> (I2C_CLASS_HWMON) to the second bus of i2c-keywest, iBook2 users can't get the
> adm1031 driver to handle their ADM1030 chip.

That bus also contains other stuffs, I'd prefer the in-kernel specific
driver for this model to be used rather than some generic stuff.

> One iBook2 user came to me, wondering why he couldn't get the adm1031 driver
> to work, and we noticed the problem. I had him test a patch and it worked. I
> then sent the patch to Greg, who in turn sent it to Linus, and here we are.
> 
> Benjamin, you seem to guard the i2c-keywest driver very closely. Is there
> anything special about this driver? My patch was rather simple and
> non-intrusive, and probably not worth reverting within the hour. Much ado
> about nothing, if you want my opinion, with all due respect.

It was wrong to check on the bus number like that. i2c-keywest is used
on a variety of models to driver totally different i2c busses, and at
this point, we can't arbitrarily say "bus 1 is HW monitoring". It
totally depends on the machine model. Besides, I don't like generic
drivers playing with those thermal control stuffs, I prefer drivers that
have been tuned for those specific machine models.

> Could you please explain why my patch doesn't make sense? Similar changes were
> made to several i2c bus drivers already [2] [3], and it never caused any problem.

As I wrote earlier. Just testing the bus number and arbitrarily deciding
bus 1 is HWMON makes no sense.

> At any rate, I may redirect i2c-keywest users to you from now on, if you
> prefer to handle it yourself.
> 
> Thanks.
> 
> [1] Except lm85, but this should be fixed.
> [2] http://marc.theaimsgroup.com/?l=bk-commits-head&m=107943782219511&w=2
> [3] http://marc.theaimsgroup.com/?l=bk-commits-head&m=107943868728036&w=2
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

