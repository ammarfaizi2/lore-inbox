Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757530AbWKXAur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757530AbWKXAur (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 19:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757531AbWKXAur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 19:50:47 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:58730 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1757530AbWKXAuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 19:50:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=evoYOmbSfjqLVOSDBJffZXfNG39zX6DibBVbV8ro1mM6yzDN76ILK0PRkG9N/Rm4sA5S24AAH0ytzNlmn3hrSbHpZPDh1tmxSw1rLTNztPOE6VaEleQF64XHgXNGNJ2Uo125knCPhDe2KFf6yEv/vzsfq292WMA4UH2lgtf/Kas=
Message-ID: <9a8748490611231650y78f370bdtc370098eef15e9ee@mail.gmail.com>
Date: Fri, 24 Nov 2006 01:50:45 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
	 <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com>
	 <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
	 <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com>
	 <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com>
	 <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org>
	 <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com>
	 <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com>
	 <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com>
	 <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Wed, 22 Nov 2006, Jesper Juhl wrote:
> >
> > So it *seems* to be somehow related to running low on RAM and swap
> > starting to be used.
>
> Does it happen if you just do some simple "use all memory" script, eg run
> a few copies of
>
>         #define SIZE (100<<20)
>
>         char *buf = malloc(SIZE);
>         memset(buf, SIZE, 0);
>         sleep(100);
>
> on your box?
>

No. That doesn't kill the box.  It very effectively turns it into a
slug (bigtime) but it doesn't kill it.

Running just a single copy is no problem. Neither is running 4 or 5 in
parallel.
Doing
    for i in $(seq 1 30); do ./a.out & done
turns the box into a slug for 5 minutes or so, but then when all the
processes have terminated and another few minutes have passed it is
back to normal.
Running
    for i in $(seq 1 100); do ./a.out & done
is a different story though.  Starting the first ~40 processes happens
relatively fast, then starting the next 10-20 or so happens very
slowly (5-10 sec intervals between each one), then it starts taking
something like 20-30 seconds for each new process to start and when we
get somewhere around 75-85 processes started the box appears to be
hung, except that sysrq still works and I can still switch tty's with
ctrl+alt+F?. After a few minutes in this almost-hung state the Oom
killer kicks in and kills a few of the processes and after some
additional minutes all 100 processes eventually get started and
sometimes a few have even started to die off as well.  Once all 100
processes have been started it takes somewhere around 5-10 minutes for
them all to terminate (most terminate normally, some die with
"segmentation fault" and they die off roughly in the order they got
started).  The biggest problem after all processes have terminated is
then that the box remains a slug.  I left it alone for ~10 minutes at
this point and when I came back it was still not back to normal (and
trying to do a normal reboot took so long that I eventually lost my
patience and used sysrq+b to boot it).


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
