Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265450AbSJaWkw>; Thu, 31 Oct 2002 17:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265453AbSJaWkv>; Thu, 31 Oct 2002 17:40:51 -0500
Received: from fmr02.intel.com ([192.55.52.25]:58360 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265450AbSJaWkv>; Thu, 31 Oct 2002 17:40:51 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D4000EFF46CD@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: RE: [PATCH] fixes for building kernel 2.5.45 using Intel compiler
	 (Ta ke 2)
Date: Thu, 31 Oct 2002 14:47:16 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nakajima, Jun [mailto:jun.nakajima@intel.com]
> Sent: Thursday, October 31, 2002 12:17 PM
> 
> This is take 2 of the updated patch against 2.5.45. I'm 
> asking the compiler  team if someone can answer your question:
> 
> > Considering that Intel largely wrote iBCS2, I guess some 
> Intel person can 
> > know what the standard was ;)

This is what some Intel person said:
   The optimization the compiler is working around is perfectly legal.
   It isn't legal C/C++ to "use" a parameter after the function has
returned.
   The optimizer knows this, and that is why the code got removed. The
volatile 
   is necessary in order to make this kind of C code work.

The point is that once sys_iopl(unsigned long unused) returns a value,
unused is 
finished. So nobody can do anything with the data associated with it after
that.

Jun
