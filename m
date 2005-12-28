Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVL1HzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVL1HzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 02:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVL1HzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 02:55:16 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30869 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932498AbVL1HzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 02:55:15 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 2 of 3] memcpy32 for x86_64
Date: Wed, 28 Dec 2005 09:54:45 +0200
User-Agent: KMail/1.8.2
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org
References: <patchbomb.1135726914@eng-12.pathscale.com> <042b7d9004acd65f6655.1135726916@eng-12.pathscale.com> <20051228042232.GC3356@waste.org>
In-Reply-To: <20051228042232.GC3356@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512280954.45705.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > + 	.globl memcpy32
> > +memcpy32:
> > +	movl %edx,%ecx
> > +	shrl $1,%ecx
> > +	andl $1,%edx
> > +	rep
> > +	movsq

Does this one really do 32-bit stores?! I doubt so...

> > +	movl %edx,%ecx
> > +	rep
> > +	movsd
> > +	ret
> 
> Any reason this needs its own .S file? One wonders if the
> 
>         .p2align 4
> 
> in memcpy.S is appropriate here too. Splitting rep movsq across two
> lines is a little weird to me too, but I see Andi did it too.
--
vda
