Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUDORrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUDORrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:47:37 -0400
Received: from palrel12.hp.com ([156.153.255.237]:15774 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263467AbUDORpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:45:53 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16510.51784.18462.434975@napali.hpl.hp.com>
Date: Thu, 15 Apr 2004 10:45:44 -0700
To: Jamie Lokier <jamie@shareable.org>
Cc: davidm@hpl.hp.com, linux-ia64@linuxia64.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Kurt Garloff <garloff@suse.de>,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] (IA64) Fix ugly __[PS]* macros in <asm-ia64/pgtable.h>
In-Reply-To: <20040415152600.GA18331@mail.shareable.org>
References: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
	<20040414082355.GA8303@mail.shareable.org>
	<20040414113753.GA9413@mail.shareable.org>
	<16509.25006.96933.584153@napali.hpl.hp.com>
	<20040414184603.GA12105@mail.shareable.org>
	<16509.35554.807689.904871@napali.hpl.hp.com>
	<20040414192844.GD12105@mail.shareable.org>
	<16509.39308.8764.219@napali.hpl.hp.com>
	<20040414210538.GG12105@mail.shareable.org>
	<16509.48237.556502.218222@napali.hpl.hp.com>
	<20040415152600.GA18331@mail.shareable.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 15 Apr 2004 16:26:00 +0100, Jamie Lokier <jamie@shareable.org> said:

  >> As you can see, the data-segment is mapped with EXEC bit turned on.
  >> Ditto for the stack segment, which I think is this one:

  >> 000000011fffe000-0000000120000000 rwxp 0000000000000000 00:00 0

  Jamie> The stack is mapped executable, and the data segment is mapped
  Jamie> non-executable, according to /proc/self/maps which reflects the
  Jamie> PROT_EXEC request.  But in fact because of hardware limitations,
  Jamie> despite the "rw-p" my data segment is actually executable.

Yes, but Alpha doesn't have this limitation.

  Jamie> If you map a segment without PROT_EXEC on Alpha, using a kernel newer
  Jamie> than 1.1.84, you'll get a non-executable mapping.

Sure.

  Jamie> That's what I mean when I say the Alpha maps data without
  Jamie> executable permission.  The ELF loader appears to ask for
  Jamie> exec permission anyway, which is another thing entirely.

It's not the ELF loader, it's the kernel.  See VM_DATA_DEFAULT_FLAGS
in asm-alpha/page.h.

	--david
