Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSG3VRd>; Tue, 30 Jul 2002 17:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSG3VRd>; Tue, 30 Jul 2002 17:17:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53777 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316579AbSG3VRb> convert rfc822-to-8bit; Tue, 30 Jul 2002 17:17:31 -0400
Date: Tue, 30 Jul 2002 14:20:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>,
       <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
In-Reply-To: <20020730210938.GA16657@kroah.com>
Message-ID: <Pine.LNX.4.33.0207301417190.2051-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g6ULKYj06157
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Greg KH wrote:

> On Tue, Jul 30, 2002 at 03:23:42PM +0200, Vojtech Pavlik wrote:
> > -#include <asm/types.h>
> > +#include <stdint.h>
> 
> Why?  I thought we were not including any glibc (or any other libc)
> header files when building the kernel?

Indeed. This is unacceptable.

Especially as the standard types are total crap, and the u8 etc are a lot 
more readable. People should realize:

 - the "int" is superfluous. Of _course_ it's an integer. If it was a 
   floating point number, it would be fp16/fp32/fp64/fp80/whatever.
 - the "_t" is there only for namespace collisions, sane people can chose 
   to ignore it.

What do you have left after you have removed the crap? Yup. u8, u16, etc. 
And if you want to share with user space, there's the long-accepted 
namespace collision avoidance of prepending two underscores.

Fix it, Vojtech.

		Linus

