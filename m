Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318926AbSICVbo>; Tue, 3 Sep 2002 17:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318935AbSICVbo>; Tue, 3 Sep 2002 17:31:44 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:24199 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318926AbSICVbn>; Tue, 3 Sep 2002 17:31:43 -0400
Date: Tue, 3 Sep 2002 22:35:03 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
Message-ID: <20020903223503.B6848@kushida.apsleyroad.org>
References: <1030506106.1489.27.camel@ldb> <20020828121129.A35@toy.ucw.cz> <1030663192.1326.20.camel@irongate.swansea.linux.org.uk> <1030663772.1491.107.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1030663772.1491.107.camel@ldb>; from ldb@ldb.ods.org on Fri, Aug 30, 2002 at 01:29:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Barbieri wrote:
> > For the other fixups though you -have- to do them before you
> > run the code. That isnt hard (eg sparc btfixup). You generate a list of
> > the addresses in a segment, patch them all and let the init freeup blow 
> > the table away
> Is doing them at runtime with the aforementioned workaround fine?

I would suggest that the init time table is infinitely saner, but if
there will be compiler generated instructions that are hard to catch, do
both: init time fixups for the __asm__ statements, and run time for
compiler generated instructions.

You really want the init time fixups anyway, because a really _really_
obvious optimisation is to remove `lock' prefixes on UP.

-- Jamie
