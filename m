Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272537AbRH3WmU>; Thu, 30 Aug 2001 18:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272539AbRH3WmK>; Thu, 30 Aug 2001 18:42:10 -0400
Received: from egghead.curl.com ([216.230.83.4]:21252 "HELO egghead.curl.com")
	by vger.kernel.org with SMTP id <S272537AbRH3Wlw>;
	Thu, 30 Aug 2001 18:41:52 -0400
From: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108300902570.7973-100000@penguin.transmeta.com> <200108301638.SAA04923@nbd.it.uc3m.es>
Date: 30 Aug 2001 18:42:10 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/200108301638.SAA04923@nbd.it.uc3m.es>
Message-ID: <s5gheup6ugt.fsf@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" <ptb@it.uc3m.es> writes:

> "Linus Torvalds wrote:"
> > What if the "int" happens to be negative?
> 
>    if sizeof(typeof(a)) != sizeof(typeof(b)) 
>        BUG() // sizes differ
>    const (typeof(a)) _a = ~(typeof(a))0   
>    const (typeof(b)) _b = ~(typeof(b))0   
>    if _a < 0 && _b > 0 || _a > 0 && b < 0
>        BUG() // one signed, the other unsigned
>    standard_max(a,b)

This is a MUCH nicer solution.  max() is a well-defined mathematical
concept; it is simply the larger of its two arguments, period.  It is
C's *promotion* rules that kill you, especially signed->unsigned
promotion.  So just forbid them, at least when they implicit.

You can argue about whether the "differing sizes" case should be a
BUG(), since the output will still be mathematically correct.  It
depends on how often it is useful to compare (say) unsigned chars
against ints, and on whether the compiler warns about cases where you
try to stuff the return value into a too-small container.  I bet that
just forbidding signed->unsigned promotion would be enough.

In general, types should work for the programmer, not the other way
around.  Force people to "think hard" about their types when they are
making a likely mistake, not *every* time they call max().

Littering all those calls with types is just gross.

 - Pat
