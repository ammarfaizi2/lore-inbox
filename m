Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132546AbRC1XGH>; Wed, 28 Mar 2001 18:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132596AbRC1XF5>; Wed, 28 Mar 2001 18:05:57 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:49938 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S132546AbRC1XFr>;
	Wed, 28 Mar 2001 18:05:47 -0500
To: <linux-kernel@vger.kernel.org>
Cc: Francois Romieu <romieu@cogenit.fr>
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <m3itkuq6xt.fsf@intrepid.pm.waw.pl>
	<20010328182729.A16067@se1.cogenit.fr>
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 29 Mar 2001 01:03:29 +0200
In-Reply-To: Francois Romieu's message of "Wed, 28 Mar 2001 18:27:29 +0200"
Message-ID: <m34rwd8pj2.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@cogenit.fr> writes:

> > +struct hdlc_physical		/* 10 bytes */
> > +{
> > +	unsigned int interface;
> > +	unsigned int clock_rate;
> > +	unsigned short clock_type;
> > +};
> 
> What do you mean with 'interface' ?

That's a physical interface like V.35 or RS232.

> [...]
> > +struct fr_protocol		/* 12 bytes */
> > +{
> > +	unsigned short lmi_type;
> > +	unsigned short t391;
> > +	unsigned short t392;
> > +	unsigned short n391;
> > +	unsigned short n392;
> > +	unsigned short n393;
> > +};
> > +
> > +
> 
> * n200, t200 ?

What's that?

> Do we put the crc type here ?

I don't think so. Frame Relay uses only standard CRC. Correct me if I'm
wrong.

> >  /*
> >   * Interface request structure used for socket
> >   * ioctl's.  All interface ioctl's must have parameter
> > @@ -95,6 +121,9 @@
> >  		char	ifru_slave[IFNAMSIZ];	/* Just fits the size */
> >  		char	ifru_newname[IFNAMSIZ];
> >  		char *	ifru_data;
> > +		struct hdlc_physical hdlc_phy;
> > +		struct hdlc_protocol hdlc_proto;
> > +		struct fr_protocol fr_proto;
> >  	} ifr_ifru;
> >  };
> 
> All the structs or just an union of ?

An (existing) union, of course. That's part of ifmap struct, with
meaning determined by ioctl command code.

> That is: is an SIOCXXX allowed to poke into different structs or not ?

Only one struct at a time :-)

> > --- linux-2.4.orig/include/linux/sockios.h	Sun Nov 12 04:02:40 2000
> > +++ linux-2.4/include/linux/sockios.h	Wed Mar 28 16:35:23 2001
> > @@ -76,6 +76,12 @@
> >  #define SIOCSIFDIVERT	0x8945		/* Set frame diversion options */
> >  
> >  #define SIOCETHTOOL	0x8946		/* Ethtool interface		*/
> > +#define SIOCSHDLC_PHY	0x8947		/* set physical HDLC iface	*/
> > +#define SIOCGHDLC_PHY	0x8948		/* get physical HDLC iface	*/
> 
> What type of operation do you mean by get/set ?

Get/set all device characteristics described by the struct.
For example, get/set interface type, clock type and rate. Or, with
other command(s), get/set Frame-Relay related parameters.

> While we're here, could we agree on the notion of raw hdlc, i.e. :
> - no address, no command. crc present (ARPHRD_RAWHDLC ?);
> - no address, no command, no crc (ARPHRD_PATHOLOGICHDLC ?).

Do we really need another ARPHRD for that?
BTW: What protocol(s) use such CRC-less HDLC?
-- 
Krzysztof Halasa
Network Administrator
