Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVA0AnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVA0AnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVA0AUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:20:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:49826 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262485AbVAZWtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 17:49:25 -0500
Date: Wed, 26 Jan 2005 14:42:31 -0800
From: Greg KH <greg@kroah.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-ID: <20050126224231.GA4874@kroah.com>
References: <41F6F1D5.90601@mvista.com> <20050126205619.4c0b41fa.khali@linux-fr.org> <41F81227.6070101@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F81227.6070101@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 02:56:55PM -0700, Mark A. Greer wrote:
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <linux/wait.h>
> +#include <linux/spinlock.h>
> +#include <asm/io.h>
> +#include <asm/ocp.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/mv643xx.h>
> +#include "i2c-mv64xxx.h"

Please put <asm/ after <linux/

> +static inline void
> +mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
> +{
> +	pr_debug("mv64xxx_i2c_fsm: ENTER--state: %d, status: 0x%x\n",
> +		drv_data->state, status);

You have a lot of pr_debug and other printk() for stuff in this driver.
Please use dev_dbg(), dev_err() and friends instead.  That way you get a
consistant message, that points to the exact device that is causing the
message.

> +static inline void
> +mv64xxx_i2c_prepare_for_io(struct mv64xxx_i2c_data *drv_data,
> +	struct i2c_msg *msg)

You have some big inline functions here.  Should they really be inline?
We aren't really worried about speed here, right?  Size is probably a
bigger issue.

> diff -Nru a/drivers/i2c/busses/i2c-mv64xxx.h b/drivers/i2c/busses/i2c-mv64xxx.h
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/drivers/i2c/busses/i2c-mv64xxx.h	2005-01-26 14:49:22 -07:00

Is this header file really needed?  Does any other file other than this
single driver ever include it?  If not, please just put it into the
driver itself.

thanks,

greg k-h
