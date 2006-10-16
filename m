Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422920AbWJPXNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422920AbWJPXNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422921AbWJPXNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:13:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:43970 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422920AbWJPXNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:13:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oDzt5BQjISjGVqQH6X+WJZ0mYszMw3nmwEy0y9xCAa6yTuQmmDqX00RDdPlYlX9eRsKO04JBJa6XDHpqXDU0PlQl7b7wGwFgkJt+J3cnP5nIOtPVotLjy2IhKFUOYxoF9gYWx0uo/08zD4BNRjixOipzsP3rZVqSmnrOZXZkONg=
Message-ID: <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com>
Date: Tue, 17 Oct 2006 01:13:10 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
	 <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org>
	 <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com>
	 <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
	 <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com>
	 <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com>
	 <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 17 Oct 2006, Jesper Juhl wrote:
> >
> > Ok, finally got to the end of the bisection (see below; quoting all of
> > my previous email since my concerns from that one are still valid).
>
> Ok. It does smell like you marked somethign good that wasn't. That commit
> 1db27c11 was the last one you claimed was bad, of course, so it's the one
> git will claim caused it, when you've marked its parent good.
>
> > Where do I go from here?   The problem is still there...    I'll test
> > 2.6.19-rc2 tomorrow, but apart from that I don't know how to proceed
> > apart from trying to capture a sysrq+t dump when the box locks up...
> > any ideas?
>
> Yeah, trying to do sysrq when it locks is probably worth it. As is
> enabling debugging things (netconsole, page-alloc, slab alloc, lockdep
> etc).
>
I've got all those debug options (and more) enabled already in all the
bisection builds. I run with those options enabled most of the time
and I didn't change my config for any of the kernels I tested (except
for running 'make oldconfig').
netconsole is not much use to me as I don't have a second box at the
moment to capture output on :-(   So the best I can do there is to let
the box run in a plain console with the test script and then press
sysrq+t when it locks and take a photo of the output (or whats left of
it on the screen) if any.


> But if nothing seems to really give any clues, you might just try
> to restart bisection with
>
>         git bisect reset
>         git bisect start
>         git bisect good v2.6.17
>         git bisect bad 1db27c11
>
> and just run the resulting kernel version for a day or two. If an hour
> wasn't really good enough, it's not as repeatable as we'd have wished, but
> even if it takes a few days to narrow it down by just two bisections or
> so, it will cut things down from ten thousand commits to "just" 2500..
>
Ok, sure. I'll do a days run of 2.6.19-rc2 first, just to see if it's
been fixed in the mean time. If it's still there I'll try to get a
sysrq+t and post that, then I'll restart bisection and give each
kernel a full 24hrs of testing before concluding it is good.

I'll report back as soon as I have some results.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
