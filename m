Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268761AbTBZVjg>; Wed, 26 Feb 2003 16:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268774AbTBZVjg>; Wed, 26 Feb 2003 16:39:36 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:36017 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S268761AbTBZVje>; Wed, 26 Feb 2003 16:39:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>, jt@hpl.hp.com
Subject: Re: Invalid compilation without -fno-strict-aliasing
Date: Thu, 27 Feb 2003 05:41:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200302262107.h1QL7dPr001970@eeyore.valparaiso.cl>
In-Reply-To: <200302262107.h1QL7dPr001970@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030226214951.B47F2EBEAB@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 February 2003 22:07, Horst von Brand wrote:
> Jean Tourrilhes <jt@bougret.hpl.hp.com> said:
> > On Wed, Feb 26, 2003 at 04:38:10PM +0100, Horst von Brand wrote:
> > > Jean Tourrilhes <jt@bougret.hpl.hp.com> said:
> > > > 	It looks like a compiler bug to me...
> > > > 	Some users have complained that when the following code is
> > > > compiled without the -fno-strict-aliasing, the order of the write and
> > > > memcpy is inverted (which mean a bogus len is mem-copied into the
> > > > stream).
> > > > 	Code (from linux/include/net/iw_handler.h) :
> > > > --------------------------------------------
> > > > static inline char *
> > > > iwe_stream_add_event(char *	stream,		/* Stream of events */
> > > > 		     char *	ends,		/* End of stream */
> > > > 		     struct iw_event *iwe,	/* Payload */
> > > > 		     int	event_len)	/* Real size of payload */
> > > > {
> > > > 	/* Check if it's possible */
> > > > 	if((stream + event_len) < ends) {
> > > > 		iwe->len = event_len;
> > > > 		memcpy(stream, (char *) iwe, event_len);
> > > > 		stream += event_len;
> > > > 	}
> > > > 	return stream;
> > > > }
> > > > --------------------------------------------
> > > > 	IMHO, the compiler should have enough context to know that the
> > > > reordering is dangerous. Any suggestion to make this simple code more
> > > > bullet proof is welcomed.
> > >
> > > The compiler is free to assume char *stream and struct iw_event *iwe
> > > point to separate areas of memory, due to strict aliasing.
> >
> > 	Which is true and which is not the problem I'm complaining about.
>
> ... the compiler thus goes and reorders the frobbing of the variables, as
> they are (assumed) separate.

Actually, the compiler appears to view &iwe->len and (char *) iwe as 
separate, which I find surprising.

Regards,

Daniel
