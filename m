Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVBAJpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVBAJpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVBAJpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 04:45:07 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:61146 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261936AbVBAJox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 04:44:53 -0500
From: Peter Busser <busser@m-privacy.de>
Organization: m-privacy
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Date: Tue, 1 Feb 2005 10:44:39 +0100
User-Agent: KMail/1.7.1
References: <200501311015.20964.arjan@infradead.org> <200501311357.59630.busser@m-privacy.de> <1107189699.4221.124.camel@laptopd505.fenrus.org>
In-Reply-To: <1107189699.4221.124.camel@laptopd505.fenrus.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502011044.39259.busser@m-privacy.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 January 2005 17:41, you wrote:
> On Mon, 2005-01-31 at 13:57 +0100, Peter Busser wrote:
> > Hi!
> >
> > > I'm not entirely happy yet (it shows a bug in mmap randomisation) but
> > > it's way better than what you get in your tests (this is the
> > > desabotaged
> > > 0.9.6 version fwiw)
> ok the paxtest 0.9.5 I downloaded from a security site (not yours) had
> this gem in:

So what does 0.9.5 have to do with 0.9.6?

> --- paxtest/body.c
> +++ paxtest-0.9.5/body.c        2005-01-18 17:30:11.000000000 +0100
> @@ -29,7 +29,6 @@
>         fflush( stdout );
>
>         if( fork() == 0 ) {
> +               do_mprotect((unsigned long)argv & ~4095U, 4096,
> PROT_READ|PROT_WRITE|PROT_EXEC);
>                 doit();
>         } else {
>                 wait( &status );
>
> which is clearly there to sabotage any segmentation based approach (eg
> execshield and openwall etc); it cannot have any other possible use or
> meaning.

Ah, so you are saying that I sabotaged PaXtest? Sorry to burst your bubble, 
but the PaXtest tests are no real attacks. They are *simulated* attacks. The 
do_mprotect() is there to *simulate* behaviour people found in GLIBC under 
certain circumstances. In other words: This is how certain applications 
behave when run on exec-shield. They complained that PaXtest showed 
inaccurate results on exec-shield. Since the purpose of PaXtest is to show 
accurate results, the lack thereof has been fixed.

> the paxtest 0.9.6 that John Moser mailed to this list had this gem in
> it:
> @@ -39,8 +42,6 @@
>          */
>         int paxtest_mode = 1;
>
> +       /* Dummy nested function */
> +       void dummy(void) {}
>
>         mode = getenv( "PAXTEST_MODE" );
>         if( mode == NULL ) {
>
>
> which is clearly there with the only possible function of sabotaging the
> automatic PT_GNU_STACK setting by the toolchain (which btw is not fedora
> specific but happens by all new enough (3.3 or later) gcc compilers on
> all distros) since that requires an executable stack.

Again, this is a *simulation* of the way real-life applications could interact 
with the underlying system. Again people complained that the results shown 
were not accurate. And that has been fixed.

I am well aware of complaints by some people about this behaviour. That is why 
there is a separated kiddie and blackhat mode in the latest PaXtest version. 
The kiddie mode is for those people who prefer to feel warm and cozy and the 
blackhat mode is for those who want to find out what the worst-case behaviour 
is. So if you don't like the blackhat results, don't run that test!

> Now I know you're a honest and well meaning guy and didn't put those
> sabotages in, and I did indeed not get paxtests from your site directly,
> so they obviously must have been tampered with, hence me calling it de-
> sabotaging when I fixed this issue (by moving the function to not be
> nested).

No, these things are also in the officially released sources. I put them in 
myself in fact.

Interesting. So you are saying that even though applications sometimes use 
mprotect(), either directly or indirectly through GLIBC (such as 
multithreaded applications), and there are applications in the wild which use 
nested functions, that PaXtest should not use these to simulate those kinds 
of applications. Well, that is an opinion. A strange opinion. Does that mean 
you ``desabotage'' all other applications on this planet as well? Or is 
PaXtest perhaps special, because it tells people what really goes on?

My opinion is that PaXtest is correctly showing the consequences of the design 
decisions you and other people who hacked exec-shield made. These 
consequences are nowhere documented. So PaXtest is the only source for people 
to find out about them. It seems to me that you would rather not have people 
find out about it. It looks like you would rather prefer to cowardly kill the 
messenger than to stand up for the design decisions you made, like a real man 
would.

If that is the kind of person who you really are, then you have just managed 
to disappoint me. If you'd knew me, you'd know that that is quite an 
accomplishment. And frankly speaking, I don't think I would be happy with 
this if I were your employer. Since this kind of negative behaviour also 
reflects on the company you represent.

Anyways, I now know enough about this and I'm done wasting my time on this 
childish discussion. If you, or anyone else for that matter, has complaints 
about PaXtest or patches to improve it, please let me know. Otherwise I 
suggest to leave me alone and to try to pick someone half your size to bully 
around next time.

Groetjes,
Peter.
