Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbTBZU7Y>; Wed, 26 Feb 2003 15:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbTBZU7Y>; Wed, 26 Feb 2003 15:59:24 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:20648 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S268926AbTBZU7W>;
	Wed, 26 Feb 2003 15:59:22 -0500
Message-Id: <200302262107.h1QL7dPr001970@eeyore.valparaiso.cl>
To: jt@hpl.hp.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Invalid compilation without -fno-strict-aliasing 
In-Reply-To: Your message of "Wed, 26 Feb 2003 09:22:15 -0800."
             <20030226172215.GB3731@bougret.hpl.hp.com> 
Date: Wed, 26 Feb 2003 18:07:39 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes <jt@bougret.hpl.hp.com> said:
> On Wed, Feb 26, 2003 at 04:38:10PM +0100, Horst von Brand wrote:
> > Jean Tourrilhes <jt@bougret.hpl.hp.com> said:
> > > 	It looks like a compiler bug to me...
> > > 	Some users have complained that when the following code is
> > > compiled without the -fno-strict-aliasing, the order of the write and
> > > memcpy is inverted (which mean a bogus len is mem-copied into the
> > > stream).
> > > 	Code (from linux/include/net/iw_handler.h) :
> > > --------------------------------------------
> > > static inline char *
> > > iwe_stream_add_event(char *	stream,		/* Stream of events */
> > > 		     char *	ends,		/* End of stream */
> > > 		     struct iw_event *iwe,	/* Payload */
> > > 		     int	event_len)	/* Real size of payload */
> > > {
> > > 	/* Check if it's possible */
> > > 	if((stream + event_len) < ends) {
> > > 		iwe->len = event_len;
> > > 		memcpy(stream, (char *) iwe, event_len);
> > > 		stream += event_len;
> > > 	}
> > > 	return stream;
> > > }
> > > --------------------------------------------
> > > 	IMHO, the compiler should have enough context to know that the
> > > reordering is dangerous. Any suggestion to make this simple code more
> > > bullet proof is welcomed.
> > 
> > The compiler is free to assume char *stream and struct iw_event *iwe point
> > to separate areas of memory, due to strict aliasing.
> 
> 	Which is true and which is not the problem I'm complaining about.

... the compiler thus goes and reorders the frobbing of the variables, as
they are (assumed) separate.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
