Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVANDlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVANDlz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVANDlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:41:51 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:9403 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261888AbVANDji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:39:38 -0500
Message-ID: <41E73EE4.50200@linux-m68k.org>
Date: Fri, 14 Jan 2005 04:39:16 +0100
From: Roman Zippel <zippel@linux-m68k.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, torvalds@osdl.org,
       ak@muc.de, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com> <m1652ddljp.fsf@muc.de> <Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com> <41E4BCBE.2010001@yahoo.com.au> <20050112014235.7095dcf4.akpm@osdl.org> <Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com> <20050112104326.69b99298.akpm@osdl.org> <Pine.LNX.4.58.0501121055490.11169@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0501121055490.11169@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Christoph Lameter wrote:

> Introduction of the cmpxchg is one atomic operations that replaces the two
> spinlock ops typically necessary in an unpatched kernel. Obtaining the
> spinlock requires an spinlock (which is an atomic operation) and then the
> release involves a barrier. So there is a net win for all SMP cases as far
> as I can see.

But there might be a loss in the UP case. Spinlocks are optimized away, 
but your cmpxchg emulation enables/disables interrupts with every access.

bye, Roman
