Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVCNWYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVCNWYF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVCNWUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:20:52 -0500
Received: from ozlabs.org ([203.10.76.45]:37295 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261984AbVCNWRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:17:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16950.3484.416343.832453@cargo.ozlabs.ibm.com>
Date: Tue, 15 Mar 2005 09:18:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       anton@samba.org, olof@austin.ibm.com, benh@kernel.crashing.org,
       amodra@bigpond.net.au
Subject: Re: [PATCH 1/2] No-exec support for ppc64
In-Reply-To: <20050314155125.68dcff70.moilanen@austin.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	<20050308170826.13a2299e.moilanen@austin.ibm.com>
	<20050310032213.GB20789@austin.ibm.com>
	<20050310162513.74191caa.moilanen@austin.ibm.com>
	<16949.25552.640180.677985@cargo.ozlabs.ibm.com>
	<20050314155125.68dcff70.moilanen@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jake Moilanen writes:

> > I don't think I can push that upstream.  What happens if you leave
> > that out?
> 
> The bss and the plt are in the same segment, and plt obviously needs to
> be executable.

Yes... what I was asking was "do things actually break if you leave
that out, or does the binfmt_elf loader honour the 'x' permission on
the PT_LOAD entry for the data/bss region, meaning that it all just
works anyway?"

I did an objdump -p on some random 32-bit binaries, and they all have
"rwx" flags on the data/bss segment (the second PT_LOAD entry).  And
when I look in /proc/<pid>/maps, it seems that the heap is in fact
marked executable (this is without your patch).  So why do we need the
hack in binfmt_elf.c?

Paul.
