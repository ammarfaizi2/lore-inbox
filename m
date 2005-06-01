Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVFAHYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVFAHYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 03:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFAHYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 03:24:15 -0400
Received: from mo.optusnet.com.au ([203.10.68.101]:19121 "EHLO
	mo.optusnet.com.au") by vger.kernel.org with ESMTP id S261313AbVFAHYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 03:24:11 -0400
To: Andi Kleen <ak@muc.de>
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Jeff Garzik <jgarzik@pobox.com>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
References: <20050530181626.GA10212@kvack.org> <20050530193225.GC25794@muc.de>
	<200505311137.00011.vda@ilport.com.ua>
	<200505311215.06495.vda@ilport.com.ua> <20050531092358.GA9372@muc.de>
From: michael@optusnet.com.au
Date: 01 Jun 2005 17:22:28 +1000
In-Reply-To: <20050531092358.GA9372@muc.de>
Message-ID: <m2zmuaee2z.fsf@mo.optusnet.com.au>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> > Thus with "normal" page clear and "nt" page copy routines
> > both clear and copy benchmarks run faster than with
> > stock kernel, both with small and large working set.
> > 
> > Am I wrong?
> 
> fork is only a corner case. The main case is a process allocating
> memory using brk/mmap and then using it.

Key point: "using it". This normally involves writes to memory. Most
applications don't commonly read memory that they haven't previously
written to. (valgrind et al call that behaviour a "bug" :).

Given that, I'd say you really don't want the page zero routines
touching the cache.

Michael.
