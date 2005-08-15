Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVHOJeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVHOJeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 05:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVHOJeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 05:34:09 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:42148 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932358AbVHOJeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 05:34:08 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: Re: [-mm patch] make kcalloc() a static inline
Date: Mon, 15 Aug 2005 12:33:46 +0300
User-Agent: KMail/1.5.4
Cc: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050808223842.GM4006@stusta.de> <200508151120.46186.vda@ilport.com.ua> <Pine.LNX.4.58.0508151126570.26955@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0508151126570.26955@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508151233.46523.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > static inline void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
> > {
> > 	if (__builtin_constant_p(n)) {
> > 		if (n != 0 && size > INT_MAX / n)
> > 			return NULL;
> > 		return kzalloc(n * size, flags);
> > 	}
> > 	return kcalloc_helper(n, size, flags);
> > }
> > 
> > void *kcalloc_helper(size_t n, size_t size, unsigned int __nocast flags)
> > {
> > 	if (n != 0 && size > INT_MAX / n)
> > 		return NULL;
> > 	return kzalloc(n * size, flags);
> > }
> 
> That's extra complexity and code duplication. How much do we shave off 
> kernel text of allyesconfig with this?
> 
> Please note that whenever the caller does proper bounds checking, GCC can 
> optimize the security check away. Therefore, in practice, we don't spread 
> around the extra operations so much, I think.

gcc can optimize that away with non-const n?! I don't think so.
--
vda

