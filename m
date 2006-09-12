Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWILKxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWILKxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 06:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWILKxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 06:53:30 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:21598 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932144AbWILKx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 06:53:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lxf+xdDNJUxCyWiatt5C5ldfZYGQgZX7pGT9gPPa7gKvxsQhyreMqA9LGXkLnhc6rcDRalLnusasTf9ZcE4XurWxVoPmYKmV4h/Hhy2GuRH+MMOGGbxSwEFbMXjIRcOIrvjwR1sE/+6a7XmbpH0n0SmNmH8fYG8MHVWJ7GxfmxY=
Message-ID: <6d6a94c50609120353h57005b1axc3720ab3e443d3e3@mail.gmail.com>
Date: Tue, 12 Sep 2006 18:53:28 +0800
From: Aubrey <aubreylee@gmail.com>
To: "David Howells" <dhowells@redhat.com>
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, davidm@snapgear.com, gerg@snapgear.com
In-Reply-To: <30943.1158051248@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com>
	 <17162.1157365295@warthog.cambridge.redhat.com>
	 <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com>
	 <3551.1157448903@warthog.cambridge.redhat.com>
	 <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com>
	 <44FE4222.3080106@yahoo.com.au>
	 <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com>
	 <30943.1158051248@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/06, David Howells <dhowells@redhat.com> wrote:
> Aubrey <aubreylee@gmail.com> wrote:
>
> > OK. Here is the patch and work properly on my side.
> > Welcome any suggestions and comments.
>
> It looks reasonable.  Don't forget to sign off the patch.
>
> > void kmem_cache_init(void)
> > {
> > +#if 0
> >       void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);
> >
> >       if (p)
> >               free_page((unsigned long)p);
> > +#endif
>
> Any idea what that's about?
>
IMHO kmem_cache_init() needn't to do anything for the slob allocation.

In addition, the original code allocate one page and then free it.
Here, with the patch, slob_alloc() will set the SLAB flag on the page,
and the page with this flag can't pass the free_pages_check(), if so,
the kernel will run into bad_page() panic.

So, I removed this piece of code for the draft of the patch.
Welcome any better idea.

Regards,
-Aubrey
