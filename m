Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbRFXB4i>; Sat, 23 Jun 2001 21:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265704AbRFXB4S>; Sat, 23 Jun 2001 21:56:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:63872 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265703AbRFXB4P>; Sat, 23 Jun 2001 21:56:15 -0400
Date: Sat, 23 Jun 2001 21:56:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Der Herr Hofrat <der.herr@hofr.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules
In-Reply-To: <200106231454.f5NEsKu14812@kanga.hofr.at>
Message-ID: <Pine.LNX.3.95.1010623214533.21862B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2001, Der Herr Hofrat wrote:

> 
> Hi !
> 
>  can someone explain to me whats happening here ?
> 
> --simple.c--
> #include <linux/module.h>
> #include <linux/kernel.h>
> 
> struct { short x; long y; short z; }bad_struct;
> struct { long y; short x; short z; }good_struct;
> 

[SNIPPED...]
> ---------------------------------------------------------------
> 
> I would expect both structs to be 8byte in size , or atleast the same size !
> but good_struct turns out to be 8bytes and bad_struct 12 .
> 
> what am I doing wrong here ?

You are assuming something that is wrong. Many programmers use
a structure as a "template", assuming that what they write is
exactly what exists in memory. This is not how the 'C' standards
are written! The only thing guaranteed by the standard is that
the first structure member will exist as the same address as the
structure itself -- nothing else.

So that structures can be used as templates, many compilers including
gcc, have non-standard extensions that can be used to "pack" structure
members.  __attribute__ ((packed)) will probably do what you want.

FYI, structures are designed to be accessed only by their member-names.
Therefore, the compiler is free to put members at any offset. In fact,
members, other than the first, don't even have to be in the order
written!


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


