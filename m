Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285188AbRLXSAm>; Mon, 24 Dec 2001 13:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285189AbRLXSAd>; Mon, 24 Dec 2001 13:00:33 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:44426 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S285188AbRLXSAZ>; Mon, 24 Dec 2001 13:00:25 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Date: Mon, 24 Dec 2001 09:34:45 -0800 (PST)
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <3C27608B.4030900@redhat.com>
Message-ID: <Pine.LNX.4.40.0112240933110.24605-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you miss the point, the syscall numbers will not nessasarily be consistant
from boot to boot so if your code does not check for them it's seriously
broken (and remember this is only for stuff in experimental status). The
hope is that most if not all of the real checking can end up being done in
glibc

David Lang



 On Mon, 24 Dec 2001, Doug Ledford wrote:

> Date: Mon, 24 Dec 2001 12:06:19 -0500
> From: Doug Ledford <dledford@redhat.com>
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Keith Owens <kaos@ocs.com.au>, Benjamin LaHaise <bcrl@redhat.com>,
>      linux-kernel@vger.kernel.org
> Subject: Re: [patch] Assigning syscall numbers for testing
>
> Alan Cox wrote:
>
> >>Well, I'm not going to mess with code, but here's the example.  Say you
> >>start at syscall 240 for dynamic registration.  Someone then submits a patch
> >>
> >
> > The number you start at depends on the kernel you run.
> >
> >
> >>modify the base of your patch, but if it has been accepted into any real
> >>kernels anywhere, then someone could inadvertently end up running a user
> >>space app compiled against Linus' new kernel and that uses the newly
> >>allocated syscalls 240 and 241.  If that's run on an older kernel with your
> >>
> >
> > The code on execution will read the syscall numbers from procfs. It will
> > find new numbers and call those. Its a very simple implementation of lazy
> > binding. It only breaks if you actually run out of syscalls, and then it
> > fails safe.
> >
> > Alan
> >
> >
>
> No it doesn't.  You are *assuming* that *all* code will check the lazy
> syscall bindings.  My example was about code using the predefined syscall
> number for new functions on an older kernel where those functions don't
> exist, but where they overlap with the older dynamic syscall numbers.  In
> short, the patch is safe for code that uses the lazy binding, but it can
> still overlap with future syscall numbers and code that doesn't use the lazy
> binding but instead uses predefined numbers.
>
> --
>
>   Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
>        Please check my web site for aic7xxx updates/answers before
>                        e-mailing me about problems
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
