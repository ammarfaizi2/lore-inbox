Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318497AbSHPP4a>; Fri, 16 Aug 2002 11:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318510AbSHPP4a>; Fri, 16 Aug 2002 11:56:30 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:21254 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S318497AbSHPP43>; Fri, 16 Aug 2002 11:56:29 -0400
Date: Sat, 17 Aug 2002 01:59:58 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jeff Dike <jdike@karaya.com>
cc: Alan Cox <alan@redhat.com>, "David S. Miller" <davem@redhat.com>,
       <kuznet@ms2.inr.ac.ru>, Andi Kleen <ak@muc.de>,
       <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31 
In-Reply-To: <200208161625.LAA02494@ccure.karaya.com>
Message-ID: <Mutt.LNX.4.44.0208170125020.1403-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002, Jeff Dike wrote:

> This introduces a window within which SIGIO will be dropped.

Yes.

>  As it stands, this will break UML.  Lost SIGIOs will cause UML hangs.

Ugh.

> 
> If you're determined to avoid spinlocks, why not do something like this:
> 
> +	if (!pid)
> +		return;
> +	while(fown->pid == PID_INVALID) ;
> 
> maybe with a cpu_relax() in the loop.
> 
> But that starts looking a lot like a spinlock.

Although it should be better at not hurting the common case (no
contention), as f_setown() calls should be rare occurences in comparison
to normal SIGIO generation.

> Also, shouldn't there be a capable(CAP_KILL) in here rather than a check
> for uid == 0?

CAP_KILL was only previously used for sockets when calling F_SETOWN and
FIOSETOWN, and was not checked during delivery. The cleanup just brings
sockets into line with ttys, futexes and directories.  It may be a good
idea, but probably out of scope of this cleanup.


- James
-- 
James Morris
<jmorris@intercode.com.au>


