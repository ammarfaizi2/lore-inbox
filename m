Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132888AbRDENIO>; Thu, 5 Apr 2001 09:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132889AbRDENID>; Thu, 5 Apr 2001 09:08:03 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:45577 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132888AbRDENHo>;
	Thu, 5 Apr 2001 09:07:44 -0400
Date: Thu, 5 Apr 2001 09:06:20 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
To: =?iso-8859-1?Q?Sarda=F1ons=2C_Eliel?= 
	<Eliel.Sardanons@philips.edu.ar>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: asm/unistd.h
In-Reply-To: <A0C675E9DC2CD411A5870040053AEBA0284170@MAINSERVER>
Message-ID: <Pine.LNX.4.30.0104050901500.13496-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, Sardañons, Eliel wrote:

> I'm taking a look at the linux code and I don't understand how do you
> programm...mmm (?) may be i'm a stupid why in include/asm/unistd.h in some
> macros you use this:
>
> do {
> ...
> } while (0)

This is a very useful trick.

If you define a macro such as:

#define foo(x) do_one(x); do_two(x); do_three(x)

you may later be compelled to call it in an if statement:

if(condition)
  foo(something);

note that it would not do what you want as it will only execute do_one(x)
conditionally but do_two(x) and do_three(x) would always be done.

However a do{ ... } while(0) is a nice convenient block which is
guaranteed to execute once.  The compiler (with a -O flag) will not
generate any extra code for the do{}while(0) so its just a macro building
aid.

So you ask: "why not just use a { ... } to define a macro".  I don't
remember the case for this but I know it's there.  It has to do with a
complicated if/else structure where a simple {} breaks.

Cheers,
Bart.


-- 
	WebSig: http://www.jukie.net/~bart/sig/


