Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132717AbRC2Lno>; Thu, 29 Mar 2001 06:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132712AbRC2Lne>; Thu, 29 Mar 2001 06:43:34 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:2565 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S132719AbRC2LnR>;
	Thu, 29 Mar 2001 06:43:17 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <Pine.LNX.4.30.0103281558140.15795-100000@intra.cyclades.com>
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 29 Mar 2001 13:24:59 +0200
In-Reply-To: Ivan Passos's message of "Wed, 28 Mar 2001 16:24:19 -0500 (EST)"
Message-ID: <m3y9to6cms.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Passos <lists@cyclades.com> writes:

> I guess 'interface' means media type (e.g. V.35, RS-232, X.21, etc.).
> Maybe it would be more intuitive to call it 'media'. What do you think?

Probably.

> Also, for synchronous cards that have built-in DSU/CSU's (such as the
> Cylades-PC300/TE), it's also necessary to configure T1/E1 parameters
> (e.g. line code, frame mode, active channels, etc.). Should we make these
> parameters also available here or keep them in the driver realm?? I think
> we should have them here too, but maybe you see some problem with this
> that I don't.

No problem. That was just an example.

> > +struct hdlc_protocol		/* 4 bytes */
> > +{
> > +	unsigned int proto;
> > +};
> 
> What are the possible protocols to be set here?? I imagine PPP, Cisco
> HDLC, Raw HDLC, Frame Relay, X.25, and ... ?? Is that it??

Exactly.

> > +struct fr_protocol		/* 12 bytes */
> > +{
> > +	unsigned short lmi_type;
> > +	unsigned short t391;
> > +	unsigned short t392;
> > +	unsigned short n391;
> > +	unsigned short n392;
> > +	unsigned short n393;
> > +};
> 
> So we would have hdlc_protocol->proto set to PROTO_FR, and then the
> details about Frame Relay would be set in this separate structure. Is that
> what you have in mind??

Exactly. With defaults filled in by the (some) driver.

> Maybe it's a better idea to have just two ioctl's here (GET and SET), and
> have "subioctl's" inside the structure passed to the HDLC layer (and
> defined by the HDLC layer). This would allow changes in the HDLC layer
> without having to change sockios.h (you'd still have to change HDLC's
> code and definitions, but this would be more self-contained). Again, this
> may be better, or maybe not. What do you think?

I think it would make it more complicated. ioctl namespace is huge enough.
Without changing ifmap struct size (which would require recompilation
of all programs using it - ip, ifconfig etc), the *_protocol/physical
structures can only be 16 bytes long each (8 shorts or 4 ints) - I would
rather not put command code there.

Of course, the structs I outlined are just an example, which need
checking for max and min values and then setting variable length
(int/short/char).
-- 
Krzysztof Halasa
Network Administrator
