Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbVJEOkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbVJEOkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVJEOkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:40:10 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:45492 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932635AbVJEOkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:40:08 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=SegkjgbEE7XHdDwEdHHkRmiawC6i/+SM2h9rwHS9TVo372TTZtzvKvPvPH/LloVu+
	Ezr7n2pXeTX1NbPCnkTZw==
Date: Wed, 05 Oct 2005 07:39:46 -0700
From: David Brownell <david-b@pacbell.net>
To: vwool@ru.mvista.com, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH/RFC 1/2] simple SPI framework
Cc: stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       pavel@ucw.cz, linux-kernel@vger.kernel.org, dpervushin@gmail.com,
       basicmark@yahoo.com
References: <20051004180241.0EAA5EE8D1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <4343898D.1060904@ru.mvista.com>
 <20051005090129.GB7208@flint.arm.linux.org.uk>
In-Reply-To: <20051005090129.GB7208@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051005143946.7D9C9EE8EC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >+/* Suspend/resume in "struct device_driver" don't really need that
> > >+ * strange third parameter, so we just make it a constant and expect
> > >+ * SPI drivers to ignore it just like most platform drivers do.
> > >+ *
> >
> > So you just ignored my letter on that subject :(
> > The fact that you don't need it doesn't mean that other people won't.
> > The fact that there's no clean way to suspend USB doesn't mean that 
> > there shouldn't be one for SPI.
>
> The third parameter is obsolete and should only be used to select _one_
> of the tree suspend calls you will get.

Vitaly ... comments from Russell and Pavel both addresses your comments
about that obsolete parameter.  What letter?  The one I remember was
one responding to Mark Underwood (?) where you complained about issuing
three calls for one suspend event.  You can't have it both ways!!
Either that parameter should be used in the documented way (call the
suspend method three times, one right after another) or it should be used
more sanely (parameter is constant.

USB can suspend just fine, thank you, though starting with 2.6.12 some
bugs seem to have crept in; fixes are in the 2.6.15 prepatchces.


> Any additional suspend calls should _not_ create extra usage of this
> parameter.  It's a left over from Pat's first driver model incarnation
> which is specific to the platform device drivers.  (Mainly it exists
> because no one can be bothered to clean it up.)

Most folk who've considered the question would like to see it go away.
Except ... making sure every driver in a few dozen architectures still
builds after removing that parameter is more than the usual amount of
janitorial work!

Progress could start by updating Documentation/driver-model/driver.txt to
say "don't test that parameter", reducing future confusion on this point.

- Dave

