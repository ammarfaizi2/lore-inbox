Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266056AbUAQPge (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 10:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUAQPge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 10:36:34 -0500
Received: from mail.ccur.com ([208.248.32.212]:46602 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S266056AbUAQPgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 10:36:32 -0500
Date: Sat, 17 Jan 2004 10:36:15 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com, akpm@osdl.org,
       paulus@samba.org
Subject: Re: [PATCH] bitmap parsing routines, version 3
Message-ID: <20040117153615.GA16385@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040114150331.02220d4d.pj@sgi.com> <20040115002703.GA20971@tsunami.ccur.com> <20040114204009.3dc4c225.pj@sgi.com> <20040115081533.63c61d7f.akpm@osdl.org> <20040115181525.GA31086@tsunami.ccur.com> <20040115161732.458159f5.pj@sgi.com> <400873EC.2000406@us.ibm.com> <20040117063618.GA14829@tsunami.ccur.com> <20040117020815.3ac17c46.pj@sgi.com> <20040117145545.GA16318@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117145545.GA16318@tsunami.ccur.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 09:55:45AM -0500, Joe Korty wrote:
> > > +	bitmap_clear(maskp, nmaskbits);
> > 
> > Might be better to clear all the bits in the mask,
> > not just the low order nmaskbits worth.
> 
> Thanks.  Will do.
> Joe

Hi Paul,
On reflection, I reverse my position -- this should really be done in
bitmap_clear et all as an attribute of bitmaps in general, rather than
as something local to bitmap_parse.

Right now, the bitmap functions treat the unused bits as a kind of
garbage dump.  For example, bitmap_complement() flips every bit in
the set of unsigned longs.  Therefore it is somewhat meaningless for
bitmap_parse, alone among the bitmap functions, to treat the unused bits
as something special.

-- 
Joe
"Money can buy bandwidth, but latency is forever" -- John Mashey
