Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUKSUlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUKSUlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 15:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUKSUlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 15:41:47 -0500
Received: from smtp10.wanadoo.fr ([193.252.22.21]:8181 "EHLO
	mwinf1012.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261530AbUKSUlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 15:41:45 -0500
Message-ID: <419E5A88.1050701@wanadoo.fr>
Date: Fri, 19 Nov 2004 21:41:44 +0100
From: Eric Pouech <pouech-eric@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040115
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org> <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Btw, does wine ever _use_ PTRACE_SINGLESTEP for any of the things it does?
> 
> If it does, then that woulc certainly explain why my "fix" made no 
> difference: my fix _only_ handles the case where the ptracer never 
> actually asks for single-stepping, and single-stepping was started 
> entirely by the program being run (ie by setting TF in eflags from within 
> the program itself).
> 
> But if wine ends up using PTRACE_SINGESTEP because wine actually wants to 
> single-step over some instructions, then the kernel will set the PT_DTRACE 
> bit, and start tracing through signal handlers too. The way Wine doesn't 
> want..

wine mixes both approches, we have (to control what's generated inside the 
various exception) to ptrace from our NT-kernel-like process (the ptracer) to 
get the context of the exception. Restart from the ptracer is done with 
PTRACE_SINGLESTEP.

(BTW: I also CC:ed wine-devel ML, that might be of interest to them too)

A+
