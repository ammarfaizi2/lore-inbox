Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVCaQBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVCaQBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVCaQBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:01:25 -0500
Received: from pat.uio.no ([129.240.130.16]:30378 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261414AbVCaQBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:01:21 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050331151000.GA6013@elte.hu>
References: <20050330231801.129b0715.akpm@osdl.org>
	 <20050331073017.GA16577@elte.hu>
	 <1112270304.10975.41.camel@lade.trondhjem.org>
	 <1112272451.10975.72.camel@lade.trondhjem.org>
	 <20050331135825.GA2214@elte.hu>
	 <1112279522.20211.8.camel@lade.trondhjem.org>
	 <20050331143930.GA4032@elte.hu>
	 <1112280891.20211.29.camel@lade.trondhjem.org>
	 <20050331145825.GA5107@elte.hu>
	 <1112281616.20211.40.camel@lade.trondhjem.org>
	 <20050331151000.GA6013@elte.hu>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 11:00:58 -0500
Message-Id: <1112284858.11124.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.548, required 12,
	autolearn=disabled, AWL 1.40, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 31.03.2005 Klokka 17:10 (+0200) skreiv Ingo Molnar:
> * Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > > would it be safe to collect locked entries into a separate, local list, 
> > > so that the restart would only see newly added entries? Then once the 
> > > moving of all entries has been done, all the locked entries could be 
> > > added back to the commit_list via one list_add. (can anything happen to 
> > > those locked entries that would break this method?)
> > 
> > You are not allowed to remove an entry from the list if it is locked 
> > by someone else. Locking grants temporary ownership of the entry.
> 
> well, removing a neighboring entry will change the locked entry's link 
> fields (e.g. req->wb_list.prev), so this ownership cannot involve this 
> particular list, can it?

The point is that you are taking something that was previously globally
visible and owned by somebody else and making it globally invisible by
placing it on a private list.
I'm not sure whether or not that is going to cause bugs in the current
code (it may actually be safe with the current code), but as far as
clean ownership semantics go, it sucks.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

