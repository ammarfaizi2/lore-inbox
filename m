Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264344AbTCXSrE>; Mon, 24 Mar 2003 13:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbTCXSrE>; Mon, 24 Mar 2003 13:47:04 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:60677 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264344AbTCXSrD>; Mon, 24 Mar 2003 13:47:03 -0500
Date: Mon, 24 Mar 2003 18:57:48 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Kronos <kronos@kronoz.cjb.net>
cc: linux-fbdev-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>,
       <ajoshi@unixbox.com>
Subject: Re: [PATCH] Make radeonfb work with R300
In-Reply-To: <20030323171156.GA505@dreamland.darkstar.lan>
Message-ID: <Pine.LNX.4.44.0303241857390.22808-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied.

> 
> Hi,
> radeonfb is  unable to  acquire the  pll clock values  from the  BIOS on
> newer radeon cards and uses default values which don't work.
> 
> Using ATI binary driver for X I founded this in the log:
> 
> (II) fglrx(0): PLL parameters: rf=2700 rd=12 min=20000 max=40000; xclk=27000
> 
> This patch (against 2.5.65) sets pll values according to X:
> 
> --- drivers/video/radeonfb.orig.c	Sun Mar 23 16:15:04 2003
> +++ drivers/video/radeonfb.c	Sun Mar 23 18:01:48 2003
> @@ -881,6 +881,16 @@
>  				rinfo->pll.ref_div = 12;
>  				rinfo->pll.ref_clk = 2700;
>  				break;
> +			case PCI_DEVICE_ID_ATI_RADEON_ND:
> +			case PCI_DEVICE_ID_ATI_RADEON_NE:
> +			case PCI_DEVICE_ID_ATI_RADEON_NF:
> +			case PCI_DEVICE_ID_ATI_RADEON_NG:
> +				rinfo->pll.ppll_max = 40000;
> +				rinfo->pll.ppll_min = 20000;
> +				rinfo->pll.xclk = 27000;
> +				rinfo->pll.ref_div = 12;
> +				rinfo->pll.ref_clk = 2700;
> +				break;
>  			case PCI_DEVICE_ID_ATI_RADEON_QD:
>  			case PCI_DEVICE_ID_ATI_RADEON_QE:
>  			case PCI_DEVICE_ID_ATI_RADEON_QF:
> 
> 
> It works on  a R300 NE (9500 Pro),  but should be ok also  for the other
> R300 chips (don't have the hw to make a test though).
> 
> In X log there is also this line:
> 
> (II) fglrx(0): Primary V_BIOS segment is: 0xc000
> 
> I've no idea of what V_BIOS is (Video BIOS?), but it may be useful ;)
> 
> 
> HTH,
> Luca
> 

