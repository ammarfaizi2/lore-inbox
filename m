Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130036AbRAGLWO>; Sun, 7 Jan 2001 06:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbRAGLWF>; Sun, 7 Jan 2001 06:22:05 -0500
Received: from james.kalifornia.com ([208.179.0.2]:2923 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S130036AbRAGLVt>; Sun, 7 Jan 2001 06:21:49 -0500
Date: Sun, 7 Jan 2001 03:21:36 -0800 (PST)
From: David Ford <david+nospam@killerlabs.com>
Reply-To: David Ford <david+validemail@killerlabs.com>
To: Matthias Juchem <juchem@uni-mannheim.de>
cc: Brett <bpemberton@dingoblue.net.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new bug report script
In-Reply-To: <Pine.LNX.4.30.0101071040250.7104-100000@gandalf.math.uni-mannheim.de>
Message-ID: <Pine.LNX.4.10.10101070248180.4173-100000@Huntington-Beach.Blue-Labs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Matthias Juchem wrote:
> I guess if you use a development version the above returns nothing. If I'm
> right, a pre-release libc was recommended for use with 2.2.0 (I'm not
> sure).

Here is a random idea.

get the pathname of the library(ies) then this sed expression:

sed \
 '/C [lL]ibrary /!d; s/[^0-9]*\([0-9.]*\).*/\1/' \
 /lib/libc.so.6

For me it returns either 5.4.46 or 2.2 depending on what filename is fed to it.


exp: the first regexp heavily filters the input data for the second so
significantly less cpu is spent for the real matching.

/C [lL]ibrary /!d  -- match example: "C Library "

match #1:	[^0-9]*
  match everything until we hit a digit
match #2:	\([0-9.]*\)
  match all digits and '.' and use pattern space #1
match #3:	.*
  match the remainder

We're left with pattern space #1 holding the assumed library version number.

This is done with sed version GNU 3.02.80, some versions differ, buyer beware.

$ sed '/C [lL]ibrary /!d; s/[^0-9]*\([0-9.]*\).*/\1/' /lib/libc.so.6
2.2
$ sed '/C [lL]ibrary /!d; s/[^0-9]*\([0-9.]*\).*/\1/' /lib/libc.so.5
5.4.46
$ 


-d

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
