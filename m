Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289959AbSAQXOq>; Thu, 17 Jan 2002 18:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290517AbSAQXOj>; Thu, 17 Jan 2002 18:14:39 -0500
Received: from pille.addcom.de ([62.96.128.34]:24079 "HELO pille.addcom.de")
	by vger.kernel.org with SMTP id <S289959AbSAQXO1>;
	Thu, 17 Jan 2002 18:14:27 -0500
Date: Fri, 18 Jan 2002 00:14:29 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dave Jones <davej@suse.de>, Jes Sorensen <jes@wildopensource.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] VAIO irq assignment fix
In-Reply-To: <Pine.LNX.4.33.0201171433260.3114-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201180000490.1434-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Linus Torvalds wrote:

> No. Could we please integrate this not with ACPI, but with the much more
> limited "arch/i386/kernel/acpitable.c", which does NOT imply full ACPI,
> only scanning the tables for information in static format (like the irq
> routing stuff).

Unfortunately, the PCI interrupt routing stuff in ACPI is not in a static 
table, but needs the full-blown AML interpreter. Bad, but we can't do 
anything about it.

> That we can/will/should always enable, and we should NOT EVER encourage
> this kind of "per-BIOS" crud. That just becomes a total horror to maintain
> in the long run.

There's one thing which may be worth doing, I think someone else did 
suggest this before: Allow for overriding BIOS tables with user provided 
correct ones. In this case, Jes could add an entry for the PCMCIA bridge 
to the $PIR table and tell the kernel to use this instead of the buggy 
BIOS' one.

The question is how to do this cleanly. Of course, it's easy enough to
invent some way to use a corrected table which is linked into vmlinux at
compile time. However, that means that the user has to recompile his
kernel to add the table, which is not an easy option for everyone.

It would be nicer to dynamically add the table, e.g. have the bootloader
load it, kind of like the initrd, but that seems not possible without a
lot of effort. (Or is the initrd protocol flexible enough to allow for 
this?)

--Kai

