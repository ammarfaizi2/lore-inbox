Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285022AbSAGSkI>; Mon, 7 Jan 2002 13:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSAGSj6>; Mon, 7 Jan 2002 13:39:58 -0500
Received: from unknown-1-11.wrs.com ([147.11.1.11]:45289 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id <S285022AbSAGSjx>;
	Mon, 7 Jan 2002 13:39:53 -0500
From: mike stump <mrs@windriver.com>
Date: Mon, 7 Jan 2002 10:38:54 -0800 (PST)
Message-Id: <200201071838.KAA11914@kankakee.wrs.com>
To: Dautrevaux@microprocess.com, dewar@gnat.com, paulus@samba.org
Subject: RE: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bernard Dautrevaux <Dautrevaux@microprocess.com>
> To: "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org
> Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
>         velco@fadata.bg
> Date: Mon, 7 Jan 2002 14:24:35 +0100 

> Truly sure; In fact when writiong our Real Time Kernel in C++ we
> just had this problem, and had to "hack" GCC C and C++ compilers so
> that volatile acesses are guaranteed to be done with the right size,
> even in case of bit fields in fact.

Did your case include more than bitfields?  I recognize that bitfields
have two possible semantics, and that you and gcc may have different
opinions about the semantics of them.  I discount the alternative
choice of semantic as being an example of this problem.  Roughly
speaking, as I recall...  The two semantics are, the base type of the
bitfield defines the mode in which memory is accessed and the smallest
size supported that contains the bitfield defines the access.

struct { unsigned int field:8; };

would be a 32 bit access, versus

struct { unsigned int field:8; };

would be an 8 bit access.

If gcc doesn't do one of them, it truly is broken (if the machine
supports the access of course).  I would like to know if gcc is truly
broken.

> Using volatile (and expanding its semantics to mean: read and write
> with the requested size) was a great help.

In gcc, it already means that.  If you think otherwise, I'd like to
see the example that shows it.
