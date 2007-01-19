Return-Path: <linux-kernel-owner+w=401wt.eu-S964863AbXASGYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbXASGYM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 01:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbXASGYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 01:24:12 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:44867 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964863AbXASGYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 01:24:11 -0500
Message-ID: <45B064AD.6030002@bull.net>
Date: Fri, 19 Jan 2007 07:26:53 +0100
From: Nadia Derbey <Nadia.Derbey@bull.net>
Organization: BULL/DT/OSwR&D/Linux
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Franck Bui-Huu <fbuihuu@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: unable to mmap /dev/kmem
References: <45AFA490.5000508@bull.net> <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/01/2007 07:32:27,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/01/2007 07:32:28,
	Serialize complete at 19/01/2007 07:32:28
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 18 Jan 2007, Nadia Derbey wrote:
> 
>>Trying to mmap /dev/kmem with an offset I take from /boot/System.map,
>>I get an EIO error on a 2.6.20-rc4.
>>This is something that used to work on older kernels.
>>
>>Had a look at mmap_kmem() in drivers/char/mem.c, and I'm wondering whether
>>pfn is correctly computed there: shouldn't we have something like
>>
>>pfn = PFN_DOWN(virt_to_phys((void *)PAGE_OFFSET)) +
>>      __pa(vma->vm_pgoff << PAGE_SHIFT);
>>
>>instead of
>>
>>pfn = PFN_DOWN(virt_to_phys((void *)PAGE_OFFSET)) + vma->vm_pgoff;
>>
>>Or may be should I substract PAGE_OFFSET from the value I get from System.map
>>before mmapping /dev/kmem?
> 
> 
> Sigh, you're right, 2.6.19 messed that up completely.
> No, you never had to subtract PAGE_OFFSET from that address
> in the past, and you shouldn't have to do so now.
> 
> Please revert the offending patch below, and then maybe Franck
> can come up with a patch which preserves the original behaviour
> on architectures which used to work (e.g. i386), while fixing
> it for those architectures (which are they?) that did not.
> 

Ok, I'll do that, thanks!

Regards,
Nadia
