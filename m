Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVBXPKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVBXPKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVBXPJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:09:21 -0500
Received: from alog0252.analogic.com ([208.224.222.28]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262394AbVBXPCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:02:40 -0500
Date: Thu, 24 Feb 2005 10:01:47 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jordi Brinquez <jordi.brinquez@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bug on signal.h
In-Reply-To: <61d439b050224063362ab1465@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0502240953470.14909@chaos.analogic.com>
References: <61d439b050224063362ab1465@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005, Jordi Brinquez wrote:

> Hi,
>
> I think I found a possible bug on file signal.h.
>
> The problem comes when you define a struct sigaction on a user program
> and then you use the function sigaction to remap a signal handler (in
> my case a page_fault) for my own function, this system call is
> compiled as __NR_sigaction system call (by default this routine is
> managed by sys_sigaction routine) and if the architecture defines
> __ARCH_WANT_SYS_RT_SIGACTION kernel uses the routine sys_rt_sigaction
> on the file kernel/signal.c that instead of copying the fields from
> one structure to the other it just uses copy_from_user and
> copy_to_user with the consequent mess with the fields.
>

You NEVER use kernel headers for user code.... EVER. If you
are making something strange, like as you said a page-fault
handler, then you make an in-kernel driver (module).

FYI, no page-fault handler could ever work in user-mode
anyway. A page-fault occurs because the user accesses some
page it doesn't own (probably because it isn't in memory).
The kernel page-fault handler checks to see if the page was
promised. If not, it terminates the user-mode task with
a signal. If so, it finds some free page or makes one
available and maps it into the user's address-space before
returning control to the user. Since the user doesn't own
any free pages, it can't map in any.


[SNIPPED...]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
