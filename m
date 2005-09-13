Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbVIMLdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbVIMLdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbVIMLdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:33:10 -0400
Received: from [81.2.110.250] ([81.2.110.250]:40417 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932610AbVIMLdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:33:09 -0400
Subject: Re: [PATCH] error path in setup_arg_pages() misses
	vm_unacct_memory()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, xemul@sw.ru, hugh@veritas.com
In-Reply-To: <20050913014008.0ee54c62.akpm@osdl.org>
References: <4325B188.10404@sw.ru> <20050912132352.6d3a0e3a.akpm@osdl.org>
	 <43268C21.9090704@sw.ru>  <20050913014008.0ee54c62.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Sep 2005 12:58:15 +0100
Message-Id: <1126612695.31228.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-09-13 at 01:40 -0700, Andrew Morton wrote:
> Kirill Korotaev <dev@sw.ru> wrote:
> >
> > maybe it is worth moving vm_acct_memory() out of 
> >  security_vm_enough_memory()?
> 
> I think that would be saner, yes.  That means that the callers would call
> vm_acct_memory() after security_enough_memory(), if that succeeded.

It would make much more sense to simply sed security_vm_enough_memory()
into security_vm_claim_memory() or a better name. You need to perform
the process as one thing otherwise two people checking for enough memory
may both succeed and then both reserve memory causing overcommits that
should not be permitted.

If you jut fix the name you get the right semantics still but without
the confusion.

Alan

