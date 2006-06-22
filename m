Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWFVWRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWFVWRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWFVWRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:17:42 -0400
Received: from ns.suse.de ([195.135.220.2]:49576 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030421AbWFVWRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:17:41 -0400
From: Andi Kleen <ak@suse.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] x86_64: another fix for canonical RIPs during signal handling
Date: Fri, 23 Jun 2006 00:17:35 +0200
User-Agent: KMail/1.9.3
Cc: marcelo@kvack.org, linux-kernel@vger.kernel.org, pageexec@freemail.hu
References: <20060622210657.GA1221@1wt.eu> <200606222326.22133.ak@suse.de> <20060622213313.GA22611@1wt.eu>
In-Reply-To: <20060622213313.GA22611@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606230017.35668.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What I understand from this is if code is mapped at 0 (eg by mmap(PROT_EXEC)),
> it would get executed instead of the program being killed. Although I don't
> see how this could be exploited to gain any privileges, I wonder if it can
> cause a process to loop indefinitely instead of being killed or nasty things
> like this. May be this is a stupid analysis from me, so I hope that PaX Team
> will have more precise info.

When you can inject a non canonical RIP into the stack frame you can likely 
also inject other RIPs.  So the whole thing is just a funny way for a program to 
jump in its address space.  0 is as good as any other address for this.

The whole point of the check is just to protect the kernel/CPU against this.
What happens to the user space program itself is no concern because it is the program's
own doing.

-Andi
