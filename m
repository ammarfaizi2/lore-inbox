Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWGFFrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWGFFrt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 01:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWGFFrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 01:47:49 -0400
Received: from lixom.net ([66.141.50.11]:63913 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S932420AbWGFFrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 01:47:48 -0400
Date: Thu, 6 Jul 2006 00:46:39 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Xserve G5 thermal control fixes
Message-ID: <20060706054639.GE5290@pb15.lixom.net>
References: <1152162394.24632.58.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152162394.24632.58.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 03:06:34PM +1000, Benjamin Herrenschmidt wrote:
> The thermal control for the Xserve G5s had a few issues. For one, the
> way to program the RPM fans speeds into the FCU is different between it
> and the desktop models, which I didn't figure out until recently, and it
> was missing a control loop for the slots fan, running it too fast. Both
> of those problems were causing the machine to be much more noisy than
> necessary. This patch also changes the fixed value of the slots fan for
> desktop G5s to 40% instead of 50%. It seems to still have a pretty good
> airflow that way and is much less noisy.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Index: linux-irq-work/drivers/macintosh/therm_pm72.c
> ===================================================================
> --- linux-irq-work.orig/drivers/macintosh/therm_pm72.c	2006-07-05 14:46:11.000000000 +1000
> +++ linux-irq-work/drivers/macintosh/therm_pm72.c	2006-07-06 14:42:31.000000000 +1000
> @@ -95,6 +95,14 @@
>   *	- Use min/max macros here or there
>   *	- Latest darwin updated U3H min fan speed to 20% PWM
>   *
> + *  July. 06, 2006 : 1.3
> + *	- Fix setting of RPM fans on Xserve G5 (they were going too fast)
> + *      - Add missing slots fan control loop for Xserve G5
> + *	- Lower fixed slots fan speed from 50% to 40% on desktop G5s. We
> + *        still can't properly implement the control loop for these, so let's
> + *        reduce the noise a little bit, it appears that 40% still gives us
> + *        a pretty good air flow
> + *

Doesn't it make more sense to keep this in the GIT log instead of in
the file? (I seem to remember Freescale getting similar comments on some
posted code just a few days ago :-)

Keeping version numbers for in-tree-only drivers isn't all that useful
either.


-Olof
