Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVDSPw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVDSPw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 11:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDSPw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 11:52:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:15833 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261521AbVDSPwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 11:52:24 -0400
Date: Tue, 19 Apr 2005 16:52:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Dave Jones <davej@redhat.com>, Chris Wright <chrisw@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
In-Reply-To: <20050419133509.GF7715@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com>
References: <20050407062928.GH24469@wotan.suse.de> 
    <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com> 
    <20050414170117.GD22573@wotan.suse.de> 
    <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com> 
    <20050414181015.GH22573@wotan.suse.de> 
    <20050414181133.GA18221@wotan.suse.de> 
    <20050414182712.GG493@shell0.pdx.osdl.net> 
    <20050415172408.GB8511@wotan.suse.de> 
    <20050415172816.GU493@shell0.pdx.osdl.net> 
    <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com> 
    <20050419133509.GF7715@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Andi Kleen wrote:
> On Fri, Apr 15, 2005 at 06:58:20PM +0100, Hugh Dickins wrote:
> > 
> > I must confess, with all due respect to Andi, that I don't understand his
> > dismissal of the possibility that load_cr3 in leave_mm might be the fix
> > (to create_elf_tables writing user stack data into the pmd).
> 
> Sorry for the late answer.

Not at all.  I didn't expect you to persist in trying to persuade me,
thank you for doing so, and I apologize for taking your time on this.

> Ok, lets try again. The hole fixed by this patch only covers
> the case of an kernel thread with lazy mm doing some memory access
> (or more likely the CPU doing a prefetch there). But ELF loading
> never happens in lazy mm kernel threads.AFAIK in a "real" process
> the TLB is always fully consistent.
> 
> Does that explanation satisfy you? 

It does.  Well, I needed to restudy exec_mmap and switch_mm in detail,
and having done so, I agree that the only way you can get through
exec_mmap's activate_mm without fully flushing the cpu's TLB, is if
the active_mm matches the newly allocated mm (itself impossible since
there's a reference on the active_mm), and the cpu bit is still set
in cpu_vm_mask - precisely not the case if we went through leave_mm.
Yet I was claiming your leave_mm fix could flush TLB for exec_mmap
where it wasn't already done.

Sorry for letting the neatness of my pmd/stack story blind me
to its impossibility, and for wasting your time.

Hugh
