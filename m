Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWEVQoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWEVQoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 12:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWEVQoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 12:44:18 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:46345 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750982AbWEVQoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 12:44:17 -0400
Message-ID: <4471EA60.8080607@vmware.com>
Date: Mon, 22 May 2006 09:44:16 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       virtualization@lists.osdl.org, kraxel@suse.de
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org> <20060522162949.GG30682@devserv.devel.redhat.com>
In-Reply-To: <20060522162949.GG30682@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
>
> That's known bug in early glibcs short after adding vDSO support.
> The vDSO support has been added in May 2003 to CVS glibc (i.e. post glibc
> 2.3.2) and the problems have been fixed when they were discovered, in
> February 2004:
> http://sources.redhat.com/ml/libc-hacker/2004-02/msg00053.html
> http://sources.redhat.com/ml/libc-hacker/2004-02/msg00059.html
>
> I strongly believe we want randomized vDSOs, people are already abusing the
> fix mapped vDSO for attacks, and I think the unfortunate 10 months of broken
> glibc shouldn't stop that forever.  Anyone using such glibc can still use
> vdso=0, or do that just once and upgrade to somewhat more recent glibc.
>   

While I'm now inclined to agree with randomization, I think the default 
should be off.  You can quite easily "echo 1 > 
/proc/sys/kernel/vdso_randomization" in the RC scripts, which allows you 
to maintain compatibility for everyone and get randomization turned on 
early enough to thwart attacks against any vulnerable daemons.

Zach
