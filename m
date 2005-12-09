Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbVLIKSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbVLIKSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVLIKSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:18:38 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:44896 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751304AbVLIKSh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:18:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sR4CorjxOHYpF+xXWFMXOHZ+vHCwt+BT3dQDANxl2Sw7fx3t1t5OqRY1Jj7VvFosCxN3kvi2Y+ijMUFiunBrtVXNFIIi1WIXHnrX4HyCBJJ0sIiGvfdrDHBu/JhP3zYQJ24Tz+DZLxTW6y6bUKazwDDCQQx1C+4/8EAdrHRW+Nw=
Message-ID: <9a8748490512090218q72998aebq8c09247921bd167e@mail.gmail.com>
Date: Fri, 9 Dec 2005 11:18:36 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Decrease number of pointer derefs in nf_conntrack_core.c
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Core Team <coreteam@netfilter.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051209110441.GC20314@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512082336.19695.jesper.juhl@gmail.com>
	 <20051209110441.GC20314@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> > orig:
> >    text    data     bss     dec     hex filename
> >   12636      49     760   13445    3485 net/netfilter/nf_conntrack_core.o
> >
> > patched:
> >    text    data     bss     dec     hex filename
> >   11825     183     632   12640    3160 net/netfilter/nf_conntrack_core.o
>
> just a question - are you sure the measurements are accurate in this
> case? The patch looks too small to shave more than 800 bytes off .text!
> If it's real then something really wrong is going on in gcc-land ...
>
I did all this with an allyesconfig kernel source and then did :
   make net/netfilter/nf_conntrack_core.o
   size net/netfilter/nf_conntrack_core.o
   rm net/netfilter/nf_conntrack_core.o
then applied the patch and redid
   make net/netfilter/nf_conntrack_core.o
   size net/netfilter/nf_conntrack_core.o

So I believe the numbers should be correct, but I'm not at home atm,
so I can't verify right now. I won't have a chance to look at it until
tomorrow, but then I'll double-check.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
