Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270572AbTGNNAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270622AbTGNNAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:00:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18192 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270572AbTGNM7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:59:45 -0400
Date: Mon, 14 Jul 2003 14:14:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: Re: PATCH: make pcmcica devices report pcmcia bus info in gdrvinfo
Message-ID: <20030714141425.C18177@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, marcelo@conectiva.com
References: <200307141221.h6ECLLDM030866@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307141221.h6ECLLDM030866@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Jul 14, 2003 at 01:21:21PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 01:21:21PM +0100, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/net/pcmcia/3c574_cs.c linux.22-pre5-ac1/drivers/net/pcmcia/3c574_cs.c
> --- linux.22-pre5/drivers/net/pcmcia/3c574_cs.c	2003-07-14 12:26:42.000000000 +0100
> +++ linux.22-pre5-ac1/drivers/net/pcmcia/3c574_cs.c	2003-06-29 16:09:55.000000000 +0100
> @@ -1202,6 +1202,7 @@
>  	case ETHTOOL_GDRVINFO: {
>  		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
>  		strncpy(info.driver, "3c574_cs", sizeof(info.driver)-1);
> +		sprintf(info.bus_info, "PCMCIA 0x%lx", dev->base_addr);
>  		if (copy_to_user(useraddr, &info, sizeof(info)))
>  			return -EFAULT;
>  		return 0;

We should probably ensure that the bus info is compatible with the bus
info which Dominik's going to be using in 2.6.x

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
