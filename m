Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSGSTub>; Fri, 19 Jul 2002 15:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316994AbSGSTub>; Fri, 19 Jul 2002 15:50:31 -0400
Received: from mail.starbak.net ([63.144.91.12]:50698 "EHLO mail.starbak.net")
	by vger.kernel.org with ESMTP id <S316957AbSGSTuU>;
	Fri, 19 Jul 2002 15:50:20 -0400
Message-ID: <000e01c22f5c$dce9c600$da5b903f@starbak.net>
From: "Joseph Malicki" <jmalicki@starbak.net>
To: "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>,
       "Lars Marowsky-Bree" <lmb@suse.de>
Cc: "Patrick J. LoPresti" <patl@curl.com>, <linux-kernel@vger.kernel.org>
References: <200207182347.g6INlcl47289@saturn.cs.uml.edu> <s5gsn2fr922.fsf@egghead.curl.com> <015401c22f40$c4471380$da5b903f@starbak.net> <s5gvg7bmu43.fsf@egghead.curl.com> <20020719192524.GY12420@marowsky-bree.de> <20020719193059.GD2718@conectiva.com.br>
Subject: Re: close return value
Date: Fri, 19 Jul 2002 15:45:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's an issue when it MIGHT be important.  Such as, fprintf to an important
data file should be checked, fprintf to stderr is usually cool not to check.

People are going on the assumption that ignoring an error to a system call
will interfere with program operation or corrupt data - which is NOT
necessarily true.  Sure many people write programs that way.  But it is
quite often that if something fails, you don't particularly care, and you
know, with certainty, that it does not materially affect the operation of
your program.  For instance, should shutdown fail just because it couldn't
write a message to everyone's console?  That would be wonderful.
Administrator wants to shut down system because it is broken - but since a
programmer follows your mantras, the system CANNOT
successfully shutdown anyway because then it wouldn't be "reliable".

-joe

----- Original Message -----
From: "Arnaldo Carvalho de Melo" <acme@conectiva.com.br>
To: "Lars Marowsky-Bree" <lmb@suse.de>
Cc: "Patrick J. LoPresti" <patl@curl.com>; "Joseph Malicki"
<jmalicki@starbak.net>; <linux-kernel@vger.kernel.org>
Sent: Friday, July 19, 2002 3:30 PM
Subject: Re: close return value


> Em Fri, Jul 19, 2002 at 09:25:24PM +0200, Lars Marowsky-Bree escreveu:
> > On 2002-07-19T14:48:44,
> >    "Patrick J. LoPresti" <patl@curl.com> said:
> >
> > > Of course, checking errors in order to handle them sanely is a good
> > > thing.  Nobody is arguing that.  What I am arguing is that failing to
> > > check errors when they can "never happen" is wrong.
> >
> > Actually, checking for _all_ even remotely possible and checkable error
> > conditions (if the check doesn't incur an intolerable overhead) is a
very very
> > important requirement for writing high quality code; even if it isn't
"fault
>
> If the function is not to be checked for errors, lets make it return void
and
> be done with it. There are few _exceptions_, but one has to understand the
> meaning of that word 8)
>
> - Arnaldo
>

