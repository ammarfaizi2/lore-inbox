Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268045AbTB1SZt>; Fri, 28 Feb 2003 13:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268051AbTB1SZt>; Fri, 28 Feb 2003 13:25:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:36494 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268045AbTB1SZs>; Fri, 28 Feb 2003 13:25:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH 3/8] dm: prevent possible buffer overflow in ioctl interface
Date: Fri, 28 Feb 2003 12:31:27 -0600
X-Mailer: KMail [version 1.2]
Cc: Joe Perches <joe@perches.com>, "LKML" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>
References: <200302281814.h1SIEB42005202@eeyore.valparaiso.cl>
In-Reply-To: <200302281814.h1SIEB42005202@eeyore.valparaiso.cl>
MIME-Version: 1.0
Message-Id: <0302281231270D.05199@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 February 2003 12:14, Horst von Brand wrote:
> Kevin Corry <corryk@us.ibm.com> said:
> > Also, the "+1" is still necessary, even if we switch to sizeof. The
> > sprintf call that follows copies DM_DIR, followed by a slash, followed by
> > the name from the hash table into the allocated string. The "+1" is for
> > the slash in the middle. The terminating NULL character is accounted for
> > in
> > DM_NAME_LEN.
>
> Then it was broken before.
>
> sizeof("1234") == strlen("1234") + 1 == 5

Hmmm...wasn't aware of that. I guess I never expected there to be a 
difference. If that's the case, then Joe Perches' earlier patch should do the 
trick, albiet for obscure reasons.

And I wouldn't say it was broken the other way; it was simply allocating one 
byte more than necessary.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
