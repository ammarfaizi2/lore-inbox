Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270597AbTGNNoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270591AbTGNNmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:42:53 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:31125 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270477AbTGNNlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:41:02 -0400
Date: Mon, 14 Jul 2003 14:55:40 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof (siginfo_t) problem
Message-ID: <20030714135540.GB26002@mail.jlokier.co.uk>
References: <20030714084000.J15481@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714084000.J15481@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> When siginfo_t was added, the intent obviously was that its size
> be 128 bytes on all arches.
> 
> The kernel unfortunately does this right on sparc64 and alpha from 64-bit
> arches only; ia64, s390x, ppc64 etc. got it wrong.

That's not the only siginfo_t problem:

	- Take a look at the placement of the _uid32 field on m68k.
	  It varies from sub-structure to sub-structure - yet it is
	  always written to the same offset by the kernel.  Borken!

Other cleanups:

	- SI_* codes on S390 are identical to the generic ones.
	  They can be removed from the S390 file.

	- Comment in MIPS siginfo about IRIX compatibility is no
	  longer true; the layout was changed when uid32 added.

	- __ARCH_SI_UID_T can be removed.  Only Sparc sets it,
	  and to the same type as uid_t (unsigned int).

-- Jamie
