Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbUCHIG1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 03:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbUCHIG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 03:06:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37848 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262289AbUCHIG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 03:06:26 -0500
Date: Mon, 8 Mar 2004 03:06:15 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: John Reiser <jreiser@BitWagon.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Potential bug in fs/binfmt_elf.c?
Message-ID: <20040308080615.GS31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1078508281.3065.33.camel@linux.littlegreen> <404A1C71.3010507@redhat.com> <1078607410.10313.7.camel@linux.littlegreen> <m1brn8us96.fsf@ebiederm.dsl.xmission.com> <404C0B57.6030607@BitWagon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404C0B57.6030607@BitWagon.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 09:57:43PM -0800, John Reiser wrote:
> >> LOAD           0x001000 0x00400000 0x00400000 0x00000 0x10000000 R   
> >> 0x1000
> >
> >
> >What is the purpose of allocating 256MB of read-only zeros?
> 
> To prevent the kernel from placing any shared libraries there [via mmap()
> from ld-linux.so.2], especially under the influence of exec-shield.
> This is 'wine', which wants to reserve that address space for mapping
> executables that were built for some other operating system.  For this
> purpose, the .p_flags of PF_R instead could be 0 [==> PROT_NONE]; but
> do_brk() still turns either one into 'prw.' which has potential memory
> [over-]commit charges.  The expected 'pr--' [or 'p---'] should have
> a memory commit cost of zero.

It should really be p_flags 0 and binfmt_elf.c should be fixed if it doesn't
handle that properly.
glibc ld.so indeed does the right thing with p_flags 0.

	Jakub
