Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316864AbSGSQJX>; Fri, 19 Jul 2002 12:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316882AbSGSQJX>; Fri, 19 Jul 2002 12:09:23 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:13821 "EHLO
	egghead.curl.com") by vger.kernel.org with ESMTP id <S316864AbSGSQJV>;
	Fri, 19 Jul 2002 12:09:21 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: close return value
References: <200207182347.g6INlcl47289@saturn.cs.uml.edu>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 19 Jul 2002 12:12:21 -0400
In-Reply-To: <200207182347.g6INlcl47289@saturn.cs.uml.edu>
Message-ID: <s5gsn2fr922.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> You check printf() and fprintf() then? Like this?
> 
> ///////////////////////////////////////////
> void err_print(int err){
>   const char *msg;
>   int rc;
> 
>   msg = strerror(err);
>   if(!msg) err_print(errno);
> 
>   do{
>     rc = fprintf(stderr,"Problem: %s\n",msg);
>   }while(rc<0 && errno==EINTR);
>   if(rc<0) err_print(errno);
> }
> ///////////////////////////////////////////

Wow, I hardly know where to begin.

I could point out that, at least according to my man page, fprintf()
returns the number of characters printed; it tells you nothing about
errors.  Also, fprintf() is a library funciton, not a system call, so
you cannot expect it to put anything meaningful in errno.  (I am not
sure whether these mistakes were part of your sarcasm or your
ignorance.)

Or I could ask, what part of "assertion failure" did you not
understand?  Yes, the code above is idiotic.  But checking that
fprintf() did not return zero, and calling abort() otherwise, is often
the right thing to do.

Yes, I exaggerated.  There are times when you can reasonably skip
checking a system call for errors; namely, when you have coded
defensively enough that any error can do no harm.  If you can show
that the rest of your program operates correctly whether the call
succeeded or not, then you can skip the error check.

But my main point still holds: You should *not* skip error checks
because you "know" that the error is "impossible".  It takes little
experience with real-world systems to learn that the "impossible"
happens with alarming frequency.  And when it does, aborting
immediately is much better than proceeding, because your subsequent
code is unpredictable and therefore dangerous when your assumptions
have been violated.

Once you have taken the hit of making a system call, the additional
cost of checking the return value is irrelevant.  So do yourself and
your users a favor and add the checks.

> Get off your high horse.

Actually, I would rather give others a lift to join me.  The view is
pretty good from up here.

 - Pat
