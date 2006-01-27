Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWA0Gk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWA0Gk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 01:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWA0Gk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 01:40:29 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:30926 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751034AbWA0Gk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 01:40:28 -0500
Date: Fri, 27 Jan 2006 15:40:34 +0900
To: Balbir Singh <bsingharora@gmail.com>
Cc: Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 8/12] generic hweight{32,16,8}()
Message-ID: <20060127064034.GB8166@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060125205907.GF9995@esmail.cup.hp.com> <20060126032713.GA9984@miraclelinux.com> <20060126033613.GG11138@miraclelinux.com> <661de9470601252312m1f9c9256peb79451e49fc8662@mail.gmail.com> <20060127045522.GA7587@miraclelinux.com> <661de9470601262140x4e870cd5me9ba0f8e9d52f421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661de9470601262140x4e870cd5me9ba0f8e9d52f421@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 11:10:29AM +0530, Balbir Singh wrote:
> On 1/27/06, Akinobu Mita <mita@miraclelinux.com> wrote:
> > On Thu, Jan 26, 2006 at 12:42:09PM +0530, Balbir Singh wrote:
> >
> > > > +static inline unsigned int hweight32(unsigned int w)
> > > > +{
> > > > +        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
> > > > +        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
> > > > +        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
> > > > +        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
> > > > +        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
> > > > +}
> > > > +
> > >
> > > This can be replaced with
> > >
> > >   register int res=w;
> > >   res=res-((res>>1)&0x55555555);
> > >   res=(res&0x33333333)+((res>>2)&0x33333333);
> > >   res=(res+(res>>4))&0x0f0f0f0f;
> > >   res=res+(res>>8);
> > >   return (res+(res>>16)) & 0xff;
> >
> > Probably you are right.
> > Unfortunately, it is difficult for me to prove that sane equivalence.
> >
> 
> Well, a proof is not difficult. This is a well tested proven piece of
> code published by Don Knuth. If you need a proof, I can provide one.

Thanks, I want.
