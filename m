Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290765AbSARRsD>; Fri, 18 Jan 2002 12:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290766AbSARRrx>; Fri, 18 Jan 2002 12:47:53 -0500
Received: from quark.didntduck.org ([216.43.55.190]:28175 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S290765AbSARRrn>; Fri, 18 Jan 2002 12:47:43 -0500
Message-ID: <3C485FB5.FC5CB8C3@didntduck.org>
Date: Fri, 18 Jan 2002 12:47:33 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Raman S <raman_s_@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: int 0x40
In-Reply-To: <F49lHiu3fQtYdVzDpub0001e2cc@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raman S wrote:
> 
> Hi,
>   I relatively new to the kernel and am trying to understand how the linux
> kernel handles interrupts. For this I attempted to
> create an int 0x40 by adding a set_system_gate(64, &system_call) in traps.c.
> I verfied by giving out print statements within set_system_gate that 64 is
> being set during initialization (though it isnt a surprise that it is being
> set).  But when i give an int 0x40 in a user level assembly program I get
> segmentation fault, (a SIGSEGV signal is sent to the process).  I have tried
> adding another function in entry.S called my_system_call and reproducing the
> code in system_call with a jmp ret_from_sys_call  at the end. Also tried
> giving an empty C function for my_system_call all with the same result.

The IRQ setup code is probably overwriting it.  You'll need to make the
code in i8259.c skip over vector 0x40 as well as SYSCALL_VECTOR (0x80).

--

				Brian Gerst
