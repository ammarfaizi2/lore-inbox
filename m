Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318876AbSHEUdH>; Mon, 5 Aug 2002 16:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318878AbSHEUdH>; Mon, 5 Aug 2002 16:33:07 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:30092 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S318876AbSHEUdG>;
	Mon, 5 Aug 2002 16:33:06 -0400
To: Paul Mackerras <paulus@au1.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4.19 warnings cleanup
References: <m3znw3k8qq.fsf@defiant.pm.waw.pl>
	<1028470583.14196.29.camel@irongate.swansea.linux.org.uk>
	<15693.49493.300424.746502@argo.ozlabs.ibm.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 05 Aug 2002 11:41:04 +0200
In-Reply-To: <15693.49493.300424.746502@argo.ozlabs.ibm.com>
Message-ID: <m3k7n51w3z.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@au1.ibm.com> writes:

> > > --- linux/drivers/net/ppp_generic.c.orig	Sat Aug  3 17:13:58 2002
> > > +++ linux/drivers/net/ppp_generic.c	Sat Aug  3 19:11:54 2002
> > > @@ -378,7 +378,7 @@
> > >  {
> > >  	struct ppp_file *pf = file->private_data;
> > >  	DECLARE_WAITQUEUE(wait, current);
> > > -	ssize_t ret;
> > > +	ssize_t ret = 0; /* suppress compiler warning */
> > >  	struct sk_buff *skb = 0;
> > >  
> The code is in ppp_read actually OK; if you trace through the logic
> you can prove that ret is never actually used without being set first.

That's right - that's exactly why I wrote "suppress compiler warning".
It's just the compiler not smart enough (of course, i looked at the code
paths and I'd just fix it if it was broken).

Anyway, it seems there are more places like that in the kernel tree, so,
as Alan said, the correct thing to improve is the compiler (not even sure
if gcc3 would print the warning, I'm using RH "2.96" gcc).
-- 
Krzysztof Halasa
Network Administrator
