Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281914AbRKUPmS>; Wed, 21 Nov 2001 10:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281909AbRKUPmK>; Wed, 21 Nov 2001 10:42:10 -0500
Received: from sun.fadata.bg ([80.72.64.67]:13062 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S281910AbRKUPlz>;
	Wed, 21 Nov 2001 10:41:55 -0500
To: Andreas Schwab <schwab@suse.de>
Cc: root@chaos.analogic.com, Jan Hudec <bulb@ucw.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
In-Reply-To: <Pine.LNX.3.95.1011121085737.21389A-100000@chaos.analogic.com>
	<jelmh09nkt.fsf@sykes.suse.de>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <jelmh09nkt.fsf@sykes.suse.de>
Date: 21 Nov 2001 17:48:25 +0200
Message-ID: <87u1voyvjq.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andreas" == Andreas Schwab <schwab@suse.de> writes:

Andreas> "Richard B. Johnson" <root@chaos.analogic.com> writes:
Andreas> |> On Wed, 21 Nov 2001, Jan Hudec wrote:
Andreas> |> 
Andreas> |> > > >     *a++ = byte_rev[*a]
Andreas> |> > > It looks perferctly okay to me. Anyway, whenever would you listen to a
Andreas> |> > > C++ book talking about good C coding :p
Andreas> |> > 
Andreas> |> 
Andreas> |> It's simple. If any object is modified twice without an intervening
Andreas> |> sequence point, the results are undefined. The sequence-point in
Andreas> |> 
Andreas> |> 	*a++ = byte_rev[*a];
Andreas> |> 
Andreas> |> ... is the ';'.
Andreas> |> 
Andreas> |> So, we look at 'a' and see if it's modified twice.

Andreas> No, the rule much stricter. 

Andreas>          -- Between two sequence points, an object is modified more
Andreas>             than once, or  is  modified  and  the  prior  value  is
Andreas>             accessed other than to determine the value to be stored
Andreas>             (6.5).

Hmm, I guess some context is missing here. Let's make it

      Between the previous and next sequence point an object shall
      have its stored value modified at most once by the evaluation of
      an expression. Furthermore, the prior value shall be accessed
      only to determine the value to be stored.

So, the above ``*a++ = byte_rev[*a]'' is undefined, because the value
of ``a'' is accessed other than to determine the value to be stored in
``a'' (as Andreas pointed out).  The side effect of ``a++'' can take
place anywhere before the next sequence point (``;''), that's before
or after the array access, i.e. the statement can be evaluated as

       tmp = *a;
       *a++ = byte_rev[tmp];

 or as 

       tmp = *(a+1);
       *a++ = byte_rev [tmp];

Regards,
-velco

