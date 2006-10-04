Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWJDVJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWJDVJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWJDVJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:09:57 -0400
Received: from terminus.zytor.com ([192.83.249.54]:58803 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751132AbWJDVJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:09:56 -0400
Message-ID: <452422FD.5000406@zytor.com>
Date: Wed, 04 Oct 2006 14:09:17 -0700
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
References: <20061003170032.GA30036@in.ibm.com> <20061003172511.GL3164@in.ibm.com> <20061003201340.afa7bfce.akpm@osdl.org> <20061004042850.GA27149@in.ibm.com> <45233B58.1050208@zytor.com> <20061004202244.GA3629@in.ibm.com> <45241945.2020105@zytor.com> <20061004204829.GB3629@in.ibm.com> <45241F2A.4080908@zytor.com> <20061004210640.GC3629@in.ibm.com>
In-Reply-To: <20061004210640.GC3629@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> On Wed, Oct 04, 2006 at 01:52:58PM -0700, H. Peter Anvin wrote:
>> Vivek Goyal wrote:
>>> memsz will contain the memory required to load the kernel image. And
>>> probably should also include the memory used by kernel in initial boot
>>> up code which is unaccounted and unbounded.
>>>
>> Right, so that's a major project to produce.
>>
> 
> Eric is already doing that in his patch. He goes through vmlinux
> headers to determine the memory to load the various segments and then
> also takes into account the memory required by bootmem bitmap (128K)
> and memory consumed by initial page tables (tools/build.c).  We can
> audit the code more closely for anything missed and can also include
> some buffer amount to be safe. 
> 
> The only flip side would be that if down the line somebody changes
> the initial bootup code, he shall have to also acccount it in
> tools/build.c. Having said that, its not frequent that initial bootup
> code changes.
> 

No, but it's going to be extremely hard to get this straight unless this 
is actually enforced.  I suspect there needs to be a check and a message 
if this is violated.

	-hpa
