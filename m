Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbTLCStl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 13:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbTLCStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 13:49:40 -0500
Received: from gw-oko.i4u.sk ([212.89.237.40]:10256 "EHLO 212.89.237.40")
	by vger.kernel.org with ESMTP id S265118AbTLCStN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 13:49:13 -0500
Date: Wed, 3 Dec 2003 19:49:08 +0100
From: ivan <pivo@pobox.sk>
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isapnp modem in 2.6.0-test9-bk13 not working
Message-ID: <20031203184908.GE2218@larva.oko>
References: <20031111005856.GB2104@larva.oko> <20031202224337.GA3531@neo.rr.com> <20031202232512.GA14946@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20031202232512.GA14946@neo.rr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 11:25:12PM +0000, Adam Belay wrote:
> Date: Tue, 2 Dec 2003 23:25:12 +0000
> From: Adam Belay <ambx1@neo.rr.com>
> To: ivan vadovic <pivo@pobox.sk>
> Subject: Re: isapnp modem in 2.6.0-test9-bk13 not working
> 
> On Tue, Dec 02, 2003 at 10:43:37PM +0000, Adam Belay wrote:
> > On Tue, Nov 11, 2003 at 01:58:58AM +0100, ivan vadovic wrote:
> > > I've got an ordinary isapnp modem which provides a serial port unlike
> > > winmodems and it just happens to work under 2.4 kernels. When I boot into
> > > the 2.6 kernel on the same machine, everything ( sound, ide, md, networking,
> > > input devices) seems to work right but the modem. Modprobing 8250_pnp only
> > > detects the 2 onboard serial ports. Am I doing anything wrong? What am I
> > > supposed to test? Should I provide any more info? Please Cc me as I'm not
> > > on the list.
> > >
> > 
> > Could you try this patch.
> > 
> > --- a/drivers/serial/8250_pnp.c	2003-11-26 20:42:52.000000000 +0000
> > +++ b/drivers/serial/8250_pnp.c	2003-12-02 22:41:04.000000000 +0000
> > @@ -310,6 +310,8 @@
> >  	{	"PNPCXXX",		UNKNOWN_DEV	},
> >  	/* More unkown PnP modems */
> >  	{	"PNPDXXX",		UNKNOWN_DEV	},
> > +	/* check all devices and guess if they are modems */
> > +	{	"ANYDEVS",		UNKNOWN_DEV	},
> >  	{	"",			0	}
> >  };
> > 
> > Thanks,
> > Adam
> > 
> 
> On second thought this isn't a very good idea because of the way the current
> code enables devices on a match.  Instead I'll need the EISA ID for your modem.
> You can find it by catting /proc/isapnp in 2.4 or through sysfs in 2.6.

Could it be something like RSS0250 ?
I made it work with isapnptools btw. Under 2.4 I didn't need isapnptools so
there's a bug somewhere. I'll try the patch a little bit later.

This is what isapnptools says:
Board 1 has Identity 52 00 00 08 98 50 02 73 4a:  RSS0250 Serial No 2200

Thanks for help.
Ivan
