Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266924AbTAISlF>; Thu, 9 Jan 2003 13:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbTAISlF>; Thu, 9 Jan 2003 13:41:05 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:9 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266924AbTAISlE>;
	Thu, 9 Jan 2003 13:41:04 -0500
Date: Thu, 9 Jan 2003 19:49:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Miles Bader <miles@gnu.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Embed __this_module in module itself.
Message-ID: <20030109184935.GA11107@mars.ravnborg.org>
Mail-Followup-To: Miles Bader <miles@gnu.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20021227104328.143DD2C05D@lists.samba.org> <buou1gma6bz.fsf@mcspd15.ucom.lsi.nec.co.jp> <buoadid1pxl.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030108205645.GA4037@mars.ravnborg.org> <buoy95vrugy.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buoy95vrugy.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 10:18:53AM +0900, Miles Bader wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> > Not knowing much about v850, I wonder why you do not need to set the -m
> > option. Most other architectures do this.
> 
> ???
> 
> A far as I can see, no architecture does anything different than the
> default.

A little grepping gave the following result:

i386/Makefile:LDFLAGS           := -m elf_i386
m68k/Makefile:LDFLAGS := -m m68kelf
mips/Makefile:LDFLAGS           := -G 0
ppc64/Makefile:LDFLAGS          := -m elf64ppc
s390/Makefile:LDFLAGS           := -m elf_s390
s390x/Makefile:LDFLAGS          := -m elf64_s390
sh/Makefile:LDFLAGS             := -EL
sh/Makefile:LDFLAGS             := -EB
sparc/Makefile:LDFLAGS          := -m elf32_sparc
sparc64/Makefile:LDFLAGS                := -m elf64_sparc
x86_64/Makefile:LDFLAGS         := -m elf_x86_64

Little less than half of the architectures defines their own LDFLAGS.
Most of them set an emulation, most probarly inherited from i386.

> 
> [Why on earth would -m be needed, anyway?]

I do not know, but as can be seen above several architectures use it.


I have seen your proposed patch for gnu.linkonce.
I do prefer to have it in arch/v850/Makefile because this is a workaround
for an architecture specific bug in ld.
Why not provide your own link script?

	Sam
