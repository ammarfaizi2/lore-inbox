Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289595AbSAWA5y>; Tue, 22 Jan 2002 19:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289605AbSAWA5n>; Tue, 22 Jan 2002 19:57:43 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:31760 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S289600AbSAWA5a>;
	Tue, 22 Jan 2002 19:57:30 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15438.2595.750370.978428@argo.ozlabs.ibm.com>
Date: Wed, 23 Jan 2002 11:56:03 +1100 (EST)
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <20020123003449.F1547@athlon.random>
In-Reply-To: <20020122201002.E1547@athlon.random>
	<Pine.LNX.4.21.0201222045450.1352-100000@localhost.localdomain>
	<20020123003449.F1547@athlon.random>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:

> Let's speak about this later. We should ring a bell as soon as we know
> what's really faster (invlpg at every kmap or global tlb flush once
> every 1024 kmaps?).

It would be really good if we could have whatever hooks are necessary
for each architecture to decide this issue in its own way.  On PPC for
example a global tlb flush is really expensive, it would be quicker
for us to either flush each kmap page individually or to flush the
range of addresses used for kmaps when we wrap.  At the very least I
would like to have a flush_tlb_kernel_range function which would get
called at the end of flush_all_zero_pkmaps instead of flush_tlb_all.

Regards,
Paul.
