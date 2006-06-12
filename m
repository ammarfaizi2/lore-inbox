Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWFLT45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWFLT45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWFLT45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:56:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1253 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932190AbWFLT44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:56:56 -0400
Subject: Re: broken local_t on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606122011.52841.ak@suse.de>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	 <200606121955.47803.ak@suse.de>
	 <Pine.LNX.4.64.0606121156460.20195@schroedinger.engr.sgi.com>
	 <200606122011.52841.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Jun 2006 21:12:41 +0100
Message-Id: <1150143161.25462.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-12 am 20:11 +0200, ysgrifennodd Andi Kleen:
> The segment register needs an offset. So you need the linker to generate
> the offset from the base of the per cpu segment somehow. At compile time the 
> address is not known so it cannot be done then.

What happens if you put a section at zero and a section at non-fixed
address (aligned). In the asm macros you stick the variable in both,
using the zero based one for linker symbols and the non zero based one
for data, then discard the zero based one.

That used to work for old binutils which didn't care/spot if you were
discarding material you actually linked against. Not sure what todays
binutils does with it.

Alan

