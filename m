Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVCXBwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVCXBwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbVCXBwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:52:20 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:30313 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262391AbVCXBvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:51:25 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [patch 02/12] uml: cpu_relax fix
Date: Thu, 24 Mar 2005 02:50:37 +0100
User-Agent: KMail/1.7.2
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, akpm@osdl.org,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
References: <20050322162121.4295D2125C@zion> <4241A2C0.2050206@fujitsu-siemens.com>
In-Reply-To: <4241A2C0.2050206@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503240250.38153.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 March 2005 18:09, Bodo Stroesser wrote:
> blaisorblade@yahoo.it wrote:
> > Use rep_nop instead of barrier for cpu_relax, following $(SUBARCH)'s
> > doing that (i.e. i386 and x86_64).
>
> IIRC, Jeff had the idea, to use sched_yield() for this (from a discussion
> on #uml).
Hmm, makes sense, but this is to benchmark well... I remember from early 
discussions on 2.6 scheduler that using sched_yield might decrease 
performance (IIRC starve the calling application).

Also, that call should be put inside the idle loop, not for cpu_relax, which 
is very different, since it is used (for instance) in kernel/spinlock.c for 
spinlocks, and in such things. The "Pause" opcode is explicitly recommended 
(by Intel manuals, I don't recall why) for things like spinlock loops, and 
using yield there would be bad.

> S390 does something similar using a special DIAG-opcode that 
> gives permission to zVM, that another Guest might run.

> On a host running many UMLs, this might improve performance.
>
> So, I would like to have the small patch below (it's not tested, just an
> idea).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

