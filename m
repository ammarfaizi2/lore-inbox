Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbSJOU04>; Tue, 15 Oct 2002 16:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264703AbSJOU04>; Tue, 15 Oct 2002 16:26:56 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:16137 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264653AbSJOU0w>;
	Tue, 15 Oct 2002 16:26:52 -0400
Date: Tue, 15 Oct 2002 13:32:50 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>, torvalds@transmeta.com,
       alan@lxorguk.ukuu.org.uk, jdthood@yahoo.co.uk, boissiere@nl.linux.org,
       perex@perex.cz, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Layer Rewrite V0.7 - 2.4.42
Message-ID: <20021015203250.GH15864@kroah.com>
References: <20021014135452.GB444@neo.rr.com> <20021014181028.GE7462@kroah.com> <20021015160946.GD315@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015160946.GD315@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 04:09:46PM +0000, Adam Belay wrote:
> > > +static const struct pnp_id pnp_dev_table[] = {
> > > +	/* Standard LPT Printer Port */
> > > +	{	"PNP0400",		0	},
> >
> > Using named initializers are preferred.
> 
> I'm not quite sure what you mean here.

Something like:
	static const struct pnp_id pnp_dev_table[] = {
	/* standard printer port */
	{ .name = "PNP0400", .data = 0},

or whatever those fields are called.

> > pnp_register_driver() should be implemented so that you don't need a
> > #ifdef around it to call it.  Put the #ifdef in the header file.
> 
> Actually pnp_register_driver is implemented in this way.  The reason it
> has #ifdef around it is becuase of the previous #ifdef statement
> (where parport_pc_pnp_driver is defined).

Removing #ifdefs is also nice :)

> Also I had a hotplug related question?  Is it possible for pnp drivers
> to use this and if so what do I need to do?
> 
> MODULE_DEVICE_TABLE(pnp, pnp_dev_table);

To fully support this, you need to modify modutils to generate the
proper modules.pnpmap file from the .o files.  Take a look at the source
for it for how to do this.

Also, some kind of /sbin/hotplug notification when a pnp device is found
is a good idea.  Hm, looks like you already get that for free right now
with the existing driver code, nevermind :)

thanks,

greg k-h
