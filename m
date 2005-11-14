Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVKNUeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVKNUeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVKNUeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:34:09 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:8708 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932073AbVKNUeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:34:07 -0500
Message-ID: <4378F4BE.6010207@vmware.com>
Date: Mon, 14 Nov 2005 12:34:06 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>	 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>	 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>	 <4374FB89.6000304@vmware.com>	 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>	 <20051113074241.GA29796@redhat.com>	 <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>	 <4378E97E.2060707@vmware.com> <1131997971.2821.68.camel@laptopd505.fenrus.org>
In-Reply-To: <1131997971.2821.68.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Nov 2005 20:34:06.0798 (UTC) FILETIME=[C269F6E0:01C5E95A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Mon, 2005-11-14 at 11:46 -0800, Zachary Amsden wrote:
>
>  
>
>>It seems that SMP vs. UP lock / spinlock overhead is relevant even for 
>>future, multi-core CPUs in a virtualization context, as the notion of 
>>hotplug here is based on scheduling constraints of the virtualization 
>>engine, and the kernel can quite readily end up with only one VCPU.
>>    
>>
>
>
>this assumes that you don't just always want to assume and use SMP
>primitives in a virtualized context. I sort of question that assumption;
>sure these things have overhead, especially "lock", but if the solution
>is more complexity and weird things to hide that half-percent or less of
>performance difference... then do remember that such complexity is not
>free either. Runtime tricks cost. 
>  
>

Runtime tricks that increase complexity cost, yes.  It's all a question 
of measured gain vs. complexity.  But a couple of percent gained on an 
overall basis can be magnified enormously if you are looking at a 
workload that stresses a particular path.  I would expect some of those 
gains to be non-trivial, especially if considering the optimizations you 
could do on page table updates knowing you needn't worry about SMP 
issues anymore.  Even UP has (still?) some places where additional locks 
are present here, and could benefit from having SMP alternatives.

Zach
