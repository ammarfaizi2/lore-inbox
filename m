Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318261AbSHKJOp>; Sun, 11 Aug 2002 05:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318262AbSHKJOp>; Sun, 11 Aug 2002 05:14:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59354 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318261AbSHKJOo>;
	Sun, 11 Aug 2002 05:14:44 -0400
Date: Sun, 11 Aug 2002 05:18:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Leopold Gouverneur <lgouv@pi.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3[01] does not boot for me
In-Reply-To: <20020811081929.GA693@gouv>
Message-ID: <Pine.GSO.4.21.0208110510280.12398-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Aug 2002, Leopold Gouverneur wrote:

> 2.5.31 hangs during boot after:
> 
> hde 60036480 sectors w/1916 KiB cache CHS=59560/16/63, UDMA(44)
> hde hde1 hde2 hde3 hde4 <
> 
> hde is a  IBM-DTLA-307030 on a HPT366 (Abit BP6) 2.5.29 boot OK
> Sorry if it is a known problem!

Hrrmm...  That definitely sounds like partition-parser getting
screwed in the middle of IO - it _does_ read the first sector
and apparently hangs in attempt to read another one.  Very
interesting, since AFAICS all changes that could have affected
that place happened between .28 and .29.

Deadlocks in surrounding code are very unlikely, since it simply
doesn't care about block number and would just as happily hang
while reading the first sector.  Which it hadn't.

Could you give the output of fdisk -lu /dev/hde? (after booting a working
kernel, obviously ;-)

