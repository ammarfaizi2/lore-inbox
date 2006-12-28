Return-Path: <linux-kernel-owner+w=401wt.eu-S1754964AbWL1UiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbWL1UiW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754963AbWL1UiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:38:22 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:23392 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964AbWL1UiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:38:21 -0500
Date: Thu, 28 Dec 2006 12:24:22 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: paulmck@linux.vnet.ibm.com
Cc: Christoph Hellwig <hch@infradead.org>, Corey Minyard <minyard@acm.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Carol Hebert <cah@us.ibm.com>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH] IPMI: fix some RCU problems
Message-Id: <20061228122422.f052f6b5.randy.dunlap@oracle.com>
In-Reply-To: <20061228195504.GC4501@linux.vnet.ibm.com>
References: <20061228182447.GA23730@localdomain>
	<20061228183101.GA2412@infradead.org>
	<20061228195504.GC4501@linux.vnet.ibm.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 11:55:04 -0800 Paul E. McKenney wrote:

>  list.h |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff -urpNa -X dontdiff linux-2.6.19/include/linux/list.h linux-2.6.19-lpr/include/linux/list.h
> --- linux-2.6.19/include/linux/list.h	2006-11-29 13:57:37.000000000 -0800
> +++ linux-2.6.19-lpr/include/linux/list.h	2006-12-28 11:48:31.000000000 -0800
> @@ -360,6 +360,64 @@ static inline void list_splice_init(stru
>  }
>  
>  /**
> + * list_splice_init_rcu - splice an RCU-protected list into an existing list.
> + * @list	the RCU-protected list to splice
> + * @head	the place in the list to splice the first list into
> + * @sync	function to sync: synchronize_rcu(), synchronize_sched(), ...

@parameter: is kernel-doc syntax.
I.e., please add a colon after each one of those.

---
~Randy
