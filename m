Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUCXHQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 02:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUCXHQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 02:16:40 -0500
Received: from palrel13.hp.com ([156.153.255.238]:13278 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263033AbUCXHQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 02:16:39 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.13780.673796.20976@napali.hpl.hp.com>
Date: Tue, 23 Mar 2004 23:16:36 -0800
To: Jakub Jelinek <jakub@redhat.com>
Cc: davidm@hpl.hp.com, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
In-Reply-To: <20040324070020.GI31589@devserv.devel.redhat.com>
References: <20040323231256.GP4677@tpkurt.garloff.de>
	<20040323154937.1f0dc500.akpm@osdl.org>
	<20040324002149.GT4677@tpkurt.garloff.de>
	<16480.55450.730214.175997@napali.hpl.hp.com>
	<4060E24C.9000507@redhat.com>
	<16480.59229.808025.231875@napali.hpl.hp.com>
	<20040324070020.GI31589@devserv.devel.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 24 Mar 2004 02:00:20 -0500, Jakub Jelinek <jakub@redhat.com> said:

  Jakub> But I think we should change the toolchain and generate it on
  Jakub> IA64 and PPC64 as well (only GCC would need changing,
  Jakub> emitting .section .note.GNU-stack,"",@progbits at the end of
  Jakub> every compile unit, ld takes care of the rest) exactly for
  Jakub> uniformity's sake and because you get ld.so handling free.

I'm not following you on the "get ld.so handling free" part.  How is
that handling free?

  Jakub> GLIBC dynamic linker will take care of making the stack
  Jakub> executable if say a binary which doesn't need executable
  Jakub> stack depends on a shared library which needs executable
  Jakub> stack or even dlopens a library which needs executable stack.

Actually, that's something that worries me.  Somebody just needs to
succeed in loading any shared object with the right PT_GNU_STACK
header and then the entire program will be exposed to the risk of a
writable stack.  On ia64, I just don't see any need to ever implicitly
turn on execute-permission on the stack, so why allow this extra
backdoor?

	--david
