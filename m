Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272708AbRIGPSf>; Fri, 7 Sep 2001 11:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272712AbRIGPSZ>; Fri, 7 Sep 2001 11:18:25 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:14852 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272708AbRIGPSR>;
	Fri, 7 Sep 2001 11:18:17 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200109071518.RAA28419@nbd.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <m21ylj3w02.fsf@sympatico.ca> "from Bill Pringlemeir at Sep 7, 2001
 10:39:57 am"
To: Bill Pringlemeir <bpringle@sympatico.ca>
Date: Fri, 7 Sep 2001 17:17:17 +0200 (CEST)
CC: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bill Pringlemeir wrote:"
>       compile_time_assert( (_x - 1 > 0 && _y - 1 > 0) \
>                        ||  (_x - 1 < 0 && _y - 1 < 0)); \
> 
> This should prevent all cases where the __MIN(x,y) macro can screw up
> due to sign issues (on that machine).  If you do this, the `sizeof'

Eh? "0" is a signed integer constant. So your comparisons force promotion
to int when x is smaller size. I'm not sure what type 

     "unsigned foo - signed int"

would have either!  It seems to me that you are making things very
murky, which is precisely what you want to avoid.

> check isn't needed.  A MIN(int, long) etc should probably be ok.  The
> only caveats are the promotion in the __MIN itself create a sign
> mismatch.
> 
> However, if the `sizeof' check remains, then you don't have to worry
> about this and both versions are equivalent.  Some other things to
> worry about is what if the type is already const?  Maybe that works...

No parsum.

> What if you try `MIN(x,_x);'.  I think that this is something that
> David took care of in the "3 arg min".

You can't take care of it. A macro is always vulnerable to name
clashes.


Peter
