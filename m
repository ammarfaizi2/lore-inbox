Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265933AbUALAxT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 19:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbUALAxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 19:53:19 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:47786 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265933AbUALAwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 19:52:54 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 11 Jan 2004 16:52:14 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Bart Samwel <bart@samwel.tk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
 0x37ffffff" warning.
In-Reply-To: <4001EED8.1000908@samwel.tk>
Message-ID: <Pine.LNX.4.44.0401111649160.20018-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, Bart Samwel wrote:

> Davide Libenzi wrote:
> >>Now it seems to behave correctly: for '~' it always warns, for '-' it 
> >>only warns if the negative value is below -0x80000000. I'll submit a 
> >>patch to this effect (including the format extensions) to the binutils 
> >>people.
> > 
> > binutils 2.14 works fine, so I believe they already fixed it.
> 
> Against your code, yes. I'm using binutils 2.14 as well. Check it when 
> declaring a .long, like the kernel code does. Then it warns.

Nope. It does not. Tested on three versions of binutils:

[davide@bigblue davide]$ as << EOF
> PG=0xC0000000
> VM=(128 << 20)
> .long (-PG - VM) - 1
> .long (~PG + 1 - VM) - 1
> EOF
[davide@bigblue davide]$ objdump -D a.out 

a.out:     file format elf32-i386

Disassembly of section .text:

00000000 <.text>:
   0:   ff                      (bad)  
   1:   ff                      (bad)  
   2:   ff 37                   pushl  (%edi)
   4:   ff                      (bad)  
   5:   ff                      (bad)  
   6:   ff 37                   pushl  (%edi)
Disassembly of section .data:


Also, most important, the `make bzImage` does not give any warnings.



- Davide


