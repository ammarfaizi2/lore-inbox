Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTEBSGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTEBSGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:06:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263050AbTEBSGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:06:38 -0400
Date: Fri, 2 May 2003 11:19:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Aic7xxx and Aic79xx Driver Updates
In-Reply-To: <1051898880.1819.63.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0305021117270.1667-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 May 2003, James Bottomley wrote:
> 
> I'm not asking for any changes to the way you do 2.4, just for 2.5 where
> we have no vendor versions to support and there should only be a single
> tree.

The way the backwards-compatibility is _meant_ to work is that a driver 
can just do this:

	#ifndef IRQ_RETVAL
	  typedef void irqreturn_t;
	  #define IRQ_NONE
	  #define IRQ_HANDLED
	  #define IRQ_RETVAL(x)
	#endif

and after that you can just use the 2.5.x semantics even with a 2.4.x 
kernel.

Which is nice and clean, and allows you to support old kernels _without_ 
having any translation layer.

		Linus

