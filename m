Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319640AbSH2Xl1>; Thu, 29 Aug 2002 19:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319641AbSH2Xl1>; Thu, 29 Aug 2002 19:41:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9914 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S319640AbSH2Xl0>;
	Thu, 29 Aug 2002 19:41:26 -0400
Date: Thu, 29 Aug 2002 19:45:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-mm@kvack.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: weirdness with ->mm vs ->active_mm handling
In-Reply-To: <20020829193413.H17288@redhat.com>
Message-ID: <Pine.GSO.4.21.0208291940350.15425-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Aug 2002, Benjamin LaHaise wrote:

> Hello,
> 
> In trying to track down a bug, I found routines like generic_file_read 
> getting called with current->mm == NULL.  This seems to be a valid state 
> for lazy tlb tasks, but the code throughout the kernel doesn't seem to 
> assume that.

Lazy-TLB == "promise not to use a lot of stuff in the kernel".  In particular,
any page fault in that state is a bug.

