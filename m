Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWAXQkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWAXQkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 11:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWAXQkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 11:40:32 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:52408 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030412AbWAXQkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 11:40:31 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] USB: Fix masking bug initialization of Freescale EHCI controller
Date: Tue, 24 Jan 2006 08:11:27 -0800
User-Agent: KMail/1.7.1
Cc: Kumar Gala <galak@gate.crashing.org>, dbrownell@users.sourceforge.net,
       Randy Vinson <rvinson@mvista.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0601231346470.16800-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0601231346470.16800-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601240811.27539.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 11:48 am, Kumar Gala wrote:
> In setting up the of PHY we masked off too many bits, instead just
> initialize PORTSC for the type of PHY we are using.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

> ---
> commit 2497a5e4242d500178d6d0f0ce4ee9249a38f5dc
> tree 71f036ecd23dffb224963b4aabe4f857ba99845b
> parent fe49a3f53c2572bf26a9dfd77e54fda1aa853887
> author Kumar Gala <galak@kernel.crashing.org> Mon, 23 Jan 2006 13:53:09 -0600
> committer Kumar Gala <galak@kernel.crashing.org> Mon, 23 Jan 2006 13:53:09 -0600
> 
>  drivers/usb/host/ehci-fsl.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> index 6d82054..f40ee41 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -160,8 +160,7 @@ static void mpc83xx_setup_phy(struct ehc
>  			      enum fsl_usb2_phy_modes phy_mode,
>  			      unsigned int port_offset)
>  {
> -	u32 portsc = readl(&ehci->regs->port_status[port_offset]);
> -	portsc &= ~PORT_PTS_MSK;
> +	u32 portsc = 0;
>  	switch (phy_mode) {
>  	case FSL_USB2_PHY_ULPI:
>  		portsc |= PORT_PTS_ULPI;
> 
> 
> 

