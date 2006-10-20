Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992435AbWJTCrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992435AbWJTCrg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992436AbWJTCrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:47:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:15962 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2992435AbWJTCrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:47:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=TDPMl3t37P6ObJRr0ytoQ65SPdiG77U8m+ueAOpIH0bQrgKpCrB0LNCZmxYded5JWd8I3nYVfLRZ77tR65/du8QjCw38opriSWuUBYaoFgc7yx7FgmJeH1IKuE2qicXsPXl+cntr2kza5i8LmMiO8ucambDmoI6iCdFAWmhSeSU=
Date: Fri, 20 Oct 2006 11:48:27 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH 3/6] video: use bitrev8
Message-ID: <20061020024827.GA6344@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
	Antonino Daplas <adaplas@pol.net>
References: <20061018164420.GC21820@localhost> <4537458D.4050107@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4537458D.4050107@tls.msk.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 01:29:49PM +0400, Michael Tokarev wrote:
> >  static inline void reverse_order(u32 *l)
> >  {
> >  	u8 *a = (u8 *)l;
> > -	*a = byte_rev[*a], a++;
> > -	*a = byte_rev[*a], a++;
> > -	*a = byte_rev[*a], a++;
> > -	*a = byte_rev[*a];
> > +	a[0] = bitrev8(a[0]);
> > +	a[1] = bitrev8(a[1]);
> > +	a[2] = bitrev8(a[2]);
> > +	a[3] = bitrev8(a[3]);
> >  }
> 
> This looks like a good candidate for a common helper function, too.

I thought that and we already have static function bytereverse()
in lib/crc32. But I could not find where I could replace except here.
So I didn't put bytereverse() into bitrev.h

