Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290733AbSARQ07>; Fri, 18 Jan 2002 11:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290735AbSARQ0t>; Fri, 18 Jan 2002 11:26:49 -0500
Received: from f4.law14.hotmail.com ([64.4.21.4]:59922 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S290734AbSARQ0f>;
	Fri, 18 Jan 2002 11:26:35 -0500
X-Originating-IP: [203.145.133.194]
From: "Raman S" <raman_s_@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: int 0x40
Date: Fri, 18 Jan 2002 08:26:29 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F49lHiu3fQtYdVzDpub0001e2cc@hotmail.com>
X-OriginalArrivalTime: 18 Jan 2002 16:26:29.0293 (UTC) FILETIME=[E1FB9DD0:01C1A03C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I relatively new to the kernel and am trying to understand how the linux 
kernel handles interrupts. For this I attempted to
create an int 0x40 by adding a set_system_gate(64, &system_call) in traps.c. 
I verfied by giving out print statements within set_system_gate that 64 is 
being set during initialization (though it isnt a surprise that it is being 
set).  But when i give an int 0x40 in a user level assembly program I get 
segmentation fault, (a SIGSEGV signal is sent to the process).  I have tried 
adding another function in entry.S called my_system_call and reproducing the 
code in system_call with a jmp ret_from_sys_call  at the end. Also tried 
giving an empty C function for my_system_call all with the same result.

My assembly prints out hello world, from the linux assembly how to, 
reproduced here
If i replace int 0x80 with my int 0x40 I end up with a segmentation fault. 
Is there any thing other than set_system_gate and writing the my_system_call 
handler, that i need to do to have a successful int 0x40? I had tried
   a) commenting out just the deference of the system handler function 
within system_call (call *sys_call_table(0, %eax, 4) )
   b) using &system_call itself in set_system_gate
  but still the same situation.

Any suggestions will be appreciated.

Thanks
Raman


.data					# section declaration

msg:
	.string	"Hello, world!\n"	# our dear string
	len = . - msg			# length of our dear string

.text					# section declaration

			# we must export the entry point to the ELF linker or
    .global _start	# loader. They conventionally recognize _start as their
			# entry point. Use ld -e foo to override the default.

_start:

# write our string to stdout

	movl	$len,%edx	# third argument: message length
	movl	$msg,%ecx	# second argument: pointer to message to write
	movl	$1,%ebx		# first argument: file handle (stdout)
	movl	$4,%eax		# system call number (sys_write)
	int	$0x80		# call kernel

# and exit

	movl	$0,%ebx		# first argument: exit code
	movl	$1,%eax		# system call number (sys_exit)
	int	$0x80		# call kernel




_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.

