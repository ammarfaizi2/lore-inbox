Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUGGLKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUGGLKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 07:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUGGLKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 07:10:32 -0400
Received: from web41111.mail.yahoo.com ([66.218.93.27]:6741 "HELO
	web41111.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265031AbUGGLK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 07:10:29 -0400
Message-ID: <20040707111028.82649.qmail@web41111.mail.yahoo.com>
Date: Wed, 7 Jul 2004 04:10:28 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040707030029.GD12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Jul 06, 2004 at 05:06:12PM -0700, tom st denis wrote:
> > --- David Eger <eger@havoc.gtf.org> wrote:
> > > Is there a reason to add the 'L' to such a 32-bit constant like
> this?
> > > There doesn't seem a great rhyme to it in the headers...
> > 
> > IIRC it should have the L [probably UL instead] since numerical
> > constants are of type ``int'' by default.  
> > 
> > Normally this isn't a problem since int == long on most platforms
> that
> > run Linux.  However, by the standard 0xdeadbeef is not a valid
> unsigned
> > long constant.
> 
> ... and that would be your F for C101.  Suggested remedial reading
> before
> you take the test again: any textbook on C, section describing
> integer
> constants; alternatively, you can look it up in any revision of C
> standard.
> Pay attention to difference in the set of acceptable types for
> decimal
> and heaxdecimal constants.

You're f'ing kidding me right?  Dude, I write portable ISO C source
code for a living.  My code has been built on dozens and dozens of
platforms **WITHOUT** changes.  I know what I'm talking about.

0x01, 1 are 01 all **int** constants.

On some platforms 0xdeadbeef may be a valid int, in most cases the
compiler won't diagnostic it.  splint thought it was worth mentioning
which is why I replied.

In fact GCC has odd behaviour.  It will diagnostic

char x = 0xFF;

and

int x = 0xFFFFFFFFULL;

But not 

int x = 0xFFFFFFFF;

[with --std=c99 -pedantic -O2 -Wall -W]

So I'd say it thinks that all of the constants are "int".  In this case
0xFF is greater than 127 [max for char] and 0xFFFFFFFFFFULL is larger
than max for int.  in the 3rd case the expression is converted
implicitly to int before the assignment is performed which is why there
is no warning.

Before you step down to belittle others I'd suggest you actually make
sure you're right.  

Tom


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
