Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313224AbSDQUDn>; Wed, 17 Apr 2002 16:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313384AbSDQUDm>; Wed, 17 Apr 2002 16:03:42 -0400
Received: from dobit2.rug.ac.be ([157.193.42.8]:39111 "EHLO dobit2.rug.ac.be")
	by vger.kernel.org with ESMTP id <S313224AbSDQUDk>;
	Wed, 17 Apr 2002 16:03:40 -0400
Date: Wed, 17 Apr 2002 22:03:35 +0200 (MEST)
From: Frank Cornelis <Frank.Cornelis@rug.ac.be>
To: <linux-kernel@vger.kernel.org>
cc: <Frank.Cornelis@elis.rug.ac.be>
Subject: ptrace & trap flag
Message-ID: <Pine.GSO.4.31.0204172154290.29364-100000@eduserv.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I wonder if anyone can help me out on this one.

When I ptrace a program and it has a breakpoint in it (int3) I can detect
that using PTRACE_SETOPTIONS with the option PTRACE_O_TRACESYSGOOD and
detection happens through !(WSTOPSIG(status) & 0x80).
But, when I ptrace a program and that program contains next code,
	pushfl
	popl %eax
	orl 0x100, %eax
	pushl %eax
	popfl
thus setting the trap flag, then I still can detect the 'real' SIGTRAP
using !(WSTOPSIG(status) & 0x80), but when I do a PTRACE_SYSCALL on the
process, following SIGTRAPs always occur on the same EIP.
Clearing the X86_EFLAGS_TF of that process won't help it to make the
process continue 'till a next instruction.
Can anyone help me out?
The only thing I found is that the TF also makes the RF to be on.

Please CC me; I'm not on the mailing list.

Thanks in advance, Frank.

