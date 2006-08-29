Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWH2I0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWH2I0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWH2I0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:26:43 -0400
Received: from web25222.mail.ukl.yahoo.com ([217.146.176.208]:1370 "HELO
	web25222.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750808AbWH2I0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:26:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=twN2TkSrtHumayzwHpHQ0LHjFzNF6n/wLxAjET3pQp0Y5HWgiqWZxDDqxvFjnITJkb1OcCaUmqCOiY5JAXkxB2rjWYmkmlKdhb5Us4jbr5dZJfblr9uo7qAGuXDiFlLRSIyiixHChIR1Ty5l0igkJNXX0+JtX2A8RY2qhfKBMUs=  ;
Message-ID: <20060829082641.48020.qmail@web25222.mail.ukl.yahoo.com>
Date: Tue, 29 Aug 2006 10:26:41 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060828203514.GC6728@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Sat, Aug 26, 2006 at 12:56:36PM +0200, Blaisorblade wrote:
> > Can anybody explain me how can we use REGPARM if we have to link
> with host 
> > glibc?

> Umm, yeah, good point.  This regparam behavior is different from
> the old
> behavior, where regparam functions had to be declared as such.

And which can still be enabled - I think fastcall is for this, and it
is still useful.

However more useful is to move many wrappers where this is possible
to headers (for instance the ones calling just
CHOOSE_MODE($me_tt,$me_skas) - moving them to headers is always
possible and saves a call).

> However, this is a potential problem with all regparam users, who
> all
> presumably use libc, so I'd imagine it works somehow.

For my knowledge, the only user is the non-UML Linux kernel, which
doesn't use libc :-).

And if you want to mix regparm and not regparm calls, you end up
marking it at a prototype level (i.e. with the old approach); GCC
could be smarter and allow specifying it at a per-header or per
header-folder level, but I do not think it does.

> > If we are going to use klibc instead of glibc that's ok (and this
> is not the 
> > case I'm talking about), but I do not know that plan (and nobody
> discussed 
> > the implications).

> I've been idly considering that, but it's no more than idle
> consideration
> right now.

Fine... it is actually a good idea for some points (we currently
refrain from using certain things, such as futexes, because our
tricks could conflict with glibc tricks which we don't know - with
klibc it would be different).
We'll see.

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
