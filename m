Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266442AbUGBEH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266442AbUGBEH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 00:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266454AbUGBEH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 00:07:58 -0400
Received: from mail.shareable.org ([81.29.64.88]:32942 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266442AbUGBEH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 00:07:56 -0400
Date: Fri, 2 Jul 2004 05:07:52 +0100
From: Jamie Lokier <jamie@shareable.org>
To: John David Anglin <dave@hiauly1.hia.nrc.ca>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org,
       Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [parisc-linux] Comparing PROT_EXEC-only pages on different CPUs
Message-ID: <20040702040752.GB10366@mail.shareable.org>
References: <20040701224016.GB7928@mail.shareable.org> <200407020324.i623OIZ9011855@hiauly1.hia.nrc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407020324.i623OIZ9011855@hiauly1.hia.nrc.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John David Anglin wrote:
> > Richard raises an interesting point: exec-only pages are useless if
> > the code needs to read jump tables and constant pools.  It seems very
> > likely Alpha and IA64 have these.
> 
> HPPA GCC code also needs to be able to read jump tables in .text.

As Richard Henderson points out, the toolchain should be requesting
PROT_READ|PROT_EXEC if it generates code which needs data read access.
ELF is particularly good for tracking generating those flags, so do
HPPA code segments have the read flag set at the moment?  I.e. if it
does, then it would be fine to change the kernel to honour
PROT_EXEC-only.

(There's also the question of whether that code needs data read
access: do jump table instructions do data reads or do they count as
code reads?  I don't know HPPA well enough to know).

-- Jamie
