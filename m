Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVCRCsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVCRCsB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 21:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVCRCsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 21:48:00 -0500
Received: from ozlabs.org ([203.10.76.45]:48354 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261428AbVCRCr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 21:47:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16954.16732.434778.495005@cargo.ozlabs.ibm.com>
Date: Fri, 18 Mar 2005 13:47:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: tzachar@cs.bgu.ac.il, linux-kernel@vger.kernel.org, juhl-lkml@dif.dk
Subject: Re: binfmt_elf padzero problems
In-Reply-To: <20050317144929.3b468531.akpm@osdl.org>
References: <1111086609.12193.27.camel@nexus.cs.bgu.ac.il>
	<20050317144929.3b468531.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> I guess if the bss has zero length then we can skip the zeroing of the end
> of the page at the end of bss, as long as we're dead sure that we didn't
> accidentally instantiate a single page on behalf of that zero-length bss.

There is another thing I noticed about the bss code, which is that it
doesn't give the bss the permissions from the PT_LOAD segment, rather
it just uses VM_DATA_DEFAULT_FLAGS.  That doesn't matter at the moment
but may matter in future for ppc32.

Paul.
