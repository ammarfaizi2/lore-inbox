Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135353AbRAYBdm>; Wed, 24 Jan 2001 20:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAYBdd>; Wed, 24 Jan 2001 20:33:33 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:13832 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S135353AbRAYBdV>; Wed, 24 Jan 2001 20:33:21 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14959.33373.763776.856012@wire.cadcamlab.org>
Date: Wed, 24 Jan 2001 19:33:17 -0600 (CST)
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: warning in 2.4.1pre10
In-Reply-To: <20010125004454.C930@werewolf.able.es>
	<20010124184500.B6941@cadcamlab.org>
	<20010125015853.A2839@werewolf.able.es>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[J. A. Magallon]
> I know Linux will never be compiled with any other thing than
> gcc. But what I do not understand is why if there is a standard C way
> of doing something you have to use an strange extension of gcc.

__attribute__((noreturn)) may do other things besides suppress the "no
return from non-void function" warning.  The gcc manual gives two
additional reasons for it:

          void fatal () __attribute__ ((noreturn));

     The `noreturn' keyword tells the compiler to assume that `fatal'
     cannot return.  It can then optimize without regard to what would
     happen if `fatal' ever did return.  This makes slightly better
     code.  More importantly, it helps avoid spurious warnings of
     uninitialized variables.

Thus it is not a workaround, it is a way to give the optimizer extra
information.  Standard C cannot express this assertion, to my
knowledge, so if you stick with ISO you get suboptimal code.

>From another viewpoint: the 'return 0', though syntactically correct,
would be misleading -- it will never be executed and we know it.  Using
__attribute__((noreturn)) reflects reality, which is usually a good
thing for coding style.  (Whoops, I said "coding style".(: )


> Same happens with 'return' and 'break'. You type the same to add a
> '/* DO NOT REMEMBER THE PRECISE COMMENT */' to shut up the compiler
> instead of just writing
> case X:
> 	...
> 	return xxx;
> 	break;
> 
> ???
> Size optimization for the couple of bytes of the jump in return or break ?

Sorry, I don't follow your point here..

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
