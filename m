Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbSLCTfC>; Tue, 3 Dec 2002 14:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbSLCTfC>; Tue, 3 Dec 2002 14:35:02 -0500
Received: from air-2.osdl.org ([65.172.181.6]:14253 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265517AbSLCTe4>;
	Tue, 3 Dec 2002 14:34:56 -0500
Date: Tue, 3 Dec 2002 11:42:01 -0800
From: Dave Olien <dmo@osdl.org>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: cobra@compuserve.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 at 2.5.50
Message-ID: <20021203114201.A32313@acpi.pdx.osdl.net>
References: <E18HR1a-0005QL-00@f12.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E18HR1a-0005QL-00@f12.mail.ru>; from _deepfire@mail.ru on Thu, Nov 28, 2002 at 06:56:22PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Let me know if you find any problems at all.  I'll try to
address them.

I think the biggest "imperfection" is just the coding style of
the whole driver.  I might submit some patches over time to clean
up coding style.

The next problem is that it doesn't handle media errors yet.
If you have a read or write failure because a sector on your disk
is bad, it fails the entire read or write. With all the coalescing
of requests that the block layer does, this might fail ALL of a
really large transfer just because one sector is bad.

I'm working on a patch that retries failures section at a time,
so that the failure will be more closely limited to the sector 
that is bad.


On Thu, Nov 28, 2002 at 06:56:22PM +0300, Samium Gromoff wrote:
>  > Samium Gromoff...
> > > > <alan@lxorguk.ukuu.org.uk>
> > > >         [PATCH] update to OSDL DAC960 driver
> > > >
> > > >         Its not perfect but it works
> > >    is it supposed to blow my data, or is it relatively safe to use?
> >
> > There have been a few poeple using this patch for about 5 versions of
> > 2.5 so far.  I haven't done heavy testing myself, just booting and doing
> > some other testing of modules and drivers.  I am running the DAC960 on
> > my root/boot filesystem and haven't seen any problems yet.
>   thank you. i`ll join the 2.5 DAC user crowd soon then :-)
> 
> ---
> regards,
>    Samium Gromoff
> _____________________________________
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
