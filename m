Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272585AbRHaCKX>; Thu, 30 Aug 2001 22:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272588AbRHaCKN>; Thu, 30 Aug 2001 22:10:13 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:26123 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272585AbRHaCKC>;
	Thu, 30 Aug 2001 22:10:02 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108310210.f7V2AGT27175@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108310119.f7V1Jws18144@oboe.it.uc3m.es> from "Peter T. Breuer"
 at "Aug 31, 2001 03:19:58 am"
To: ptb@it.uc3m.es
Date: Fri, 31 Aug 2001 04:10:16 +0200 (MET DST)
CC: gordo@pincoya.com, "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer wrote:"
> "Gordon Oliver wrote:"
> >     - if the sizeof the arguments is different, it is a bug to have
> >       the _larger_ argument unsigned.
> 
> This can't be caught at compile time.

Oops - I misinterpreted what you said. You mean "longer", not "larger".
Yes, this can be caught by a variant of the solution I proposed ...

   typeof(x) _x = ~(typeof(x))0;
   typeof(y) _y = ~(typeof(y))0;
   ...
   if (sizeof(_x) > sizeof(_y) && _x > 0)
       BUG();
   if (sizeof(_x) < sizeof(_y) && _y > 0)
       BUG();

Though I'm too sleepy to think about why there's a bug in this case ...
Isn't it only a bug if the longer arg is unsigned and the shorter is
signed? (I suppose the shorter is promoted with sign and then converted
to unsigned but I'm not going to get up and open a book to find out ..).

That would be:

   if (sizeof(_x) > sizeof(_y) && _x > 0 && _y < 0)
       BUG();
   if (sizeof(_x) < sizeof(_y) && _y > 0 && _x < 0)
       BUG();

Moral, always use ints.

Peter
