Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUCXTSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 14:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbUCXTSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 14:18:11 -0500
Received: from palrel13.hp.com ([156.153.255.238]:38112 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263803AbUCXTSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 14:18:09 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.57068.392023.45359@napali.hpl.hp.com>
Date: Wed, 24 Mar 2004 11:18:04 -0800
To: John Reiser <jreiser@BitWagon.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
In-Reply-To: <4061DB55.8070600@BitWagon.com>
References: <20040323231256.GP4677@tpkurt.garloff.de>
	<20040323154937.1f0dc500.akpm@osdl.org>
	<20040324002149.GT4677@tpkurt.garloff.de>
	<16480.55450.730214.175997@napali.hpl.hp.com>
	<4060E24C.9000507@redhat.com>
	<16480.59229.808025.231875@napali.hpl.hp.com>
	<20040324070020.GI31589@devserv.devel.redhat.com>
	<16481.13780.673796.20976@napali.hpl.hp.com>
	<20040324072840.GK31589@devserv.devel.redhat.com>
	<16481.15493.591464.867776@napali.hpl.hp.com>
	<4061B764.5070008@BitWagon.com>
	<16481.49534.124281.434663@napali.hpl.hp.com>
	<4061DB55.8070600@BitWagon.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 24 Mar 2004 11:02:45 -0800, John Reiser <jreiser@BitWagon.com> said:

  >> Only one mprotect() call is needed to make the entire stack
  >> executable.

  John> mprotect() only works on the portion that is currently allocated.
  John> If the stack grows, then another call is needed.

No, mprotect() on the entire stack will mark the vm_area with the
desired protection and VM_GROWSDOWN/VM_GROWSUP will expand
automatically with the new protection.  And if you want to expand the
stack in user-level, e.g., by intercepting SIGSEGV, you'll either do
an mmap() or mprotect() at any rate so there is zero extra cost there.

	--david
