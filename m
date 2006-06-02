Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWFBHjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWFBHjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWFBHjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:39:49 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:58424 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751269AbWFBHjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:39:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HAbKWvUjcTbnFmGKQ0q+PY7e18zP9xdsfH9ihO9yKxXAGaI3SdiXqCb/ajDljn8Rq0bUz2AyV9rR4ZSE4NCy7xpjYcb4qWb1RcgSkpyFaBbsmYw1MDdtX5EAzqUtJ+3vNLLNfsavbDNpvltxduipWxO8tdvGU8ZVIiPMHVYTS7g=
Message-ID: <21d7e9970606020039s8d2d68fq69988b6b6488722b@mail.gmail.com>
Date: Fri, 2 Jun 2006 17:39:44 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Abu M. Muttalib" <abum@aftek.com>
Subject: Re: Page Allocation Failure, Why?? Bug in kernel??
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       "Paulo Marques" <pmarques@grupopie.com>, linux-kernel@vger.kernel.org
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMEEJNCNAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490606020005n841abafjc7e05a5e2ab8a312@mail.gmail.com>
	 <BKEKJNIHLJDCFGDBOHGMEEJNCNAA.abum@aftek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fragmentation.

you have 32-pages scattered around the place, they are not in the one
place, you are asking for 32-contiguous pages, you cannot get this as
the memory is fragmented.

you should really never try allocating that many contiguous pages.

Dave.

On 6/2/06, Abu M. Muttalib <abum@aftek.com> wrote:
> Hi,
>
> I repeat my question, the required no of pages are available, as shown in
> the dump produced by kernel, the request is not fulfilled. Its as follows:
>
> DMA: 106*4kB 11*8kB 5*16kB 3*32kB 2*64kB 1*128kB 0*256kB 0*512kB 0*1024kB =
> 944kB
>
> Why this is so??
>
> ~Abu.
>
> -----Original Message-----
> From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
> Sent: Friday, June 02, 2006 12:36 PM
> To: Abu M. Muttalib
> Cc: Martin J. Bligh; Paulo Marques; linux-kernel@vger.kernel.org
> Subject: Re: Page Allocation Failure, Why?? Bug in kernel??
>
>
> On 02/06/06, Abu M. Muttalib <abum@aftek.com> wrote:
> > Hi,
> >
> > That's precisely I want to say. The PAGES are available but they are not
> > allocated to process. Why??
> >
> There may be 32 pages available in total, but not 32 contiguous ones -
> that's a *lot* of contiguous pages to ask for in kernel space - 128KB
> (assuming a 4096 byte page size).
>
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
