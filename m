Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUIML65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUIML65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 07:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUIML65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 07:58:57 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:65464 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265098AbUIML6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 07:58:55 -0400
Subject: Re: [PATCH][2.4.28-pre3] USB drivers gcc-3.4 fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, drivers@neukum.org,
       marcelo.tosatti@cyclades.com, sailer@ife.ee.ethz.ch,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040912173018.44b9902f@lembas.zaitcev.lan>
References: <200409121129.i8CBT5Bo015222@harpo.it.uu.se>
	 <20040912173018.44b9902f@lembas.zaitcev.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095072845.14359.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Sep 2004 11:54:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-13 at 01:30, Pete Zaitcev wrote:
> >  		size -= pgrem;
> > -		(char *)buffer += pgrem;
> > +		buffer += pgrem;
> 
> I'm pretty sure it's done that way on purpose. There were compilers which
> did not allow any arithmetics on void*, and it had to be cast to char*.
> So perhaps it's correct for 2.6, which requires gcc 3 anyway, but I have
> my doubts about applicability of this to 2.4.

Should be ok for the 2.* gcc we support. (BTW is anyone using anything
less than 2.95 nowdays because we've still got 2.7.* workarounds in
asm-i386/semaphore.h !)

Otherwise in "valid" C it's

	buffer = ((char *)buffer) + pgrem;


