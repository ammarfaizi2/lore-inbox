Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267205AbUHIUTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbUHIUTp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUHIUTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:19:12 -0400
Received: from smtp.rol.ru ([194.67.21.9]:13187 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S267171AbUHIUJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:09:45 -0400
Message-ID: <4117DAA0.1020601@vlnb.net>
Date: Tue, 10 Aug 2004 00:12:16 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: ru, en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
References: <20040805200622.GA17324@logos.cnet> <411392E0.6080507@vlnb.net> <20040806143359.GC20911@logos.cnet> <4113A579.5060702@vlnb.net> <20040806155328.GA21546@logos.cnet> <4113B752.7050808@vlnb.net> <20040806170931.GA21683@logos.cnet> <411794E8.6000806@vlnb.net> <20040809155009.GB6361@logos.cnet> <4117B5DB.7060602@vlnb.net> <20040809183437.GD6361@logos.cnet>
In-Reply-To: <20040809183437.GD6361@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Vladislav, 
> 
> There is no cache coherency issues on x86, it handles the cache coherency
> on hardware. 

Well, Marcelo, sorry if I'm getting too annoying, but we had a race with 
cache coherency during SCST (SCSI target mid-level) development. We 
discovered that on P4 Xeon after atomic_set() there is very small 
window, when atomic_read() on another CPUs returns the old value. We had 
to rewrite the code without using atomic_set(). Isn't it cache coherency 
issue?

And, BTW, returning to the original topic, would it be better to make 
set_bit() and friends guarantee not to be reordered on all 
architectures, instead of just add the comment. Otherwise, what is the 
difference with versions with `__` prefix (__set_bit(), for example)? 
Just adding the comments will lead to creating different functions with 
gurantees by everyone who need it in all over the kernel. Is it the 
right thing? In some places in SCST we heavy rely on non-ordering 
guarantees.

Thanks,
Vlad
