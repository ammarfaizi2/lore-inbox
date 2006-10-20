Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWJTPS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWJTPS7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWJTPS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:18:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:52093 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750726AbWJTPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:18:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dQqQTvuarNi1DY6h3B1Py/tH/kq09+Ose6zb2LiGefQb2dAQ5h1AhekvmoDpEqvtaHwkFVG8Wp0knTV2wFeS2XhBTzWeLcPaOkyZPmQNsH0ECct7wFmeNuhOKX8ZDRJir4qUu6ULcC967BCMCSto2hQKzk3TqU1X9URoAy5i7/A=
Message-ID: <787b0d920610200818t1950d17y10a41957fd747c63@mail.gmail.com>
Date: Fri, 20 Oct 2006 11:18:56 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [CFT] Grep to find users of sys_sysctl.
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Cal Peake" <cp@absolutedigital.net>, "Andi Kleen" <ak@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <m1wt6v2gts.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
	 <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
	 <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
	 <20061018124415.e45ece22.akpm@osdl.org>
	 <m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net>
	 <m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
	 <20061020075234.GA18645@flint.arm.linux.org.uk>
	 <m1wt6v2gts.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Jakub Jelinek <jakub@redhat.com> writes:
>
> > This assumes the binaries and/or libraries are not stripped, and they
> > usually are stripped.  So, it is better to run something like:
> > find / -type f -perm /111 | while read f; do readelf -Ws $f 2>/dev/null | fgrep
> > -q sysctl@GLIBC && echo $f; done
>
> Russell King <rmk+lkml@arm.linux.org.uk> writes:
> > glibc on ARM _requires_ sys_sysctl for userspace ioperm, inb, outb etc
> > emulation.
>
>
> It looks like we have a small but interesting set of sysctl users.
>
> The list of files below is a composite from a number of systems I have
> access to, and the reply I have gotten so far.  I'm still hoping to hear
> from other people so I can add some other users of sysctl to my list.

So does Linux now only support GLIBC apps? That's what your
grep seems to imply. At least one of the free Pascal compilers
does not use GLIBC. You won't find a GLIBC sysctl symbol in
any of the alternate C libraries (there are many) or even in libc5.

Running your grep on developer machines is highly biased
against legacy business apps.

Despite the desires of some fanatics, Linux does support an ABI
which is used by closed-source apps. Sometimes people even
lose their source code, perhaps via corporate reorganization.
I don't expect you plan to help anybody whose business depends
on some crufty old software...?

We have lots worse cruft if you want to go on a cleaning rampage.
We have old syscalls that can't handle modern data types.
