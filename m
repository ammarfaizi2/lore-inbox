Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTEBRBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbTEBRBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:01:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32195 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263017AbTEBRBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:01:42 -0400
Date: Fri, 2 May 2003 19:13:56 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk11: .text.exit errors in .altinstructions
Message-ID: <20030502171355.GU21168@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I'm getting the following .text.exit errors in 2.5.68-bk11 (kernel 
compiled with gcc 2.95 for a K6):

<--  snip  -->

./drivers/hotplug/pci_hotplug.o(.altinstructions+0xa8): undefined 
reference to `local symbols in discarded section .exit.text'
./drivers/hotplug/pci_hotplug.o(.altinstructions+0xb4): undefined 
reference to `local symbols in discarded section .exit.text'
./drivers/hotplug/cpci_hotplug_core.o(.altinstructions+0x90): undefined 
reference to `local symbols in discarded section .exit.text'
./drivers/hotplug/cpci_hotplug_core.o(.altinstructions+0x9c): undefined 
reference to `local symbols in discarded section .exit.text'
./drivers/hotplug/built-in.o(.altinstructions+0xa8): undefined reference 
to `local symbols in discarded section .exit.text'
./drivers/hotplug/built-in.o(.altinstructions+0xb4): more undefined 
references to `local symbols in discarded section .exit.text' follow

<--  snip  -->

The strange thing is that all errors are in .altinstructions, the files 
seem to be OK, and the problem wasn't present in earlier kernel 
versions.

Disassembled .altinstructions from drivers/hotplug/cpci_hotplug_core.o:

<--  snip  -->

Disassembly of section .altinstructions:

00000000 <.altinstructions>:
   0:   df 0a                   (bad)  (%edx)
   2:   00 00                   add    %al,(%eax)
   4:   00 00                   add    %al,(%eax)
   6:   00 00                   add    %al,(%eax)
   8:   19 04 03                sbb    %eax,(%ebx,%eax,1)
   b:   00 6e 0b                add    %ch,0xb(%esi)
   e:   00 00                   add    %al,(%eax)
  10:   03 00                   add    (%eax),%eax
  12:   00 00                   add    %al,(%eax)
  14:   19 04 03                sbb    %eax,(%ebx,%eax,1)
  17:   00 5e 0d                add    %bl,0xd(%esi)
  1a:   00 00                   add    %al,(%eax)
  1c:   06                      push   %es
  1d:   00 00                   add    %al,(%eax)
  1f:   00 19                   add    %bl,(%ecx)
  21:   04 03                   add    $0x3,%al
  23:   00 94 0d 00 00 09 00    add    %dl,0x90000(%ebp,%ecx,1)
  2a:   00 00                   add    %al,(%eax)
  2c:   19 04 03                sbb    %eax,(%ebx,%eax,1)
  2f:   00 68 10                add    %ch,0x10(%eax)
  32:   00 00                   add    %al,(%eax)
  34:   0c 00                   or     $0x0,%al
  36:   00 00                   add    %al,(%eax)
  38:   19 04 03                sbb    %eax,(%ebx,%eax,1)
  3b:   00 65 11                add    %ah,0x11(%ebp)
  3e:   00 00                   add    %al,(%eax)
  40:   0f 00 00                sldtl  (%eax)
  43:   00 19                   add    %bl,(%ecx)
  45:   04 03                   add    $0x3,%al
  47:   00 87 13 00 00 12       add    %al,0x12000013(%edi)
  4d:   00 00                   add    %al,(%eax)
  4f:   00 19                   add    %bl,(%ecx)
  51:   04 03                   add    $0x3,%al
  53:   00 3d 16 00 00 15       add    %bh,0x15000016
  59:   00 00                   add    %al,(%eax)
  5b:   00 19                   add    %bl,(%ecx)
  5d:   04 03                   add    $0x3,%al
  5f:   00 88 19 00 00 18       add    %cl,0x18000019(%eax)
  65:   00 00                   add    %al,(%eax)
  67:   00 19                   add    %bl,(%ecx)
  69:   04 03                   add    $0x3,%al
  6b:   00 dc                   add    %bl,%ah
  6d:   19 00                   sbb    %eax,(%eax)
  6f:   00 1b                   add    %bl,(%ebx)
  71:   00 00                   add    %al,(%eax)
  73:   00 19                   add    %bl,(%ecx)
  75:   04 03                   add    $0x3,%al
  77:   00 58 1c                add    %bl,0x1c(%eax)
  7a:   00 00                   add    %al,(%eax)
  7c:   1e                      push   %ds
  7d:   00 00                   add    %al,(%eax)
  7f:   00 19                   add    %bl,(%ecx)
  81:   04 03                   add    $0x3,%al
  83:   00 ac 1c 00 00 21 00    add    %ch,0x210000(%esp,%ebx,1)
  8a:   00 00                   add    %al,(%eax)
  8c:   19 04 03                sbb    %eax,(%ebx,%eax,1)
  8f:   00 b7 00 00 00 24       add    %dh,0x24000000(%edi)
  95:   00 00                   add    %al,(%eax)
  97:   00 19                   add    %bl,(%ecx)
  99:   04 03                   add    $0x3,%al
  9b:   00 05 01 00 00 27       add    %al,0x27000001
  a1:   00 00                   add    %al,(%eax)
  a3:   00 19                   add    %bl,(%ecx)
  a5:   04 03                   add    $0x3,%al

<--  snip  -->


cu
Adrian



