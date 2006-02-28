Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751905AbWB1Gf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbWB1Gf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 01:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWB1Gf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 01:35:58 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:29312 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751905AbWB1Gf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 01:35:58 -0500
Date: Tue, 28 Feb 2006 01:34:07 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [Patch 4/4] Tell GCC 4.1 to move unlikely() code to a
  separate section
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200602280135_MC3-1-B974-938A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200602271639.34776.ak@suse.de>

On Mon, 27 Feb 2006 16:39:34, Andi Kleen wrote:
> On Monday 27 February 2006 16:31, Arjan van de Ven wrote:
> > This patch is more controversial I assume; it offers the option 
> > to use the gcc 4.1 option to move unlikely() code to a separate section.
> > On the con side, this means that longer byte sequences are needed to jump
> > to this code, on the Pro side it means that the unlikely() code isn't sharing
> > icache cachelines and tlbs anymore.
> 
> I don't think this will do anything because the default Makefile
> still has
> 
> CFLAGS += -fno-reorder-blocks 

This also won't work for functions that specify an explicit section name,
e.g. __sched, __kprobes etc. -- at least that's what the gcc 4.0.2 docs say.

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

