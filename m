Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319594AbSH2XPt>; Thu, 29 Aug 2002 19:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319595AbSH2XPt>; Thu, 29 Aug 2002 19:15:49 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:37117
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319594AbSH2XPs>; Thu, 29 Aug 2002 19:15:48 -0400
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Luca Barbieri <ldb@ldb.ods.org>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020828121129.A35@toy.ucw.cz>
References: <1030506106.1489.27.camel@ldb>  <20020828121129.A35@toy.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 30 Aug 2002 00:19:52 +0100
Message-Id: <1030663192.1326.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-28 at 13:11, Pavel Machek wrote:
> > Unfortunately with this patch executing invalid code will cause the
> > processor to enter an infinite exception loop rather than panic. Fixing
> > this is not trivial for SMP+preempt so it's not done at the moment.
> 
> Using 0xcc for everything should fix that, right?

Except you can't do the fixup on SMP without risking hitting the CPU
errata. You also break debugging tools that map kernel code pages r/o
and people who ROM it.

The latter aren't a big problem (they can compile without runtime
fixups). For the other fixups though you -have- to do them before you
run the code. That isnt hard (eg sparc btfixup). You generate a list of
the addresses in a segment, patch them all and let the init freeup blow 
the table away

