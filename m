Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVCaO7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVCaO7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVCaO7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:59:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:43987 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261488AbVCaO6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:58:42 -0500
Date: Thu, 31 Mar 2005 16:58:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-ID: <20050331145825.GA5107@elte.hu>
References: <1112240918.10975.4.camel@lade.trondhjem.org> <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org> <20050331073017.GA16577@elte.hu> <1112270304.10975.41.camel@lade.trondhjem.org> <1112272451.10975.72.camel@lade.trondhjem.org> <20050331135825.GA2214@elte.hu> <1112279522.20211.8.camel@lade.trondhjem.org> <20050331143930.GA4032@elte.hu> <1112280891.20211.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112280891.20211.29.camel@lade.trondhjem.org>
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

> Errm... That looks a bit unsafe. What is there then to stop another 
> process from removing "pos" while you are scheduling? It seems to me 
> that you should really start afresh in that case.

yeah.

> The good news, though, is that because requests on the "commit" list 
> do not remain locked for long without being removed from the list, you 
> should rarely have to skip them. IOW restarting from the head of the 
> list is pretty much the same as starting from where you left off.

as we've learned it through painful experience on the ext3 side, 
restarting scans where 'skipping' has to be done is unhealthy.

would it be safe to collect locked entries into a separate, local list, 
so that the restart would only see newly added entries? Then once the 
moving of all entries has been done, all the locked entries could be 
added back to the commit_list via one list_add. (can anything happen to 
those locked entries that would break this method?)

	Ingo
