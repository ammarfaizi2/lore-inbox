Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUFYQDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUFYQDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 12:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266777AbUFYQDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 12:03:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:37000 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266775AbUFYQDN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 12:03:13 -0400
Date: Fri, 25 Jun 2004 12:02:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Daniel Jacobowitz <dan@debian.org>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: swsusp.S: meaningfull assembly labels
In-Reply-To: <20040625151858.GA27013@nevyn.them.org>
Message-ID: <Pine.LNX.4.53.0406251152580.28750@chaos>
References: <20040625115936.GA2849@elf.ucw.cz> <Pine.LNX.4.53.0406250827250.28070@chaos>
 <20040625151858.GA27013@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, Daniel Jacobowitz wrote:

> On Fri, Jun 25, 2004 at 08:37:45AM -0400, Richard B. Johnson wrote:
> > NO! You just made those labels public! The LOCAL symbols need to
> > begin with ".L".  Now, if you have a 'copy_loop' in another module,
> > linked with this, anywhere in the kernel, they will share the
> > same address -- not what you expected, I'm sure! The assembler
> > has some strange rules you need to understand. Use `nm` and you
> > will find that your new labels are in the object file!
>
> Er, no.  They'll show up in the object file.  That doesn't mean they're
> global; static symbols also show up in the object file.
>
> --
> Daniel Jacobowitz

I got caught on these, thinking that they weren't globals when
I made a assembly files that used, not only named labels but
also definitions like:

BUF = 0x08
LEN = 0x0c

code:	movl	BUF(%esp), %ebx
	movl	LEN(%esp), %ecx


This was done in several files. When linked, I got 'duplicate synbol'
errors. These symbols, while not 'globals' in the sense that 'C'
code can link with them are global definitions that are seen by
the linker and cause duplicate symbol errors. I went through
the gas documentation, trying to find how to prevent these
private symbols from being written to the object file and there
is no command-line mechanism. You just have to start every name
with .L to keep them local.

When I used labels like 'code' above, even though not declared
'.global',  the labels also showed up as duplicate symbols when
linking the resulting object files.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


