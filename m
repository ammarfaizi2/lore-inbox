Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289296AbSAIJZm>; Wed, 9 Jan 2002 04:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289295AbSAIJZc>; Wed, 9 Jan 2002 04:25:32 -0500
Received: from mario.gams.at ([194.42.96.10]:16477 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S289296AbSAIJZU> convert rfc822-to-8bit;
	Wed, 9 Jan 2002 04:25:20 -0500
Message-Id: <200201090925.g099PG023088@frodo.gams.co.at>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C undefined behavior fix 
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E40E@IIS000> 
In-Reply-To: Your message of "Wed, 09 Jan 2002 10:06:24 +0100."
             <17B78BDF120BD411B70100500422FC6309E40E@IIS000> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Wed, 09 Jan 2002 10:25:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <17B78BDF120BD411B70100500422FC6309E40E@IIS000>, Bernard Dautrevaux 
wrote:
>I agree that in some cases reading a 32-bit word when needing a 16-bit
>volatile short may be allowed by the standard. HOWEVER that suppose that gcc
>makes a careful examination of all the memory layout for the program so that
>to be sure that the 16 unneeded bits it reads for efficiency do NOT come
>from some volatile object(s), or gcc will then BREAK the volatile semantics
>for these objects.
>
>So in any case this is not allowed in a lot of cases such as accessing
>accessing an external "volatile short" (only the linker knwos for sure what
>is near this short) or reading memory through a "volatile short*" (only GOD
>knows if you can). And in fact it's WRONG to access in such a way if you
>know that near this object you have other objects (such as is the case in a
>volatile struct...). So even if it *may* be legal in some cases, such an
>optimization that *may* be more efficient is not at all very interesting.

Especially if there are cases were this optimization yields a slower 
access (or even worse indirect bugs).
E.g. if the referenced "volatile short" is a hardware register and the
access is multiplexed over a slow 8 bit bus.  There are embedded systems
around where this is the case and the (cross-)compiler has no way to
know this (except it can be told by the programmer).

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


