Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbVCXCCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbVCXCCv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 21:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbVCXCCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 21:02:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:36766 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262981AbVCXCCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 21:02:39 -0500
Date: Wed, 23 Mar 2005 18:02:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       bstroesser@fujitsu-siemens.com, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [patch 02/12] uml: cpu_relax fix
Message-Id: <20050323180205.1298eb85.akpm@osdl.org>
In-Reply-To: <200503240250.38153.blaisorblade@yahoo.it>
References: <20050322162121.4295D2125C@zion>
	<4241A2C0.2050206@fujitsu-siemens.com>
	<200503240250.38153.blaisorblade@yahoo.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> On Wednesday 23 March 2005 18:09, Bodo Stroesser wrote:
>  > blaisorblade@yahoo.it wrote:
>  > > Use rep_nop instead of barrier for cpu_relax, following $(SUBARCH)'s
>  > > doing that (i.e. i386 and x86_64).
>  >
>  > IIRC, Jeff had the idea, to use sched_yield() for this (from a discussion
>  > on #uml).
>  Hmm, makes sense, but this is to benchmark well... I remember from early 
>  discussions on 2.6 scheduler that using sched_yield might decrease 
>  performance (IIRC starve the calling application).

yup, sched_yield() is pretty uniformly bad, and can result in heaps of
starvation if the machine is busy.  Best to avoid it unless you really want
it, and have tested it thoroughly under many-tasks-busy workloads.

