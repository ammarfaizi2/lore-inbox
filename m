Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVG1LFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVG1LFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 07:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVG1LFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 07:05:51 -0400
Received: from ns.firmix.at ([62.141.48.66]:51114 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S261376AbVG1LFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 07:05:47 -0400
Subject: Re: [PATCH] signed char fixes for scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: Paulo Marques <pmarques@grupopie.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, Sam Ravnborg <sam@ravnborg.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42E8B60C.9070703@grupopie.com>
References: <1121465068l.13352l.0l@werewolf.able.es>
	 <1121465683l.13352l.5l@werewolf.able.es>
	 <20050727202757.GB31180@mars.ravnborg.org>
	 <1122507398l.19829l.0l@werewolf.able.es>  <42E8AD47.6010501@grupopie.com>
	 <1122545777.16156.59.camel@tara.firmix.at>  <42E8B60C.9070703@grupopie.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 28 Jul 2005 13:05:28 +0200
Message-Id: <1122548728.16156.70.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 11:40 +0100, Paulo Marques wrote:
[...]
> You're comming really late in this thread :)

Well, the same issue arised recently somewhere else too on this list and
lots of C programmers (not only beginners) don't know about the 3 char
types as speficied in the C standard.
[ The C standard may have got problems recently with the real world
usinf UTF-8 for a printable character but this must be solved
elsewhere. ]

> The problem is that "sym" isn't really a string. It starts out as a 
> string, but as the compression scheme begins to work it just becomes a 
> "bunch of bytes" using all the values in the range 0-255 for which 
> unsigned char is the perfect type.
> 
> Since only the loading of the symbols use string functions, and all the 
> compression process treats these as bytes, it seemed better to treat 
> them as unsigned chars and just typecast the first few uses.

ACK.

> The union suggested by J.A.Magallon might be a reasonable solution, but 

Syntactically yes. Conceptually no IMHO. sizeof(char) must be ==
sizeof(unsigned char) and must have the same alignment. So a cast seems
to be the simpler and cleaner solution.

> we only need 4 casts in the 500 lines of code of scripts/kallsyms.c to 
> solve all problems, so this seems really overkill.
> 
> >>Is my compiler version the problem (3.3.2), or are you testing with the 
> > 
> > Compiler version - zse gcc-4.*.
> 
> Yes, I know J.A.Magallon is trying to silence the warnings of gcc 4.0, 
> but as I understood it, gcc 3 would also complain of the same problems 
> if -Wsign-compare were specified. It was just that gcc4 would complain 
> even without -Wsign-compare.

AFAIK applies -Wsign-compare in gcc-3 only to pure compares (<, >, ...)
and not assignments/passed parameters too.

> So the question is: is gcc4 complaining about signedness problems that 
> gcc3 doesn't, even with -Wsign-compare?
> 
> Now that I look at the source, I can see that it must be complaining! 
> There are still 3 calls to strcmp that use sym directly, and gcc3 
> doesn't say a thing.

As above - this will probably be silently promoted by gcc-3.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

