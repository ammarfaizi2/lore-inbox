Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUCHAEU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 19:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUCHAEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 19:04:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49054 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262217AbUCHAES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 19:04:18 -0500
To: mike@navi.cx
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Potential bug in fs/binfmt_elf.c?
References: <1078508281.3065.33.camel@linux.littlegreen>
	<404A1C71.3010507@redhat.com>
	<1078607410.10313.7.camel@linux.littlegreen>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Mar 2004 16:55:33 -0700
In-Reply-To: <1078607410.10313.7.camel@linux.littlegreen>
Message-ID: <m1brn8us96.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Hearn <mike@navi.cx> writes:

> On Sat, 2004-03-06 at 18:46, Ulrich Drepper wrote:
> > Show an example of what the file looks like.  Just the ELF program
> > header (readelf -l output).
> 
> I can send the linker script and source file on request. They are
> probably a bit buggy, this isn't an area I know much about. The binutils
> guys seemed to think it should work however.
> 
> thanks -mike
> 
> 
> Elf file type is EXEC (Executable file)
> Entry point 0x818
> There are 6 program headers, starting at offset 52
>  
> Program Headers:
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>   PHDR           0x000034 0x00000034 0x00000034 0x000c0 0x000c0 R   0x4
>   INTERP         0x000400 0x00000400 0x00000400 0x00034 0x00034 R   0x4
>       [Requesting program interpreter: /lib/ld-linux.so.2]
>   LOAD           0x000000 0x00000000 0x00000000 0x00bc4 0x00bc4 R E 0x1000
>   LOAD           0x000bc4 0x00000bc4 0x00000bc4 0x00150 0x00154 RW  0x1000
>   DYNAMIC        0x000bd0 0x00000bd0 0x00000bd0 0x00108 0x00108 RW  0x4
>   LOAD           0x001000 0x00400000 0x00400000 0x00000 0x10000000 R   0x1000

That last PT_LOAD segment looks like pure nonsense.  What is the purpose
of allocating 256MB of read-only zeros?

Eric
