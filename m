Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUFVLw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUFVLw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 07:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUFVLw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 07:52:56 -0400
Received: from web41105.mail.yahoo.com ([66.218.93.21]:17196 "HELO
	web41105.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262425AbUFVLwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 07:52:54 -0400
Message-ID: <20040622115253.79308.qmail@web41105.mail.yahoo.com>
Date: Tue, 22 Jun 2004 04:52:53 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: Re: RSA
To: linux-kernel@vger.kernel.org
In-Reply-To: <BAY16-F15pyLAPDVXLu000036f9@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- kartikey bhatt <kartik_me@hotmail.com> wrote:
> hey i am gonna look at the code right now.
> will keep in touch.
> 
> "Tom has indicated a few ways to go about this which I will send
> you."
> waiting for details.

Um to clear up something here.  Joy and Serge are going to be the
developers on this module.  I'm just helping out where I can with my
knowledge of crypto/math/LibTom internals.  

Specifically a good starting place is to rip "mpi.c" out of LibTomCrypt
and start stripping it down.  You don't need things like the
Karatsuba/Toom-Cook multipliers, Jacobi symbol, various prime functions
[next_prime, fermat testing, etc].  You won't need the diminished radix
and Barrett reduction algorithms, etc, etc, etc.

In a recent project [see my C.V. for details] I managed to get a
"optimized for size" mpi.c down from 29KB to 5KB on an x86 with GCC.

Naturally this won't be that small since you want to leave in things
like the Comba mult/sqr algorithms and the full exptmod routine.  But
definitely around 7-10KB is possible on the x86.  

Then of course you have the RSA routines on top of that.  Depending on
whether you need PKCS #1 v2 or v1.5 you can do one of two things.  I
have both v2 and v1.5 padding in LibTomCrypt [and specifically in the
v0.97 release I reduced the stack usage to way south of 4KB].  So if
you're using v1.5 you'll have to write your own rsa encrypt/sign code
[I have a key-gen and CRT optimized exptmod you can rip off].  

On the plus side all of my code is ISO C portable, thread safe and well
tested [been used by quite a few people].  There are enough goodies in
LibTomCrypt to make this happen and you're all entitled to
rip/relicense as required ;-)

Tom


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
