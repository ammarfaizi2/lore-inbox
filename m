Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbUBZE2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 23:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbUBZE2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 23:28:30 -0500
Received: from amdext2.amd.com ([163.181.251.1]:52631 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S262689AbUBZE2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 23:28:21 -0500
Message-ID: <99F2150714F93F448942F9A9F112634C0FD3855C@txexmtae.amd.com>
From: richard.brunner@amd.com
To: linux-kernel@vger.kernel.org
Subject: RE: Intel vs AMD64
Date: Wed, 25 Feb 2004 22:28:02 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 6C23AA494942712-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure about other architectures, but in the
AMD64 architecture, the 66h and 67h prefixes 
can be applied to the near branch
instructions and have an *architecturally* 
defined action (rather than implementation-defined 
action) which all AMD64 processors follow. It's all 
described in the AMD64 Architecture Programmer's 
Manuals ...

(http://www.amd.com/us-en/Processors/DevelopWithAMD/0,,30_2252_739_7044,00.html)

But, I definitely agree that it is sorta hard to figure 
out what a 64-bit general purpose compiler would 
actually *do* with some of them. However, there are 
embedded/special-purpose scenarios where this might 
be just fine.

For example, for JMP (near):

In 64-bit mode, if the JMP target is specified by a
displacement in the instruction, the signed displacement is
added to the rIP (of the following instruction), and the
result is truncated to 16 or 64 bits depending on operand
size. [rb: 64-bit is default, 66h forces 16-bit].  The
signed displacement can be 8 bits, 16 bits, or 32 bits,
depending on the opcode and the operand size.  [rb: 8-bit
has its own opcode (EB); for the E9 opcode: 32-bit is
default and 66h forces 16-bit].

] -Rich ...
] AMD Fellow
] richard.brunner at amd com  

> -----Original Message-----
> From: Nakajima, Jun [mailto:jun.nakajima@intel.com] 
> Sent: Wednesday, February 25, 2004 5:20 PM
> To: H. Peter Anvin; Timothy Miller
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: Intel vs AMD x86-64
> 
> Yes, that's the very reason I said "useless for compilers." The way
> IP/RIP is updated is different (and implementation specific) on those
> processors if 66H is used with a near branch. For example, RIP may be
> zero-extended to 64 bits (from IP), as you observed before.
> 
> Jun
> >-----Original Message-----
> >From: H. Peter Anvin [mailto:hpa@zytor.com]
> >Sent: Wednesday, February 25, 2004 4:14 PM
> >To: Timothy Miller
> >Cc: Nakajima, Jun; linux-kernel@vger.kernel.org
> >Subject: Re: Intel vs AMD x86-64
> >
> >Timothy Miller wrote:
> >>
> >>
> >> Nakajima, Jun wrote:
> >>
> >>> For near branches (CALL, RET, JCC, JCXZ, JMP, etc.), the operand size is
> >>> forced to 64 bits on both processors in 64-bit mode, basically meaning
> >>> RIP is updated.
> >>>
> >>> Compilers would typically use a JMP short for "intraprocedural jumps",
> >>> which requires just an 8-bit displacement relative to RIP.
> >>
> >> I see.  It's too bad you can't have a 16-bit displacement.
> >>
> >> Ummm... so if 66H were used with a near branch, would that affect the
> >> size of the immediate operand which gets added to RIP, or would that
> >> affect the the portion of IP/EIP/RIP affected?  If it's the latter,
> >> that's pretty silly.
> >>
> >
> >Yes, that would be pretty silly.
> >
> >I honestly don't remember off the top of my head what "o16 jmp blah"
> >does on i386; I have a vague memory that it zero-extends %eip to 32
> >bits, which makes it useless, of course.
> >
> >	-hpa
> 

