Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWFUVvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWFUVvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWFUVvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:51:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27841 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751475AbWFUVvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:51:22 -0400
Date: Wed, 21 Jun 2006 14:51:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix and optimize clock source update
Message-Id: <20060621145104.b13af6aa.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606212320450.12900@scrub.home>
References: <Pine.LNX.4.64.0606211434020.904@scrub.home>
	<1150923519.2690.14.camel@leatherman>
	<Pine.LNX.4.64.0606212320450.12900@scrub.home>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 23:38:32 +0200 (CEST)
Roman Zippel <zippel@linux-m68k.org> wrote:

> > > +#define clocksource_adjustcheck(sign, error, interval, offset) ({	\
> > > +	int adj = sign;							\
> > > +	error >>= 2;							\
> > > +	if (unlikely(sign > 0 ? error > interval : error < interval)) {	\
> > > +		adj = clocksource_bigadjust(sign, error,		\
> > > +					    interval, offset);		\
> > > +		interval <<= adj;					\
> > > +		offset <<= adj;						\
> > > +		adj = sign << adj;					\
> > > +	}								\
> > > +	adj;								\
> > > +})
> > 
> > That's still a #define with side effects. Yuck.
> 
> The alternative is duplicating the code and an inline function which takes 
> the address of these variables would likely generate worse code.

Can you verify that please?  It is pretty sick.
