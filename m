Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUC1JqT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 04:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbUC1JqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 04:46:19 -0500
Received: from port-212-202-52-228.reverse.qsc.de ([212.202.52.228]:52182 "EHLO
	gw.localnet") by vger.kernel.org with ESMTP id S262226AbUC1JqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 04:46:17 -0500
Message-ID: <40669F41.3060100@trash.net>
Date: Sun, 28 Mar 2004 11:47:45 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ken Ashcraft <kash@stanford.edu>
CC: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [CHECKER] 33 missing null checks
References: <5.2.1.1.2.20040327225419.01930cc8@kash.pobox.stanford.edu>
In-Reply-To: <5.2.1.1.2.20040327225419.01930cc8@kash.pobox.stanford.edu>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Ashcraft wrote:
> I'm from the Stanford Metacompilation research group where we use static 
> analysis to find bugs.  I'm trying a new technique, so I would 
> appreciate feedback on these error reports.
> 
> I found these errors by comparing implementations of the same 
> interface.  If functions are assigned to the same function pointer (same 
> field of some struct), I assume that the functions are called from the 
> same context.  Therefore, they should treat their incoming parameters 
> similarly.  In this case, before dereferencing pointers, the functions 
> should either check the pointers for null or not check the pointers for 
> null.  Any contradiction is an error.

This one is invalid. The iptables targets and matches check if they are
called from a valid hook. MASQUERADE for example can only be used in
the POST_ROUTING hook, and out should always be != NULL there.

Regards
Patrick

> There are 33 reports below.  Each report contains first a reference to 
> an EXAMPLE or a place where the parameter is checked.  That reference is 
> followed by a COUNTER(example) or a place where the parameter is not 
> checked.  After that is a code snippet from the counter example.  The 
> type of the function pointer (struct foo.bar) can be found in the 
> COUNTER field: [COUNTER=struct foo.bar-param_num].
> 
> Unfortunately, many of these errors had only one EXAMPLE and one 
> COUNTER.  It may be that some of the null checks are spurious.  You can 
> see the number of EXAMPLEs for a report in the [ex=i] field of the 
> COUNTER line.
> 
> Thanks for any feedback,
> Ken Ashcraft
> 
> ---------------------------------------------------------
> [BUG]
> /home/kash/interface/linux-2.6.3/net/ipv4/netfilter/ipt_MASQUERADE.c:128:masquerade_target: 
> ERROR:DEREF: Not checking arg out [COUNTER=struct ipt_target.target-2] 
> [fit=3] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=2] [counter=1] [z = 
> -2.25170500701057] [fn-z = -4.35889894354067]
>     newsrc = rt->rt_src;
>     DEBUGP("newsrc = %u.%u.%u.%u\n", NIPQUAD(newsrc));
>     ip_rt_put(rt);
> 
>     WRITE_LOCK(&masq_lock);
> 
> Error --->
>     ct->nat.masq_index = out->ifindex;
>     WRITE_UNLOCK(&masq_lock);
> 
>     /* Transfer from original range. */
> ---------------------------------------------------------
