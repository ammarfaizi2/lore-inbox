Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318272AbSHEAFD>; Sun, 4 Aug 2002 20:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318287AbSHEAFD>; Sun, 4 Aug 2002 20:05:03 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:56231 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318272AbSHEAFC>;
	Sun, 4 Aug 2002 20:05:02 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15693.49493.300424.746502@argo.ozlabs.ibm.com>
Date: Mon, 5 Aug 2002 10:05:41 +1000 (EST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4.19 warnings cleanup
In-Reply-To: <1028470583.14196.29.camel@irongate.swansea.linux.org.uk>
References: <m3znw3k8qq.fsf@defiant.pm.waw.pl>
	<1028470583.14196.29.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> > --- linux/drivers/net/ppp_generic.c.orig	Sat Aug  3 17:13:58 2002
> > +++ linux/drivers/net/ppp_generic.c	Sat Aug  3 19:11:54 2002
> > @@ -378,7 +378,7 @@
> >  {
> >  	struct ppp_file *pf = file->private_data;
> >  	DECLARE_WAITQUEUE(wait, current);
> > -	ssize_t ret;
> > +	ssize_t ret = 0; /* suppress compiler warning */
> >  	struct sk_buff *skb = 0;
> >  
> >  	if (pf == 0)
> 
> 
> Please don't do this. I'm regularly having to fix drivers where people
> hid bugs this way rather than working out if it was a real problem. If
> it is genuinely a compiler corner case then let the gcc folks know and
> comment it but leave the warning.

The code is in ppp_read actually OK; if you trace through the logic
you can prove that ret is never actually used without being set first.

Paul.
