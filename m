Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbSJ1P5f>; Mon, 28 Oct 2002 10:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSJ1P5f>; Mon, 28 Oct 2002 10:57:35 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:33980 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261320AbSJ1P5e>;
	Mon, 28 Oct 2002 10:57:34 -0500
Message-ID: <3DBD5FDE.6070604@colorfullife.com>
Date: Mon, 28 Oct 2002 17:03:42 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Marcus Alanen <marcus@infa.abo.fi>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] faster kmalloc lookup
References: <3DBBEA2F.6000404@colorfullife.com>	<3DBAEB64.1090109@colorfullife.com>	<1035671412.13032.125.camel@irongate.swansea.linux.org.uk>	<3DBBBB30.20409@colorfullife.com>	<15805.13847.945978.673664@laputa.namesys.com>	<200210281318.PAA19085@infa.abo.fi> <15805.15113.459553.881857@laputa.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Marcus Alanen writes:
> > >Most kmalloc calls get constant size argument (usually
> > >sizeof(something)). So, if switch() is used in stead of loop (and
> > >kmalloc made inline), compiler would be able to optimize away
> > >cache_sizes[] selection completely. Attached (ugly) patch does this.
> > 
> > Perhaps a compile-time test to check if the argument is
> > a constant, and only in that case call your new kmalloc, otherwise
> > a non-inline kmalloc call? With your current patch, a non-constant
> > size argument to kmalloc means that the function is inlined anyway,
> > leading to unnecessary bloat in the resulting image.
>
>Yes, exactly.
>  
>
I agree, I have an old patch that does that.

http://www.colorfullife.com/~manfred/slab/patch-km_div

Please ignore the part about fixed point division, it's not needed - the 
'div' instructions is now outside of the hot path.

The problem is that the -mm tree contains around 10 slab patches, I want 
to see them in Linus' tree before I add further patches.

--
    Manfred

