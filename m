Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWJDUxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWJDUxa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWJDUx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:53:29 -0400
Received: from terminus.zytor.com ([192.83.249.54]:7333 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751114AbWJDUx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:53:29 -0400
Message-ID: <45241F2A.4080908@zytor.com>
Date: Wed, 04 Oct 2006 13:52:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com> <20061003172511.GL3164@in.ibm.com> <20061003201340.afa7bfce.akpm@osdl.org> <20061004042850.GA27149@in.ibm.com> <45233B58.1050208@zytor.com> <20061004202244.GA3629@in.ibm.com> <45241945.2020105@zytor.com> <20061004204829.GB3629@in.ibm.com>
In-Reply-To: <20061004204829.GB3629@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> 
> memsz will contain the memory required to load the kernel image. And
> probably should also include the memory used by kernel in initial boot
> up code which is unaccounted and unbounded.
> 

Right, so that's a major project to produce.

One modification that would be highly desirable is to be able to put 
initrd/initramfs in highmem, since people keep adding options which 
break the highmem/lowmem boundary without consideration for the 
implications; the latest one being vmalloc=.

>> I suspect we need at least one more piece of data, which is the required 
>> alignment of a relocated kernel.
> 
> Now with the introduction of config option CONFIG_PHYSICAL_ALIGN, it
> should be easy to get.

Yes, that should be easy.

>>  Either which way, it seems clear that 
>> there is some re-engineering that needs to be done, and I think we need 
>> to better understand *why* the proposed patch failed.
>>
>> Can this failure be reproduced in a simulator?
> 
> I will try to reproduce in a simulator. May be qemu? Any suggestions?

I find Bochs easier to debug under, although it's substantially slower.

	-hpa
