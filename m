Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTFKGoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 02:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTFKGoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 02:44:19 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:2566 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S262874AbTFKGoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 02:44:18 -0400
Message-Id: <200306110648.h5B6m6u28632@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Robert Schwebel <robert@schwebel.de>, linux-kernel@vger.kernel.org
Subject: Re: init does not run on 405GP system
Date: Wed, 11 Jun 2003 09:53:04 +0300
X-Mailer: KMail [version 1.3.2]
References: <20030610201624.GB16103@pengutronix.de>
In-Reply-To: <20030610201624.GB16103@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 June 2003 23:16, Robert Schwebel wrote:
> Hi,
> 
> I'm currently porting u-boot and Linux to an IBM 405GP based board. The
> problem is now that init seems not to be running and does not give any
> output. Up to that point where init should make some noise the kernel
> boots smoothly (serial console), I see all output and NFS-Root is
> mounted via an Intel 82559 network chip. The kernel threads are also
> running, I see kupdated & friends being put into the run queue from time
> to time.
> 
> I have replaced /sbin/init by a statically linked "hello world" (which
> also does not give any output). My impression is that the binary code of
> the init ELF binary is never run. When I switch on the SHOW_SYSCALLs
> macro in arch/ppc/kernel/entry.S I see the system calls for open(),
> dup(), dup() and execve() which come from init/main.c. Opening the
> console works, execve() to /sbin/init as well. When I follow the path of
> execution up to load_elf_binary() in fs/binfmt_elf.c I can even see the
> correct code being load and pointed to by elf_entry in that file. But
> there is never any output from init, nor does something happen when I
> replace init by a piece of code which should immediately make a zero
> pointer exception.
> 
> Nevertheless, the kernel runs smoothly. I can ping the machine, I can
> even floodping it with 0% packet loss. Only that there is no userspace
> running.
> 
> Has anybody seen something like this before?

Yes.

I once tried to run 686 based libc on a 486, init was rained upon
by SIGILLs 'coz it had 586+ instructions. No output on the screen
whatsoever.
--
vda
