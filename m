Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279105AbRJaKep>; Wed, 31 Oct 2001 05:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278755AbRJaKe0>; Wed, 31 Oct 2001 05:34:26 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:12556 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279968AbRJaKeP>;
	Wed, 31 Oct 2001 05:34:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Sureshkumar Kamalanathan <skk@sasken.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to write System calls? 
In-Reply-To: Your message of "Mon, 29 Oct 2001 16:46:49 +0530."
             <3BDD3AA1.18FCC633@sasken.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 Oct 2001 12:35:54 +1100
Message-ID: <15176.1004492154@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001 16:46:49 +0530, 
Sureshkumar Kamalanathan <skk@sasken.com> wrote:
>  I have 2.4.4 kernel.  I have to write some system calls for
>interaction with the kernel from the userland.  Can any of you tell me
>where I can get the information regarding this?  
>  I have the Linux Kernel Internals by Beck and others.  But it gives
>the procedure only for 2.2.x.
>  Moreover I need to implement these system calls as Loadable modules.

Syscall entries are hard coded into the syscall table, usually in
arch/$(ARCH)/entry.S.

There is no generic way to add a syscall that is serviced by a module.
I know that the modutils HOWTO gives examples of syscalls in modules
but that doc is out of date, on some architectures you have to adjust
additional registers to make a remote function call.  On those systems
the syscall table works because the kernel is compiled with special
flags, that will not work for modules.  Also Linus has said that he
does not want modules to be able to override syscalls.

