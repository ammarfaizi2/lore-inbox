Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031655AbWLAAmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031655AbWLAAmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 19:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031656AbWLAAmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 19:42:54 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:26512 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1031655AbWLAAmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 19:42:53 -0500
Date: Fri, 1 Dec 2006 09:42:29 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Paul Jackson <pj@sgi.com>
Cc: Komal Shah <komal.shah802003@gmail.com>, "M. R. Brown" <mrbrown@0xd6.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: bitmap?_find_free_region and bitmap_full arg doubts
Message-ID: <20061201004229.GA25702@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Paul Jackson <pj@sgi.com>, Komal Shah <komal.shah802003@gmail.com>,
	"M. R. Brown" <mrbrown@0xd6.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <3a5b1be00611300733y121ef089m66bf46852ec0866d@mail.gmail.com> <20061130161008.5417c8b4.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130161008.5417c8b4.pj@sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 04:10:08PM -0800, Paul Jackson wrote:
> The call to bitmap_find_free_region(), in arch/sh/kernel/cpu/sh4/sq.c
> looks bogus:
> 
>         page = bitmap_find_free_region(sq_bitmap, 0x04000000,
>                                        get_order(map->size));
> 
> It says the bitmap has 0x04000000 bits.  This would take 0x04000000 / 8
> which is 8388608 (decimal) bytes to hold.  That's an insanely
> huge bitmap - 8 million bytes worth of bits.
> 
Ouch, you're right, for some reason we missed the >> PAGE_SHIFT here,
even though it was handled properly in sq_api_init(). I suppose we
haven't hit this in practice as most of the users end up being quite
small. I'll fix it up. Good catch, thanks!
