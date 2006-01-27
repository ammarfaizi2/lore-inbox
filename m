Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWA0Fka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWA0Fka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 00:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWA0Fka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 00:40:30 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:15345 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750752AbWA0Fk3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 00:40:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IxXstPYqDMeCv2iy74w+5X+6RqU11F8b96lemkoz7dBcqEXKU5xzQRkJ45W1iKR+H5UeC2bt9a4nxDJ5oErjJ77cMZgY9HbR4D8eLwz9RR3gaJ23sXj7Ot6F0rxnmpJOkz052qX5hSqGXbtu1TffcN3CadOFGzkjvtudi88+Ohg=
Message-ID: <661de9470601262140x4e870cd5me9ba0f8e9d52f421@mail.gmail.com>
Date: Fri, 27 Jan 2006 11:10:29 +0530
From: Balbir Singh <bsingharora@gmail.com>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 8/12] generic hweight{32,16,8}()
Cc: Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
In-Reply-To: <20060127045522.GA7587@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060125112625.GA18584@miraclelinux.com>
	 <20060125113206.GD18584@miraclelinux.com>
	 <20060125200250.GA26443@flint.arm.linux.org.uk>
	 <20060125205907.GF9995@esmail.cup.hp.com>
	 <20060126032713.GA9984@miraclelinux.com>
	 <20060126033613.GG11138@miraclelinux.com>
	 <661de9470601252312m1f9c9256peb79451e49fc8662@mail.gmail.com>
	 <20060127045522.GA7587@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/06, Akinobu Mita <mita@miraclelinux.com> wrote:
> On Thu, Jan 26, 2006 at 12:42:09PM +0530, Balbir Singh wrote:
>
> > > +static inline unsigned int hweight32(unsigned int w)
> > > +{
> > > +        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
> > > +        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
> > > +        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
> > > +        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
> > > +        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
> > > +}
> > > +
> >
> > This can be replaced with
> >
> >   register int res=w;
> >   res=res-((res>>1)&0x55555555);
> >   res=(res&0x33333333)+((res>>2)&0x33333333);
> >   res=(res+(res>>4))&0x0f0f0f0f;
> >   res=res+(res>>8);
> >   return (res+(res>>16)) & 0xff;
>
> Probably you are right.
> Unfortunately, it is difficult for me to prove that sane equivalence.
>

Well, a proof is not difficult. This is a well tested proven piece of
code published by Don Knuth. If you need a proof, I can provide one.

> Anyway those hweight*() functions are copied from include/linux/bitops.h:
> generic_hweight*(). So you can optimize these functions.
>

You are right, even those functions can be optimized.

Balbir
