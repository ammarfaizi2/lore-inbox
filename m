Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVCaPNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVCaPNs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVCaPMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:12:40 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18882 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261414AbVCaPKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:10:08 -0500
Date: Thu, 31 Mar 2005 17:10:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-ID: <20050331151000.GA6013@elte.hu>
References: <20050330231801.129b0715.akpm@osdl.org> <20050331073017.GA16577@elte.hu> <1112270304.10975.41.camel@lade.trondhjem.org> <1112272451.10975.72.camel@lade.trondhjem.org> <20050331135825.GA2214@elte.hu> <1112279522.20211.8.camel@lade.trondhjem.org> <20050331143930.GA4032@elte.hu> <1112280891.20211.29.camel@lade.trondhjem.org> <20050331145825.GA5107@elte.hu> <1112281616.20211.40.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112281616.20211.40.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > would it be safe to collect locked entries into a separate, local list, 
> > so that the restart would only see newly added entries? Then once the 
> > moving of all entries has been done, all the locked entries could be 
> > added back to the commit_list via one list_add. (can anything happen to 
> > those locked entries that would break this method?)
> 
> You are not allowed to remove an entry from the list if it is locked 
> by someone else. Locking grants temporary ownership of the entry.

well, removing a neighboring entry will change the locked entry's link 
fields (e.g. req->wb_list.prev), so this ownership cannot involve this 
particular list, can it?

	Ingo
