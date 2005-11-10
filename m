Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVKJN4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVKJN4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVKJN4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:56:46 -0500
Received: from silver.veritas.com ([143.127.12.111]:34967 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750725AbVKJN4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:56:46 -0500
Date: Thu, 10 Nov 2005 13:55:30 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <20051110133704.GG16589@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0511101349200.7699@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511101251060.7127@goblin.wat.veritas.com>
 <20051110133704.GG16589@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Nov 2005 13:56:45.0760 (UTC) FILETIME=[96654400:01C5E5FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2005, Michael S. Tsirkin wrote:
> Quoting Hugh Dickins <hugh@veritas.com>:
> > 
> > You're right, and it would be a good choice, except that MAP_INHERIT on
> > some OSes has a particular meaning (about inheriting across an exec),
> > so I think avoid confusion with that.  MADV_DONTFORK and MADV_DOFORK?
> > Accompanied by VM_DONTFORK?
> 
> Its actually similiar.

Indeed, similar, but different.

> Maybe MADV_FORK_INHERIT/MADV_FORK_DONT_INHERIT then?

Those names are a lot longer than the others in that file.
I still prefer MADV_DONTFORK etc. myself.  Or the original MADV_DONTCOPY,
though I think you were quite right to point out it's all about forking.

> I find using "COPY" there confusing, since the copy is only done on write ...

There are lots of levels on which there's copying or not.  The name
VM_DONTCOPY means "don't copy this vma when forking", it's not thinking
of copying pages or even of copying ptes: just don't copy this vma into
the child.

Hugh
