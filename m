Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbTF3Gsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 02:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbTF3Gse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 02:48:34 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:29515 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S265794AbTF3GsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 02:48:24 -0400
Date: Mon, 30 Jun 2003 08:04:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Samium Gromoff <deepfire@ibe.miee.ru>
cc: linux-kernel@vger.kernel.org, <gcc-bugs@gcc.gnu.org>
Subject: Re: [GCC] gcc vs. indentation
In-Reply-To: <20030630092015.49dd6969.deepfire@ibe.miee.ru>
Message-ID: <Pine.LNX.4.44.0306300749400.1400-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003, Samium Gromoff wrote:
> 
> -  if (Controller->FirmwareType == DAC960_V1_Controller)
> -    {
> +  if (Controller->FirmwareType == DAC960_V1_Controller) {

> -origDAC960.o:     file format elf32-i386
> +./newDAC960.o:     file format elf32-i386
> 
>  Disassembly of section .text:
> 
> @@ -5837,7 +5837,7 @@
>      52a8:      84 c0                   test   %al,%al
>      52aa:      75 14                   jne    52c0 <DAC960_V1_ProcessCompletedCommand+0x80>
>      52ac:      0f 0b                   ud2a
> -    52ae:      7d 0d                   jge    52bd <DAC960_V1_ProcessCompletedCommand+0x7d>
> +    52ae:      7c 0d                   jl     52bd <DAC960_V1_ProcessCompletedCommand+0x7d>
>      52b0:      27                      daa
>      52b1:      00 00                   add    %al,(%eax)
>      52b3:      00 8d b6 00 00 00       add    %cl,0xb6(%ebp)
> @@ -5951,7 +5951,7 @@
>      5421:      84 c0                   test   %al,%al
>      5423:      0f 85 97 fe ff ff       jne    52c0 <DAC960_V1_ProcessCompletedCommand+0x80>
>      5429:      0f 0b                   ud2a
> -    542b:      8f 0d 27 00 00 00       popl   0x27
> +    542b:      8e 0d 27 00 00 00       movl   0x27,%cs
>      5431:      e9 8a fe ff ff          jmp    52c0 <DAC960_V1_ProcessCompletedCommand+0x80>
>      5436:      89 1c 24                mov    %ebx,(%esp,1)
>      5439:      e8 fc ff ff ff          call   543a <DAC960_V1_ProcessCompletedCommand+0x1fa>
> @@ -7414,7 +7414,7 @@
>      6ba2:      84 c0                   test   %al,%al
>      6ba4:      75 0a                   jne    6bb0 <DAC960_V2_ProcessCompletedCommand+0xa0>
>      6ba6:      0f 0b                   ud2a
> -    6ba8:      bc 11 27 00 00          mov    $0x2711,%esp
> +    6ba8:      bb 11 27 00 00          mov    $0x2711,%ebx
>      6bad:      00 89 f6 83 bc 24       add    %cl,0x24bc83f6(%ecx)
>      6bb3:      84 00                   test   %al,(%eax)
>      6bb5:      00 00                   add    %al,(%eax)
> 
> Thats it.
> The point is i thought and hoped that gcc abstract syntax tree constructor is
> indentation invariant, and that is seemingly not true.

It's okay, no need to worry.  See the "ud2a"s just above the differences?
Those are BUG()s, and they're going to be followed by a short __LINE__
then __FILE__ pointer.  Your indentation change removed one line, so the
BUG()'s __LINE__ numbers have gone down one.  (And it takes a while for
the disassembly to get back to sanity with the instructions thereafter.)

Hugh

