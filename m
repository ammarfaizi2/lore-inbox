Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWFLJSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWFLJSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWFLJSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:18:08 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:22545 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751205AbWFLJSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:18:07 -0400
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false
	positives
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 11:17:44 +0200
Message-Id: <1150103864.20886.88.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 09:11 +0100, Catalin Marinas wrote:
> On 12/06/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > Hi Catalin,
> >
> > On 6/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > > There are allocations for which the main pointer cannot be found but they
> > > are not memory leaks. This patch fixes some of them.
> >
> > Can we fix this by looking for pointers to anywhere in the allocated
> > memory block instead of just looking for the start?
> 
> I thought about this as well (I think that's how Valgrind works) but
> it would increase the chances of missing real leaks. It currently
> looks for the start of the block and a few locations inside the block
> (those from which the main pointer is computed using the
> container_of() macro).
> 
> I need to do some tests to see how it works but I won't be able to use
> the radix_tree (as storing each location in the block would lead to a
> huge tree).

A radix-priority-search-tree would allow to store intervals and query
addresses.

Peter

