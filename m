Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVDZEEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVDZEEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVDZEEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:04:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:12220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261303AbVDZEEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:04:40 -0400
Date: Mon, 25 Apr 2005 21:06:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: handle iret faults better
In-Reply-To: <200504260157.j3Q1vV6M011223@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0504252102180.18901@ppc970.osdl.org>
References: <200504260157.j3Q1vV6M011223@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Apr 2005, Roland McGrath wrote:
>
> What would you think about a general hack to let given fixup table entries
> say the code wants the trap and error info made available (pushed on the
> stack or whatever)?

Yes, that sounds fine, if there is just some sane way to indicate that 
(normally the fixup eip is close to the faulting eip, so there should be 
tons of bits available, but it would need to be something clean? For iret, 
I guess we could just set fixup-eip to zero, which would mean "return to 
eip+1 and set error", but that sounds pretty hacky too)

> Conversely, would there be any harm in always setting
> ->thread.error_code and ->thread.trap_no for a kernel trap?  

Page-ins etc in kernel mode are normal, and they shouldn't set the thread 
state. So I think the "turn it into a trap" thing is nicer.

		Linus
