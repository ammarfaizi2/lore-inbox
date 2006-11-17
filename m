Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933744AbWKQRZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933744AbWKQRZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933743AbWKQRZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:25:14 -0500
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:34749 "EHLO
	smtp.opengridcomputing.com") by vger.kernel.org with ESMTP
	id S933741AbWKQRZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:25:12 -0500
Subject: Re: [PATCH  11/13] Core Resource Allocation
From: Steve Wise <swise@opengridcomputing.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <adaslgim2tt.fsf@cisco.com>
References: <20061116035826.22635.61230.stgit@dell3.ogc.int>
	 <20061116035923.22635.5397.stgit@dell3.ogc.int> <adaslgim2tt.fsf@cisco.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 11:25:11 -0600
Message-Id: <1163784311.8457.44.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 08:54 -0800, Roland Dreier wrote:
>  > +static u32 next_random(u32 rand)
>  > +{
>  > +	u32 y, ylast;
>  > +
>  > +	y = rand;	
>  > +	ylast = y;
>  > +	y = (y * 69069) & 0xffffffff;
>  > +	y = (y & 0x80000000) + (ylast & 0x7fffffff);
>  > +	if ((y & 1))
>  > +		y = ylast ^ (y > 1) ^ (2567483615UL);
>  > +	else
>  > +		y = ylast ^ (y > 1);
>  > +	y = y ^ (y >> 11);
>  > +	y = y ^ ((y >> 7) & 2636928640UL);
>  > +	y = y ^ ((y >> 15) & 4022730752UL);
>  > +	y = y ^ (y << 18);
>  > +	return y;
>  > +}
> 
> How about just using the kernel's random32()?
> 
> I haven't read the code really so I don't understand what's being
> randomized here, but random32() should be more than good enough for a
> typical randomized algorithm().
> 
>  - R.

I think we can use random32() or get_random_bytes().  I need to
re-review how this algorithm works.  Its randomizing the stag IDs so
they are not predictable.

Steve.



