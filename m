Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSGSQ24>; Fri, 19 Jul 2002 12:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSGSQ24>; Fri, 19 Jul 2002 12:28:56 -0400
Received: from mail.starbak.net ([63.144.91.12]:19460 "EHLO mail.starbak.net")
	by vger.kernel.org with ESMTP id <S316883AbSGSQ2z>;
	Fri, 19 Jul 2002 12:28:55 -0400
Message-ID: <015401c22f40$c4471380$da5b903f@starbak.net>
From: "Joseph Malicki" <jmalicki@starbak.net>
To: "Patrick J. LoPresti" <patl@curl.com>
Cc: <linux-kernel@vger.kernel.org>
References: <200207182347.g6INlcl47289@saturn.cs.uml.edu> <s5gsn2fr922.fsf@egghead.curl.com>
Subject: Re: close return value
Date: Fri, 19 Jul 2002 12:24:33 -0400
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

Those mistakes are your ignorance.  The manpage is wrong.  It does return -1
on error.
Also, errno is in libc, not the kernel.  Man library functions do in fact
use errno.

And it's not an issue of whether an error is "impossible".  It's whether or
not you would do
anything if it failed.  It's not totally uncommon to actually not care
whether or not it succeeds, but a valiant attempt is enough, such as in the
case of printf.

Sure, if you require an event to be successful to continue you should always
check it.  And yes, it's nice to print an error message on close sometimes,
if something is critical.  But the question to ask is what you would
actually _DO_ about an error... if the answer is nothing,
then why check it?

-joe


----- Original Message -----
From: "Patrick J. LoPresti" <patl@curl.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, July 19, 2002 12:12 PM
Subject: Re: close return value


> "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:
>
> > You check printf() and fprintf() then? Like this?
> >
> > ///////////////////////////////////////////
> > void err_print(int err){
> >   const char *msg;
> >   int rc;
> >
> >   msg = strerror(err);
> >   if(!msg) err_print(errno);
> >
> >   do{
> >     rc = fprintf(stderr,"Problem: %s\n",msg);
> >   }while(rc<0 && errno==EINTR);
> >   if(rc<0) err_print(errno);
> > }
> > ///////////////////////////////////////////
>
> Wow, I hardly know where to begin.
>
> I could point out that, at least according to my man page, fprintf()
> returns the number of characters printed; it tells you nothing about
> errors.  Also, fprintf() is a library funciton, not a system call, so
> you cannot expect it to put anything meaningful in errno.  (I am not
> sure whether these mistakes were part of your sarcasm or your
> ignorance.)
>
> Or I could ask, what part of "assertion failure" did you not
> understand?  Yes, the code above is idiotic.  But checking that
> fprintf() did not return zero, and calling abort() otherwise, is often
> the right thing to do.
>
> Yes, I exaggerated.  There are times when you can reasonably skip
> checking a system call for errors; namely, when you have coded
> defensively enough that any error can do no harm.  If you can show
> that the rest of your program operates correctly whether the call
> succeeded or not, then you can skip the error check.
>
> But my main point still holds: You should *not* skip error checks
> because you "know" that the error is "impossible".  It takes little
> experience with real-world systems to learn that the "impossible"
> happens with alarming frequency.  And when it does, aborting
> immediately is much better than proceeding, because your subsequent
> code is unpredictable and therefore dangerous when your assumptions
> have been violated.
>
> Once you have taken the hit of making a system call, the additional
> cost of checking the return value is irrelevant.  So do yourself and
> your users a favor and add the checks.
>
> > Get off your high horse.
>
> Actually, I would rather give others a lift to join me.  The view is
> pretty good from up here.
>
>  - Pat
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

