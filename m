Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVLUBuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVLUBuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 20:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVLUBuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 20:50:37 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:45004 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S932244AbVLUBug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 20:50:36 -0500
Date: Tue, 20 Dec 2005 17:50:12 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051221015012.GC86547@gaz.sfgoth.com>
References: <20051220214511.12bbb69c@inspiron> <20051220211344.GA14403@infradead.org> <20051220222343.71ee6bab@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220222343.71ee6bab@inspiron>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Tue, 20 Dec 2005 17:50:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Zummo wrote:
> > > +static const unsigned char rtc_days_in_month[] = {
> > > +	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
> > > +};
> > > +EXPORT_SYMBOL(rtc_days_in_month);
> > 
> > exporting static symbols is pretty wrong.  Exporting tables is pretty
> > bad style aswell.
> 
>  Tables like this one are often used in rtc drivers. What
>  can I use instead?

Why not just provide a macro in a .h file?  Something like:

/* Days in month -- month is in the range (0..11), no leap year */
#define rtc_days_in_month(mon)	(28 + ((0xEEFBB3 >> ((mon) * 2)) & 3))

-Mitch
