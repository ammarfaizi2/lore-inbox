Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWCWJrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWCWJrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWCWJrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:47:25 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:57799 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751260AbWCWJrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:47:24 -0500
Date: Thu, 23 Mar 2006 10:47:22 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/24] s390: channel path measurements.
Message-ID: <20060323104722.4183efbb@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060322132655.79d85b61.akpm@osdl.org>
References: <20060322151539.GC5801@skybase.boeblingen.de.ibm.com>
	<20060322132655.79d85b61.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2006 13:26:55 -0800
Andrew Morton <akpm@osdl.org> wrote:

> hm, it's somewhat unusual for MAX_FOO to be inclusive.  Usually it means
> "greatest possible+1".

__MAX_SUBCHANNEL and friends in drivers/s390/cio/css.h all use the same
semantics :)

> > +static inline int
> > +__chsc_do_secm(struct channel_subsystem *css, int enable, void *page)
> 
> This has two callsites.  inlining it probably deoptimises things.

OK.

> 
> > +	secm_area->request = (struct chsc_header) {
> > +		.length = 0x0050,
> > +		.code   = 0x0016,
> > +	};
> 
> gcc tends to generate poor code for this construct.

Switching this to direct initialization seems to save a mvc. I'll
convert all instances in chsc.c for consistency.

Cornelia
