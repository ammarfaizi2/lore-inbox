Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268821AbTBZRN5>; Wed, 26 Feb 2003 12:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268829AbTBZRN4>; Wed, 26 Feb 2003 12:13:56 -0500
Received: from palrel12.hp.com ([156.153.255.237]:63401 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S268821AbTBZRNy>;
	Wed, 26 Feb 2003 12:13:54 -0500
Date: Wed, 26 Feb 2003 09:22:15 -0800
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Invalid compilation without -fno-strict-aliasing
Message-ID: <20030226172215.GB3731@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030225234646.GB30611@bougret.hpl.hp.com> <200302261538.h1QFcAiF004085@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302261538.h1QFcAiF004085@eeyore.valparaiso.cl>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 04:38:10PM +0100, Horst von Brand wrote:
> Jean Tourrilhes <jt@bougret.hpl.hp.com> said:
> > 	It looks like a compiler bug to me...
> > 	Some users have complained that when the following code is
> > compiled without the -fno-strict-aliasing, the order of the write and
> > memcpy is inverted (which mean a bogus len is mem-copied into the
> > stream).
> > 	Code (from linux/include/net/iw_handler.h) :
> > --------------------------------------------
> > static inline char *
> > iwe_stream_add_event(char *	stream,		/* Stream of events */
> > 		     char *	ends,		/* End of stream */
> > 		     struct iw_event *iwe,	/* Payload */
> > 		     int	event_len)	/* Real size of payload */
> > {
> > 	/* Check if it's possible */
> > 	if((stream + event_len) < ends) {
> > 		iwe->len = event_len;
> > 		memcpy(stream, (char *) iwe, event_len);
> > 		stream += event_len;
> > 	}
> > 	return stream;
> > }
> > --------------------------------------------
> > 	IMHO, the compiler should have enough context to know that the
> > reordering is dangerous. Any suggestion to make this simple code more
> > bullet proof is welcomed.
> 
> The compiler is free to assume char *stream and struct iw_event *iwe point
> to separate areas of memory, due to strict aliasing.

	Which is true and which is not the problem I'm complaining about.
	Have fun...

	Jean
