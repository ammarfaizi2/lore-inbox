Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVFAHtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVFAHtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 03:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVFAHtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 03:49:07 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9179 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261322AbVFAHtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 03:49:00 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: michael@optusnet.com.au, Andi Kleen <ak@muc.de>
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
Date: Wed, 1 Jun 2005 10:48:31 +0300
User-Agent: KMail/1.5.4
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Jeff Garzik <jgarzik@pobox.com>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel@vger.kernel.org
References: <20050530181626.GA10212@kvack.org> <20050531092358.GA9372@muc.de> <m2zmuaee2z.fsf@mo.optusnet.com.au>
In-Reply-To: <m2zmuaee2z.fsf@mo.optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011048.31537.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 June 2005 10:22, michael@optusnet.com.au wrote:
> Andi Kleen <ak@muc.de> writes:
> 
> > > Thus with "normal" page clear and "nt" page copy routines
> > > both clear and copy benchmarks run faster than with
> > > stock kernel, both with small and large working set.
> > > 
> > > Am I wrong?
> > 
> > fork is only a corner case. The main case is a process allocating
> > memory using brk/mmap and then using it.
> 
> Key point: "using it". This normally involves writes to memory. Most
> applications don't commonly read memory that they haven't previously
> written to. (valgrind et al call that behaviour a "bug" :).
> 
> Given that, I'd say you really don't want the page zero routines
> touching the cache.

Heh, good point.

However, it is valid only if program writes in every byte in a cacheline.
Then sufficiently smart CPU may avoid reading from main RAM.
(I am not sure that today's CPUs are smart enough. K6s were not)

If you have even one uninitialized byte (struct padding, etc) 
between bytes you write, CPU will have to do reads from main memory
in order to have cachelines with fully valid data.

Kernel compile did finish faster with nt stores, tho...
--
vda

