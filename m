Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTLCEcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 23:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTLCEcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 23:32:21 -0500
Received: from dhcp024-209-033-037.neo.rr.com ([24.209.33.37]:52099 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264363AbTLCEcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 23:32:20 -0500
Date: Tue, 2 Dec 2003 23:25:12 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: ivan vadovic <pivo@pobox.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isapnp modem in 2.6.0-test9-bk13 not working
Message-ID: <20031202232512.GA14946@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	ivan vadovic <pivo@pobox.sk>, linux-kernel@vger.kernel.org
References: <20031111005856.GB2104@larva.oko> <20031202224337.GA3531@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202224337.GA3531@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 10:43:37PM +0000, Adam Belay wrote:
> On Tue, Nov 11, 2003 at 01:58:58AM +0100, ivan vadovic wrote:
> > I've got an ordinary isapnp modem which provides a serial port unlike
> > winmodems and it just happens to work under 2.4 kernels. When I boot into
> > the 2.6 kernel on the same machine, everything ( sound, ide, md, networking,
> > input devices) seems to work right but the modem. Modprobing 8250_pnp only
> > detects the 2 onboard serial ports. Am I doing anything wrong? What am I
> > supposed to test? Should I provide any more info? Please Cc me as I'm not
> > on the list.
> >
> 
> Could you try this patch.
> 
> --- a/drivers/serial/8250_pnp.c	2003-11-26 20:42:52.000000000 +0000
> +++ b/drivers/serial/8250_pnp.c	2003-12-02 22:41:04.000000000 +0000
> @@ -310,6 +310,8 @@
>  	{	"PNPCXXX",		UNKNOWN_DEV	},
>  	/* More unkown PnP modems */
>  	{	"PNPDXXX",		UNKNOWN_DEV	},
> +	/* check all devices and guess if they are modems */
> +	{	"ANYDEVS",		UNKNOWN_DEV	},
>  	{	"",			0	}
>  };
> 
> Thanks,
> Adam
> 

On second thought this isn't a very good idea because of the way the current
code enables devices on a match.  Instead I'll need the EISA ID for your modem.
You can find it by catting /proc/isapnp in 2.4 or through sysfs in 2.6.

Thanks,
Adam
