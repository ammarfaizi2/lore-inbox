Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTIJKO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbTIJKO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:14:58 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:54850 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261449AbTIJKO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:14:57 -0400
Date: Wed, 10 Sep 2003 12:14:53 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910121453.B9878@devserv.devel.redhat.com>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <01c601c3777f$97c92680$5aaf7450@wssupremo> <20030910114414.B14352@devserv.devel.redhat.com> <01f801c37783$9ead8960$5aaf7450@wssupremo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <01f801c37783$9ead8960$5aaf7450@wssupremo>; from luca.veraldi@katamail.com on Wed, Sep 10, 2003 at 12:09:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 12:09:21PM +0200, Luca Veraldi wrote:
> > For fun do the measurement on a pIV cpu. You'll be surprised.
> > The microcode "mark dirty" (which is NOT a btsl, it gets done when you do
> a write
> > memory access to the page content) result will be in the 2000 to 4000
> range I
> > predict.
> 
> I'm not responsible for microarchitecture designer stupidity.
> If a simple STORE assembler instruction will eat up 4000 clock cycles,
> as you say here, well, I think all we Computer Scientists can go home and
> give it up now.

I'm saying it can. I don't want to go too deep into an arguement about
microarchitectural details, but my point was that a memory copy of a page
is NOT super expensive relative to several other effects that have to do
with pagetable manipulations. 

> > if you change a page table, you need to flush the TLB on all other cpus
> > that have that same page table mapped, like a thread app running
> > on all cpu's at once with the same pagetables.
> 
> Ok. Simply, this is not the case in my experiment.
> This does not apply.
> We have no threads. But only detached process address spaces.
> Threads are a bit different from processes.

but the pipe code cannot know this so it has to do a cross cpu invalidate.

> > why would you need a global lock for copying memory ?
> 
> System call sys_write() calls
> locks_verify_area() which calls
> locks_mandatory_area() which calls
> lock_kernel()

and... which is also releasing it before the copy

