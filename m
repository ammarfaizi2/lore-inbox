Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWHIAO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWHIAO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 20:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWHIAO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 20:14:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:22857 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030359AbWHIAO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 20:14:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jB4ZOdScdzLdguC0RTEElDqn752Ll/9dPicKPbaewemvcsU8gcoYDNPfdYgnI2Jx7XO03MSpDe4V0G09mwuJcS2v3NEhZBvOYBZ8LyKS8Lzgbh7arroBIM0dQd1koy1DtMURUfSQ43fs9wCO7LB/FKQ1CbSbPXH1obb0JSHct+A=
Message-ID: <aec7e5c30608081714g19783fecn3ad5ac770cd85e3d@mail.gmail.com>
Date: Wed, 9 Aug 2006 09:14:17 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] i386: mark two more functions as __init
Cc: "Magnus Damm" <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <20060808125803.9aac260f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060808081756.334.46571.sendpatchset@cherry.local>
	 <20060808125803.9aac260f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/06, Andrew Morton <akpm@osdl.org> wrote:
> On Tue,  8 Aug 2006 17:17:00 +0900 (JST)
> Magnus Damm <magnus@valinux.co.jp> wrote:
>
> > i386: mark two more functions as __init
> >
> > cyrix_identify() should be __init because transmeta_identify() is.
> > tsc_init() is only called from setup_arch() which is marked as __init.
> >
> > These two section mismatches have been detected using running modpost on
> > a vmlinux image compiled with CONFIG_RELOCATABLE=y.
> >
> > -static void cyrix_identify(struct cpuinfo_x86 * c)
> > +static void __init cyrix_identify(struct cpuinfo_x86 * c)
>
> Are we sure?  We end up putting a pointer to this into
> arch/i386/kernel/cpu/common.c:cpu_devs[], and that gets used from __cpuinit
> code.

Uh, right. The problem is that almost all cpu code is put in the
__init section today. I'll break out and resend the tsc code, and on
top of that post a set of patches that puts cpu code and data into
__cpuinit and __cpuinitdata sections.

Thanks!

/ magnus
