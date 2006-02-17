Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWBQNEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWBQNEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWBQNEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:04:25 -0500
Received: from mail-a02.ithnet.com ([217.64.83.97]:52131 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S932255AbWBQNEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:04:24 -0500
X-Sender-Authentication: net64
Date: Fri, 17 Feb 2006 14:04:21 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Severe problem with e1000 driver in 2.4.31/32 (at least)
Message-Id: <20060217140421.3f049719.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.64.0602161344240.5564@lindenhurst-2.jf.intel.com>
References: <20060216203948.5953a1e9.skraw@ithnet.com>
	<4807377b0602161342l4b46fa3cu26a007789ba08443@mail.gmail.com>
	<Pine.LNX.4.64.0602161344240.5564@lindenhurst-2.jf.intel.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2006 13:49:12 -0800 (PST)
Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:


> > The box runs into a BUG in e1000_hw.c line 5052. The BUG shows up because
> > the code is obviously executed inside an interrupt, which seems not
> > intended. As this BUG is always reproducable and pretty annoying we made
> > this pretty bad workaround:
> 
> Please try this patch, compile tested.  It matches up this particular code 
> to what is currently in 2.6.16-rc
> 
> e1000: fix BUG reported due to calling msec_delay in irq context
> 
> There are some functions that are called in irq context that need to use
> msec_delay_irq instead to avoid a BUG.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Hello Jesse,

I can confirm the patch eliminates the problem here. I first thought about
doing it the same way but was unsure whether the function itself should execute
in interrupt at all.
Thank you for your immediate answer, please make sure to include the patch as
is in 2.4.

Stephan



> 
> ---
> 
>   drivers/net/e1000/e1000_hw.c |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/e1000/e1000_hw.c b/drivers/net/e1000/e1000_hw.c
> --- a/drivers/net/e1000/e1000_hw.c
> +++ b/drivers/net/e1000/e1000_hw.c
> @@ -5049,7 +5049,7 @@ e1000_config_dsp_after_link_change(struc
>               if(ret_val)
>                   return ret_val;
> 
> -            msec_delay(20);
> +            msec_delay_irq(20);
> 
>               ret_val = e1000_write_phy_reg(hw, 0x0000,
>                                             IGP01E1000_IEEE_FORCE_GIGA);
> @@ -5073,7 +5073,7 @@ e1000_config_dsp_after_link_change(struc
>               if(ret_val)
>                   return ret_val;
> 
> -            msec_delay(20);
> +            msec_delay_irq(20);
> 
>               /* Now enable the transmitter */
>               ret_val = e1000_write_phy_reg(hw, 0x2F5B, phy_saved_data);
> @@ -5098,7 +5098,7 @@ e1000_config_dsp_after_link_change(struc
>               if(ret_val)
>                   return ret_val;
> 
> -            msec_delay(20);
> +            msec_delay_irq(20);
> 
>               ret_val = e1000_write_phy_reg(hw, 0x0000,
>                                             IGP01E1000_IEEE_FORCE_GIGA);
> @@ -5114,7 +5114,7 @@ e1000_config_dsp_after_link_change(struc
>               if(ret_val)
>                   return ret_val;
> 
> -            msec_delay(20);
> +            msec_delay_irq(20);
> 
>               /* Now enable the transmitter */
>               ret_val = e1000_write_phy_reg(hw, 0x2F5B, phy_saved_data);
> 


