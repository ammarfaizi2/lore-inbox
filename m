Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVATVYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVATVYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVATVYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:24:49 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:15550 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261968AbVATVYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:24:42 -0500
Message-ID: <41F021AA.6050806@comcast.net>
Date: Thu, 20 Jan 2005 16:24:58 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu> <41EEA86D.7020108@comcast.net> <20050120104451.GE12665@elte.hu> <41EFF581.6050108@comcast.net> <20050120192258.GA8683@infradead.org>
In-Reply-To: <20050120192258.GA8683@infradead.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Christoph Hellwig wrote:
> On Thu, Jan 20, 2005 at 01:16:33PM -0500, John Richard Moser wrote:
> 
>>Granted, you're somewhat more diverse than I pointed out; but I don't
>>keep up on what you're doing.  The point was more that you're not a
>>major security figure and/or haven't donated your life to security and
>>forsaken all lovers before it like Joshua Brindle or Brad Spengler or
>>whoever the anonymous guy who developes PaX is.  I guess less focus on
>>the developer and more focus on the development.
> 
> 
> But Ingo is someone who
> 
>  - is a known allround kernel hacker
>  - has a trackrecord of getting things done that actually get used
>  - lowlevel CPU knowledge
>  - is able to comunicate with other developers very well
>  - is able to make good tradeoffs
>  - has taste
> 
> most of that can't be said for your personal heroes
> 

That's all good, but I notice being exceedingly competant in the needs
of a proper secured environment is lacking in your list.  Is he
exceedingly knowledgible about security?  Who is he working with who
will fill in his gaps in understanding if not?

The PaX developer may not be well known, or have anything in the kernel,
but I've talked to the guy.  He has CPU manuals for practically
everything, and *gasp* he READS them!  He maintains PaX himself, and it
works well on my AMD64; he has the manual, but not the CPU.

The trade-off of SEGMEXEC is 50% of VM space and 0.7% CPU.  The
trade-off of PAGEEXEC (on x86; a real NX bit is used on other CPUs) is
identical to Exec Shield's until that method fails, then it falls back
to a potentially very painful CPU trade-off that's necessary to continue
to offer a supported NX bit.

Explain "Taste."

> 
>>*shrug*  The kernel's basic initialization code is in assembly.  On 40
>>different platforms.  That's pretty complex in terms of kernel code,
>>which is 99.998% C.
> 
> 
> No, the kernel initialization is not complex at all.  complexity != code size
> 

I was more pointing out that it was assembler code.  Clean and simple as
it may be, you come back in 10 years and try to maintain it.

> 
>>Which brings us to a point on (1) and (2).  You and others continue to
>>pretend that SEGMEXEC is the only NX emulation in PaX.  I should remind
>>you (again) that PAGEEXEC uses the same method that Exec Shield uses
>>since I believe kernel 2.6.6.  In the cases where this method fails, it
>>falls back to kernel-assisted MMU walking, which can produce potentially
>>high overhead.
> 
> 
> You stated that a few time.  Now let's welcome you to reality:
> 
>  - Linus doesn't want to make the tradeoffs for segment based NX-bit
>    emulation in mainline at all

It's an option, set in menuconfig.  It's not a forced trade-off, so
integrating it (btw I wasn't and am not currently arguing to get PaX
integrated) wouldn't really force a trade-off on the user.

Back to the above, this argument doesn't cover page-based NX-bit emulation.

>  - Ingo and his collegues at Red Hat want to have it, but they don't
>    want to break application nor introduce the addition complexity
>    of the PaX code.
> 

Nor guarantee that the NX emulation is actually durable.

> Is is that hard to understand?
> 
> 

What's hard to understand is the constant banter about SEGMEXEC when
there's a second mode AND when it's completely optional.  Are you trying
to make it sound like you're pretending that PaX isn't innovative and
that the trade-offs are obscene and infeasible in an every-day
environment?  Why is PAGEEXEC ignored in every argument, and SEGMEXEC
focused on, when one or both can be disabled so that the VM split goes away?

Could it be that you can't argue against PAGEEXEC because it uses the
exact same method that Exec Shield uses, and falls back to a heavier one
when that fails; yet you argue that Exec Shield shouldn't fail except in
extremely rare cases, so you can't hold the possibly heavy-overhead case
in PAGEEXEC to question without invalidating your own arguments?

What's wrong with PAGEEXEC?  Why focus on SEGMEXEC?

The only thing I ever complain about concerning Exec Shield's principle
implementation is that it can fail in certain conditions.  the
deployment side (PT_GNU_STACK and automated marking) I don't even know
why I touched on; perhaps I should try to separate ES from RedHat's
overall smoke-and-mirrors approach to security, since ES at least
supplies a partially functional and reciprocating NX-ASLR proteciton.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8CGphDd4aOud5P8RAlq/AJ40TYCxoUMi2PsWvZz/BqHsugEnuQCeL5iC
y2Ot5pTwi+1dbPKN+6WYU4k=
=Weu3
-----END PGP SIGNATURE-----
