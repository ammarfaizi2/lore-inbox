Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312586AbSCZRNt>; Tue, 26 Mar 2002 12:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSCZRNk>; Tue, 26 Mar 2002 12:13:40 -0500
Received: from palrel13.hp.com ([156.153.255.238]:54192 "HELO palrel13.hp.com")
	by vger.kernel.org with SMTP id <S312586AbSCZRNi> convert rfc822-to-8bit;
	Tue, 26 Mar 2002 12:13:38 -0500
From: "Jim Hollenback" <jholly@cup.hp.com>
Message-Id: <1020326091332.ZM13559@fry.cup.hp.com>
Date: Tue, 26 Mar 2002 09:13:31 -0800
In-Reply-To: Balbir Singh <balbir_soni@yahoo.com>
        "Re: readv() return and errno" (Mar 26,  9:01am)
X-Mailer: Z-Mail (5.0.0 30July97)
To: Balbir Singh <balbir_soni@yahoo.com>, Andries.Brouwer@cwi.nl,
        jholly@cup.hp.com, plars@austin.ibm.com
Subject: Re: readv() return and errno
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't seem confusing at all.

RETURN VALUE
       On  success  readv  returns  the number of bytes read.  On
       success writev returns the number of  bytes  written.   On
       error, -1 is returned, and errno is set appropriately.

ERRORS
       EINVAL An  invalid  argument was given. For instance count

             might be greater than MAX_IOVEC, or zero.  fd could
              also  be  attached to an object  which  is  unsuit-
              able  for  reading  (for  readv)  or  writing  (for
              writev).

I don't see much in the way of waffle words. If count is greater than
MAX_IOVEC or zero you get EINVAL. I suppose your next argument is if
count exceeds MAX_IOVEC a return of 0 is okay since, hopefully, nothing
was read? Where do you read a non-error return of zero is acceptable
for count of 0? I states EINVAL for a count of 0.

If your going to rework the manpage, then drop a count of 0 as an error,
otherwise fix the kernel with the trival patch.

Jim


On Mar 26,  9:01am, Balbir Singh wrote:
> Subject: Re: readv() return and errno
> I agree it is not a big thing at all, zero not
> returning any error. Yes! I read and understood the
> MAY return an error, it makes complete sense.
>
> I agree, the Linux man pages need a lot of work,
> if they are going to be even close to reflecting
> some of things in the kernel.
>
>
> Thanks,
> Balbir
>
> --- Andries.Brouwer@cwi.nl wrote:
> > Jim Hollenback wrote:
> >
> > > According to readv(2) EINVAL is returned for an
> > invalid
> > > argument.
> >
> > Right.
> >
> > > The examples given were count might be greater
> > than
> > > MAX_IOVEC or zero.
> >
> > Wrong, or at least confusingly phrased.
> >
> >
> > In the good old days, a man page described what the
> > system did,
> > and the ERRORS section gave the reasons for the
> > possible error
> > returns.
> > These days a man page describes a function present
> > on many
> > Unix-like systems, and not all systems have
> > precisely the
> > same behaviour. POSIX man pages therefore
> > distinguish under
> > ERRORS the two possibilities "if foo then this error
> > must be
> > returned", and "if foo then this error may be
> > returned".
> >
> > Linux man pages do not (yet) make this distinction -
> > adding this is a lot of careful work, and so far
> > nobody is doing this [hint..].
> > In other words, the ERRORS section in Linux man
> > pages is
> > to be interpreted as "if foo then this error may be
> > returned".
> >
> > Note that it may not be desirable at all to do
> > things that way,
> > there is no need for kernel patches, it just means
> > that systems
> > exist with this behaviour, so that authors of
> > portable programs
> > must take this into account.
> >
> > Balbir Singh wrote:
> >
> > > Apply this trivial patch, if you want the required
> > behaviour
> >
> > But the behaviour is not required.
> > Paul Larson makes the same mistake.
> >
> > Andries
>
>
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Movies - coverage of the 74th Academy Awards®
> http://movies.yahoo.com/
>-- End of excerpt from Balbir Singh


