Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUFHJpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUFHJpB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUFHJpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:45:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33679 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264915AbUFHJo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:44:59 -0400
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <23Y4Y-6F5-1@gated-at.bofh.it> <240qb-8ir-7@gated-at.bofh.it>
	<240Tc-gV-5@gated-at.bofh.it> <2412S-pU-3@gated-at.bofh.it>
	<24vX0-81P-7@gated-at.bofh.it> <m3brjv2rmy.fsf@averell.firstfloor.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Jun 2004 03:42:35 -0600
In-Reply-To: <m3brjv2rmy.fsf@averell.firstfloor.org>
Message-ID: <m1u0xmmlmc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> Ingo Molnar <mingo@elte.hu> writes:
> >
> > Wine is in a really difficult position (due to the complex task it
> > achieves) and is more sensitive to VM layout changes than other
> > applications. So lets try to find the solution that preserves the
> 
> More ELF headers bits are not really hard to add.

Actually I think the cleanest thing at this point, and it was discussed
earlier is for the wine binary to have an ELF segment that is all bss
in the first 1GB.  If the kernel loader can't cope we should fix that
before we start adding new ELF bits.

Wine can then mmap over it as it sees fit.

Eric
