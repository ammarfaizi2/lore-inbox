Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287862AbSAFNG1>; Sun, 6 Jan 2002 08:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287865AbSAFNGH>; Sun, 6 Jan 2002 08:06:07 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:50093 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S287862AbSAFNF5>;
	Sun, 6 Jan 2002 08:05:57 -0500
From: dewar@gnat.com
To: dewar@gnat.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020106130556.99E79F2FF5@nile.gnat.com>
Date: Sun,  6 Jan 2002 08:05:56 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<* Given a pointer, I need a way to determine the address (as an int of
  the appropriate size) that the CPU will present to the MMU when I
  dereference that pointer.
>>

This is in general ill-defined, a compiler might generate code that sometimes
does byte access to a particular byte, anmd sometimes gets the entire word
in which the byte resides.

This is often a nasty issue, and is one of the few things in this area that
Ada does not properly address.

If you have a memory mapped byte, you really want a way of saying

"when I read this byte, do a byte read, it will not work to do a word read"

pragma Atomic in Ada (volatile gets close in C, but is not close enough) will
ensure a byte store in practice, but may not ensure byte reads.
