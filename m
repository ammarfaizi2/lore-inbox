Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRJDFdJ>; Thu, 4 Oct 2001 01:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276352AbRJDFc7>; Thu, 4 Oct 2001 01:32:59 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:26884 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S276312AbRJDFct>; Thu, 4 Oct 2001 01:32:49 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Keith Owens <kaos@ocs.com.au>
Date: Thu, 4 Oct 2001 15:32:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15291.62598.349815.333342@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - gameport_{,un}register_port must be static when inline 
In-Reply-To: message from Keith Owens on Thursday October 4
In-Reply-To: <15291.60903.127755.574686@notabene.cse.unsw.edu.au>
	<11465.1002172231@kao2.melbourne.sgi.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 4, kaos@ocs.com.au wrote:
> On Thu, 4 Oct 2001 15:04:39 +1000 (EST), 
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >Are you sure?  2.4.10 seems to have a big input rewrite, and
> >patch-2.4.10-ac4 doesn't change gameport.h and makes only minimal
> >changes to esssolo1.c, one of the drivers in question.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=99419452230792&w=2, find
> gameport.  It was finally fixed in 2.4.5-ac17.

This doesn't negate the fact that it *is* broken in linus-latest, and
it *isn't* fixed in alan-latest.

Try compiling a kernel with (at least)

# CONFIG_INPUT_GAMEPORT is not set
CONFIG_SOUND=y
CONFIG_SOUND_ESSSOLO1=y
CONFIG_SOUND_ES1370=y

and see what I mean.

I get:

ld -m elf_i386  -r -o sounddrivers.o soundcore.o es1370.o esssolo1.o maestro.o maestro3.o ac97_codec.o
esssolo1.o: In function `gameport_register_port':
esssolo1.o(.text+0x6d60): multiple definition of `gameport_register_port'
es1370.o(.text+0x7ea4): first defined here
esssolo1.o: In function `gameport_unregister_port':
esssolo1.o(.text+0x6d64): multiple definition of `gameport_unregister_port'
es1370.o(.text+0x7ea8): first defined here

NeilBrown
