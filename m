Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277904AbRJNXZv>; Sun, 14 Oct 2001 19:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277905AbRJNXZb>; Sun, 14 Oct 2001 19:25:31 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:69 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277904AbRJNXZX>; Sun, 14 Oct 2001 19:25:23 -0400
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Recursive deadlock on die_lock
In-Reply-To: <28465.1003043596@ocs3.intra.ocs.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Oct 2001 17:14:24 -0600
In-Reply-To: <28465.1003043596@ocs3.intra.ocs.com.au>
Message-ID: <m1zo6tolv3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> On Sat, 13 Oct 2001 23:42:51 -0700, 
> Andrew Morton <akpm@zip.com.au> wrote:
> >Keith Owens wrote:
> >> 
> >> ...
> >> If show_registers() fails (which it does far too often on IA64) then
> >> the system deadlocks trying to recursively obtain die_lock.  Also
> >> die_lock is never used outside die(), it should be proc local.
> >> Suggested fix:
> >> 
> >
> >Looks to me like it'll work.  But why does ia64 show_registers()
> >die so easily?  Can it be taught to validate addresses before
> >dereferencing them somehow?
> 
> Unwind code.  It is impossible to obtain IA64 saved registers or back
> trace the calling sequence without using the unwind API.  That API
> relies on decent unwind data being associated with each function
> prologue, stack adjustment, save of return registers etc.  Not an issue
> for C code, it is for Assembler where the unwind info has to be hand
> coded to match what the asm is doing.  IA64 also has PAL code which is
> called directly by the kernel, that PAL code has no unwind data so
> failures in PAL code result in bad or incomplete back traces.
> 
> Unwind is not supposed to fail, it should detect bad input data and
> avoid errors.  Alas, sometimes it does fail.

PAL Ahh!!!!!

Please tell me that we are not rely on the firmware to be correct
after we have finished initializing the operating system.

Please tell me it ain't so.  I have nightmares about that kind of setup.

Eric


