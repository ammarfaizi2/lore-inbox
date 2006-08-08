Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWHHNJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWHHNJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWHHNJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:09:29 -0400
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:10512 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S964795AbWHHNJ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:09:28 -0400
Date: Tue, 8 Aug 2006 15:09:28 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>,
       r-woodruff2@ti.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       i2c@lm-sensors.org
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #3
Message-Id: <20060808150928.99f97837.khali@linux-fr.org>
In-Reply-To: <20060808125730.51136.qmail@web37915.mail.mud.yahoo.com>
References: <20060807145832.GF10387@atomide.com>
	<20060808125730.51136.qmail@web37915.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Komal,

> > Hmmm, this sounds like a bug somewhere. TRM for 5912 says the I2C
> > clock must be prescaled to be between 7 - 12 MHz [1]. The XOR input
> > clock is typically 12, 13 or 19.2 MHz. So we should have code that
> > produces:
> > 
> > XOR Mhz	Divider	Prescaler
> > 12		1	0
> > 13		2	1
> > 19.2	2	1
> > 
> > Then again the original old code produces something different too
> > [2]...
> > 
> > I suspect the original code had some hw workarounds and and later
> > code
> > may have a conversion bug somewhere :)
> > 
> > I suggest we keep the code as is for now since it's known to work on
> > all omaps, and then submit a follow-up patch later once we have
> > verified that that code based on the TRM works on all omaps.
> 
> I have updated the driver with all other review comments except comment
> on formula above by Jean. I can some part of description from Tony's
> explanation along with removing the following code line
> 
> /* Set Own Address */
> omap_i2c_write_reg(dev, OMAP_I2C_OA_REG, dev->own_address);
>  
> As it is not needed. Please confirm so that I can send the revised
> patch  soon.

Fine with me. If you remove that line, there are a few others you
should be able to remove as well (declaration of slave_add module
parameter, definition of DEFAULT_OWN, etc.)

Waiting for your updated patch :) Thanks for all the changes you
accepted to make, BTW. I believe the driver is in a better shape now.

-- 
Jean Delvare
