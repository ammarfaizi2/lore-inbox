Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424045AbWKIEYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424045AbWKIEYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 23:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424046AbWKIEYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 23:24:50 -0500
Received: from 1wt.eu ([62.212.114.60]:6661 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1424045AbWKIEYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 23:24:49 -0500
Date: Thu, 9 Nov 2006 05:24:34 +0100
From: Willy Tarreau <w@1wt.eu>
To: Dave Jones <davej@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gx-suspmod: fix "&& 0xff" typo
Message-ID: <20061109042433.GB589@1wt.eu>
References: <20061108220435.GA4972@martell.zuzino.mipt.ru> <20061108141007.e0adf333.randy.dunlap@oracle.com> <20061108221626.GH3309@redhat.com> <20061108222046.GE4972@martell.zuzino.mipt.ru> <20061108225007.GI3309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108225007.GI3309@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 05:50:07PM -0500, Dave Jones wrote:
> On Thu, Nov 09, 2006 at 01:20:46AM +0300, Alexey Dobriyan wrote:
>  > >  > > -	params->pci_rev = class_rev && 0xff;
>  > >  > > +	params->pci_rev = class_rev & 0xff;
>  > >  >
>  > >  > Hi,
>  > >  > any kind of automated detection on that one?
>  > >
>  > > grep -r "&& 0x" .  seems to be pretty effective modulo
>  > > some false-positives.
>  > 
>  > Obligatory nit-picking:
>  > 
>  > 	grep '&&[ 	]*0[xX][fF]' -r .
> 
> That misses some cases. Like..
> 
> drivers/char/ipmi/ipmi_msghandler.c:                    bmc->id.device_revision && 0x80 >> 7);
> drivers/char/ipmi/ipmi_msghandler.c:                    bmc->id.device_revision && 0x0F);

Interesting grep. I found that cmpci, gdth, net1080 and nv_setup are affected
too in my rather old 2.6.18-rc4 tree. More importantly, I found a few ones in
2.4 that I will have to address.

Thanks guys for the good idea. Once again, it shows that pure code review
would considerably help finding such bugs.

Cheers,
Willy

