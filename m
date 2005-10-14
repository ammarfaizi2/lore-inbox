Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbVJNVZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVJNVZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 17:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVJNVZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 17:25:06 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:39406 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750922AbVJNVZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 17:25:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XtLspwweVMkXMQUAPWkrVcpgyxXJZ4cJI+M8uPQDYNRdxMY053SVzomEnjm8L7lSi5O6ii/IRlIgid/M13Zpcuz7RjPXsKgtrwPbDM2Vu1TlkYqRnmwCBMgOUXd1e7DPqKvjMvK25rlZo44KmrqZv3iblZHLe8y+xXLOuHqKT9Y=
Message-ID: <43502222.8050505@gmail.com>
Date: Sat, 15 Oct 2005 05:24:50 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, iss_storagedev@hp.com,
       Jakub Jelinek <jj@ultra.linux.cz>, Frodo Looijaard <frodol@dds.nl>,
       Jean Delvare <khali@linux-fr.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Roland Dreier <rolandd@cisco.com>,
       Sergio Rozanski Filho <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pierre Ossman <drzeus-wbsd@drzeus.cx>,
       Carsten Gross <carsten@sol.wh-hms.uni-ulm.de>,
       Greg Kroah-Hartman <greg@kroah.com>,
       David Hinds <dahinds@users.sourceforge.net>,
       Vinh Truong <vinh.truong@eng.sun.com>,
       Mark Douglas Corner <mcorner@umich.edu>,
       Michael Downey <downey@zymeta.com>, Antonino Daplas <adaplas@pol.net>,
       Ben Gardner <bgardner@wabtec.com>
Subject: Re: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
References: <200510132128.45171.jesper.juhl@gmail.com>
In-Reply-To: <200510132128.45171.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> This is the remaining misc drivers/ part of the big kfree cleanup patch.
> 
> Remove pointless checks for NULL prior to calling kfree() in misc files in drivers/.
> 
> 
> Sorry about the long Cc: list, but I wanted to make sure I included everyone
> who's code I've changed with this patch.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---

> --- linux-2.6.14-rc4-orig/drivers/video/i810/i810_main.c	2005-10-11 22:41:21.000000000 +0200
> +++ linux-2.6.14-rc4/drivers/video/i810/i810_main.c	2005-10-13 10:34:11.000000000 +0200
> @@ -2066,8 +2066,7 @@ static void i810fb_release_resource(stru
>  		iounmap(par->mmio_start_virtual);
>  	if (par->aperture.virtual)
>  		iounmap(par->aperture.virtual);
> -	if (par->edid)
> -		kfree(par->edid);
> +	kfree(par->edid);
>  	if (par->res_flags & FRAMEBUFFER_REQ)
>  		release_mem_region(par->aperture.physical,
>  				   par->aperture.size);

Ok with me. Thanks.

Tony
