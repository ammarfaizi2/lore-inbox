Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271694AbRIGK7r>; Fri, 7 Sep 2001 06:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271693AbRIGK7i>; Fri, 7 Sep 2001 06:59:38 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:8708 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S271692AbRIGK73>;
	Fri, 7 Sep 2001 06:59:29 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200109071059.MAA23146@nbd.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <m2y9nrn7p0.fsf@sympatico.ca> "from Bill Pringlemeir at Sep 6, 2001
 08:52:27 pm"
To: Bill Pringlemeir <bpringle@sympatico.ca>
Date: Fri, 7 Sep 2001 12:58:25 +0200 (CEST)
CC: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Bill Pringlemeir wrote:"
> Otherwise, I think we have independently came up with the same thing
> and the `error' throwing can of course be changed to whatever.

If you are interested, the last version I had is the following. The
compile_time_assert is linus' idea. We had an illegal assembler
statement there originally, containing the line number and the
error statement. One or the other will do until gcc gets the
__builtin_ct_assert() function.

#define compile_time_assert(x) \
                do { switch (0) { case 0: case (x) != 0: ; } } while (0)

#define __MIN(x,y) ({\
   typeof(x) _x = x; \
   typeof(y) _y = y; \
   _x < _y ? _x : _y ; \
 })
#define MIN(x,y) ({\
   const typeof(x) _x = ~(typeof(x))0; \
   const typeof(y) _y = ~(typeof(y))0; \
   compile_time_assert(sizeof(_x) == sizeof(_y));\
   compile_time_assert( (_x > (typeof(x))0 && _y > (typeof(y))0) \
                    ||  (_x < (typeof(x))0 && _y < (typeof(y))0)); \
   __MIN(x,y); \
 })

Peter
