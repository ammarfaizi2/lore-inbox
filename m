Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWEOPaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWEOPaG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWEOPaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:30:05 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:10384 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751482AbWEOPaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:30:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Ey2l0CgfxiAWcX4kWhwZWAKaYRy1KrYtFejyk0HSNDGuzWDyOnySavo+7G2JlNHaVdzCxwoJsSfVdVhG0YKfXiF8QUCHXpkkWi+45SwTVPacMsWNs/9EANGNzltSrHzUEOv2cnTj3E6Hmk1GF70kU2miUYSKJeGxG++J5OixP+I=
Date: Mon, 15 May 2006 12:29:58 -0300
From: Alberto Bertogli <albertito@gmail.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on x86-64
Message-ID: <20060515152958.GA4553@gmail.com>
References: <20060514182541.GA4980@gmail.com> <20060515033919.GD21383@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515033919.GD21383@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 11:39:19PM -0400, Jeff Dike wrote:
> On Sun, May 14, 2006 at 03:25:41PM -0300, Alberto Bertogli wrote:
> > So I copied them from sysdeps/x86_64/jmpbuf-offsets.h, and building went
> > on. Probably, the same happens under i386.
> 
> The current patch for this is http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17-rc4/patches/jmpbuf
> 
> I need to redo it, but that works for now.

Thanks!


> > It begins to boot, but panics right after mounting root:
> > 
> > [42949373.800000] kjournald starting.  Commit interval 5 seconds
> > [42949373.800000] EXT3-fs: mounted filesystem with ordered data mode.
> > [42949373.800000] VFS: Mounted root (ext3 filesystem) readonly.
> > [42949373.800000] Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, errno = 0, status = 2943
> 
> This is a segfault happening when it shouldn't.
> 
> Can you disassemble stub_segv_handler and send me the output?

Sure, here it is:
(gdb) disas stub_segv_handler
Dump of assembler code for function stub_segv_handler:
0x000000006027c0e0 <stub_segv_handler+0>:       mov    %rdx,%r8
0x000000006027c0e3 <stub_segv_handler+3>:       mov    0xd8(%r8),%rax
0x000000006027c0ea <stub_segv_handler+10>:      mov    $0x7fbffff000,%rdx
0x000000006027c0f4 <stub_segv_handler+20>:      mov    %rax,0x8(%rdx)
0x000000006027c0f8 <stub_segv_handler+24>:      mov    0xc0(%r8),%rax
0x000000006027c0ff <stub_segv_handler+31>:      mov    %eax,(%rdx)
0x000000006027c101 <stub_segv_handler+33>:      mov    0xc8(%r8),%rax
0x000000006027c108 <stub_segv_handler+40>:      mov    %eax,0x10(%rdx)
0x000000006027c10b <stub_segv_handler+43>:      mov    $0x27,%eax
0x000000006027c110 <stub_segv_handler+48>:      syscall
0x000000006027c112 <stub_segv_handler+50>:      mov    $0x3e,%edx
0x000000006027c117 <stub_segv_handler+55>:      movslq %eax,%rdi
0x000000006027c11a <stub_segv_handler+58>:      mov    $0xa,%esi
0x000000006027c11f <stub_segv_handler+63>:      mov    %rdx,%rax
0x000000006027c122 <stub_segv_handler+66>:      syscall
0x000000006027c124 <stub_segv_handler+68>:      mov    %r8,%rsp
0x000000006027c127 <stub_segv_handler+71>:      mov    $0xf,%rax
0x000000006027c12e <stub_segv_handler+78>:      syscall
0x000000006027c130 <stub_segv_handler+80>:      retq
End of assembler dump.


Please let me know if you need anything else.

Thanks,
		Alberto


