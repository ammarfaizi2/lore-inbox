Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132432AbRAZJYb>; Fri, 26 Jan 2001 04:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132176AbRAZJYU>; Fri, 26 Jan 2001 04:24:20 -0500
Received: from finch-post-11.mail.demon.net ([194.217.242.39]:28682 "EHLO
	finch-post-11.mail.demon.net") by vger.kernel.org with ESMTP
	id <S130970AbRAZJYM>; Fri, 26 Jan 2001 04:24:12 -0500
Date: Fri, 26 Jan 2001 09:24:12 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8 losing pages
Message-ID: <20010126092412.A508@colonel-panic.com>
Mail-Followup-To: pdh, linux-kernel@vger.kernel.org
In-Reply-To: <20010125231659.A2128@colonel-panic.com> <3A70DEF1.80ECEF80@baldauf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A70DEF1.80ECEF80@baldauf.org>; from xuan--lkml@baldauf.org on Fri, Jan 26, 2001 at 03:20:33AM +0100
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 03:20:33AM +0100, Xuan Baldauf wrote:
> 
> Peter Horton wrote:
> 
> > I'm experiencing repeatable corruption whilst writing large volumes of
> > data to disk. Kernel version is 2.4.1-pre8, on an 850MHz AMD Athlon on an
> > ASUS A7V (VIA KT133 chipset) motherboard 128M RAM (tested with 'memtest86'
> > for 10 hours).
> >
> 
> So what output does following bash script produce?
> 

Well this is the script I've been testing with ...

   #!/bin/bash -x
   set -e
   uname -a
   rm -f test test[a-z]
   dd if=/dev/urandom of=test bs=1024k count=128
   for I in a b c d e f g h i j k l m n o p q r s t u v w x y z; do
	   cp test test$I
   done
   md5sum test*

... this is the kinda output I get on most runs :-

   Linux mole-rat 2.4.1-pre10 #1 Fri Jan 26 08:48:55 GMT 2001 i686 unknown
   ...
   aa6a64589748321899bab2b66f71427f  testt
   aa6a64589748321899bab2b66f71427f  testu
   aa6a64589748321899bab2b66f71427f  testv
   9dde1bed276e32a1f9af98c87ab05978  testw
   aa6a64589748321899bab2b66f71427f  testx
   aa6a64589748321899bab2b66f71427f  testy
   aa6a64589748321899bab2b66f71427f  testz
   mole-rat:~# cmp testw testx
   testw testx differ: char 110862337, line 433772
   mole-rat:~# cmp -i $(( 110862336 + 4096 )) testw testx
   mole-rat:~# echo $(( 110862336 % 4096 ))
   0

> 
> I cannot reproduce your behaviour in 2.4.1-pre9.
> 

No, I can't find anybody else who can either. Maybe I've got a dodgy CPU
:-(

P.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
