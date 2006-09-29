Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422824AbWI2V3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824AbWI2V3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWI2V3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:29:12 -0400
Received: from mx2.rowland.org ([192.131.102.7]:22278 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1422824AbWI2V3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:29:10 -0400
Date: Fri, 29 Sep 2006 17:29:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Paolo Ornati <ornati@fastwebnet.it>
cc: Arkadiusz =?UTF-8?B?SmHFgm93aWVj?= <ajalowiec@interia.pl>,
       <linux-kernel@vger.kernel.org>, <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] PROBLEM: Kernel 2.6.x freeze
In-Reply-To: <20060929143806.0d6a9162@localhost>
Message-ID: <Pine.LNX.4.44L0.0609291717460.26116-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006, Paolo Ornati wrote:

> On Thu, 28 Sep 2006 07:33:30 +0000
> Arkadiusz Jalowiec <ajalowiec@interia.pl> wrote:
> 
> > OOps:
> > 
> > ivalid opcode: 0000 [#1]

> > CPU: 0
> > EIP: 0060: [<d0d184dc>] Not tainted VLI
> > EFLAGS: 00010003 (2.6.18#1)
> > EIP is at uhci_giveback_urb+0x59/0x126 [uhci_hcd]
> > eax: cefeeed1 ebx: cf3935a0 ecx: ce2a9bc0 edx: cf3935a0
> > esi: ce2a9bc0 edi: 00000000 epb: ce4933bc esp: c6b79f00
> > ds: 007b es: 007b ss:0068

> > Code:     5c 89 57 2c 8b 40 44 c7 47 40 00 00 00 00 89
> >                 47 3c 8b 45 00 8b 55 04 89 02 89 50 04 89
> >                 6d 00 8d 47 18 89 6d 04 39 47 18 75
> >                 4b 0f <b6> 47 50 a8 02 88 44 24 08 74 3f 0f b6
> >                 46 20 8b 4e 20 ba fe ff

> Can you send the ".config" for this 2.6.18?

Equally important, which version of gcc was used to compile the kernel?

Why are the angle brackets above around <b6>, when the preceding 0f byte 
is the actual start of the instruction?  Is that merely an artifact of the 
way invalid opcode exceptions are reported, or is it an indication of what 
went wrong?

> I'm not an expert but...
> 
> This is how the code should look like (I've compiled 2.6.18 with gcc
> 3.3.6 + gentoo patches):
> 
> c02dd6a2:       74 5c                   je     c02dd700 <uhci_giveback_urb+0xa0>
> c02dd6a4:       0f b6 46 20             movzbl 0x20(%esi),%eax
> c02dd6a8:       8b 4e 20                mov    0x20(%esi),%ecx
> c02dd6ab:       c7 04 24 fe ff ff ff    movl   $0xfffffffe,(%esp)
> 
> 
> But we have:
> 
>   500894:       74 3f                   je     5008d5 <_end+0x2d>
>   500896:       0f b6 46 20             movzbl 0x20(%rsi),%eax
>   50089a:       8b 4e 20                mov    0x20(%rsi),%ecx
>   50089d:       ba                      .byte 0xba
>   50089e:       fe                      (bad)
>   50089f:       ff                      .byte 0xff
> 
> 
> So "c7 04 24" turned into
>    "ba fe ff"

What do you mean by "we have"?  Where did your two disassembly listings 
come from?  The values in the oops message above don't match either of 
your listings, at least not exactly.

> The funny thing is that "fe ff" comes just after "24" in the original
> code...

Arkadiusz, could you please run "objdump -d drivers/usb/host/uhci-hcd.o" 
in your kernel source directory, and post the portion of the output for 
the uhci_giveback_urb routine?  

Alan Stern

