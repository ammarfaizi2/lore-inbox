Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVFGOOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVFGOOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVFGOOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:14:43 -0400
Received: from sorrow.cyrius.com ([65.19.161.204]:29200 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S261870AbVFGOOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:14:40 -0400
Date: Tue, 7 Jun 2005 15:14:28 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM)
Message-ID: <20050607141428.GA5650@deprecation.cyrius.com>
References: <200506051456.44810.hugelmopf@web.de> <1117978635.6648.136.camel@tyrosine> <200506051732.08854.stefandoesinger@gmx.at> <1118053578.6648.142.camel@tyrosine> <1118056003.6648.148.camel@tyrosine> <20050606144501.GB2243@elf.ucw.cz> <20050606145429.GA18396@srcf.ucam.org> <20050606145429.GA18396@srcf.ucam.org> <20050606150909.GA2230@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606150909.GA2230@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [2005-06-06 15:10]:
> > machine (an HP nc4000) to resume. Since then, it simply freezes before 
> > hitting "Back to C" despite having had no kernel or configuration 
> > changes. The behaviour is very non-deterministic, which makes me wonder 
> > about something in the suspend or resume process damaging state.
> 
> Hmm, strange. You may want to test if length of sleep affects it...

I tried to resume immediately when the screen goes blank and got the
following results.  Out of 9 trials I got:

 - 4x: it would say "Restarting tasks..." but then oops and hang
   immediately.  See the oops below.
 - 4x: come back and give me a shell - but it hangs
 - 1x: come back, give me a shell and let me type; built-ins worked
   but commands produced the oops posted by Matthew a few days ago.

So far it has never come back when I don't resume immediately.

The new oops I got is:

root@(none):/# mount -t proc none /proc
root@(none):/# echo 3 > /proc/acpi/sleep
Stopping tasks: ===|
    ACPI-0286: *** Error: No installed handler for fixed event [00000002]
Restarting tasks... done
Unable to handle kernel paging request at virtual address 00008265
 printing eip:
c015ac62
*pde = 00000000
Oops: 0002 [#2]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c015ac62>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12-rc5)
EIP is at filp_open+0x32/0x70
eax: f7c7a000   ebx: 00008241   ecx: 00000003   edx: 00000180
esi: 00008241   edi: f7c7a000   ebp: c191c000   esp: c191df48
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 1, threadinfo=c191c000 task=c18bfa20)
Stack: bfeafcf4 00008242 c191df64 c191df58 c016690b 080f1f48 c191df64 c191df6c
       00000014 00000000 f7c7a000 00000003 c18c0e40 c191c000 c015af95 c18c0e40
       00000003 00000003 f7c7a000 00008241 00000003 c015b109 f7c7a000 00008241
Call Trace:
 [<c016690b>] sys_stat64+0x1b/0x40
 [<c015af95>] get_unused_fd+0xa5/0xe0
 [<c015b109>] sys_open+0x49/0x90
 [<c0103245>] syscall_call+0x7/0xb
Code: 8b 5c 24 5c 8d 43 01 a8 03 0f 44 c3 89 c2 83 ca 02 f6 c4 02 0f 45 c2 8d 54 24 10 89 54 24 0c 8b 54 24 60 89 44 24 04 8b 44 24 58 <89> 56 24 08 89 04 24 e8 62 19 01 00 85 c0 74 0e 8b 5c 24 50 83
 <0>Kernel panic - not syncing: Attempted to kill init!

-- 
Martin Michlmayr
http://www.cyrius.com/
