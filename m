Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161426AbWI2JQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161426AbWI2JQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161424AbWI2JQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:16:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161427AbWI2JQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:16:19 -0400
Date: Fri, 29 Sep 2006 02:16:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
Message-Id: <20060929021604.02fb6162.akpm@osdl.org>
In-Reply-To: <20060928225452.229936605@goop.org>
References: <20060928225444.439520197@goop.org>
	<20060928225452.229936605@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 15:54:45 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> This patch adds common handling for kernel BUGs, for use by
> architectures as they wish.  The code is derived from arch/powerpc.

For my x86_64 usualconfig .text (from objdump --headers) went from
0x002c55c7 down to 0x002c2bda, which is 10.5k saved.

According to /usr/bin/size, vmlinux got bigger:

box:/usr/src/25> size vmlinux 
   text    data     bss     dec     hex filename
3597448  716340  510456 4824244  499cb4 vmlinux-before
3640604  716228  510456 4867288  4a44d8 vmlinux-after

But that's because size(1) is too blunt an instrument: the sum of .text and
the new bug section got larger.

I think we need to thank the powerpc guys, then take away their function
name printing ;)

