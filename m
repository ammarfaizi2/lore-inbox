Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbUKST5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUKST5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 14:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbUKST4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 14:56:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:7599 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261561AbUKSTwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:52:14 -0500
Date: Fri, 19 Nov 2004 11:51:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Pouech <pouech-eric@wanadoo.fr>
cc: Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <419E4A76.8020909@wanadoo.fr>
Message-ID: <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
 <419E4A76.8020909@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Nov 2004, Eric Pouech wrote:
>
> I don't have 2.6.9 installed here, I'm just reporting & interpreting bug reports 
> we have from end users. I'll try to make on the bug reporters try to fix the 
> other spots, but that's always easier from them the get the source from one spot.

Btw, does wine ever _use_ PTRACE_SINGLESTEP for any of the things it does?

If it does, then that woulc certainly explain why my "fix" made no 
difference: my fix _only_ handles the case where the ptracer never 
actually asks for single-stepping, and single-stepping was started 
entirely by the program being run (ie by setting TF in eflags from within 
the program itself).

But if wine ends up using PTRACE_SINGESTEP because wine actually wants to 
single-step over some instructions, then the kernel will set the PT_DTRACE 
bit, and start tracing through signal handlers too. The way Wine doesn't 
want..

		Linus
