Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVKVMzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVKVMzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 07:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVKVMzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 07:55:05 -0500
Received: from silver.veritas.com ([143.127.12.111]:9345 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964934AbVKVMzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 07:55:03 -0500
Date: Tue, 22 Nov 2005 12:55:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] properly account readahead file major faults
In-Reply-To: <20051122062321.GA30413@logos.cnet>
Message-ID: <Pine.LNX.4.61.0511221249470.24803@goblin.wat.veritas.com>
References: <20051121140038.GA27349@logos.cnet> <20051122042443.GA4588@mail.ustc.edu.cn>
 <20051122062321.GA30413@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Nov 2005 12:54:59.0101 (UTC) FILETIME=[F202FCD0:01C5EF63]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Marcelo Tosatti wrote:
> 
> Pages which hit the first time in cache due to readahead _have_ caused
> IO, and as such they should be counted as major faults.

Have caused IO, or have benefitted from IO which was done earlier?

It sounds debatable, each will have their own idea of what's major.

Maybe PageUptodate at the time the entry is found in the page cache
should come into it?  !PageUptodate implying that we'll be waiting
for read to complete.

Hugh
