Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUBSBby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 20:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267399AbUBSBby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 20:31:54 -0500
Received: from [218.5.74.208] ([218.5.74.208]:47280 "EHLO vhost.bizcn.com")
	by vger.kernel.org with ESMTP id S267384AbUBSBbu (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 20:31:50 -0500
Message-ID: <40340948.2070605@lovecn.org>
Date: Thu, 19 Feb 2004 08:54:32 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
Organization: LoveCN.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Riley@Williams.Name, davej@suse.de, hpa@zytor.com,
       Linux kernel <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.24] Fix GDT limit in setup.S
References: <403114D9.2060402@lovecn.org> <Pine.LNX.4.53.0402161504490.15476@chaos>
In-Reply-To: <Pine.LNX.4.53.0402161504490.15476@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> On Tue, 17 Feb 2004, Coywolf Qi Hunt wrote:
> 
> 
>>Hello 2.4.xx hackers,
>>
>>In setup.S, i feel like that the gdt limit 0x8000 is not proper and it
>>should be 0x800.  How came 0x800 into 0x8000 in 2.4.xx code?  Is there a
>>story?  It shouldn't be a careless typo. 256 gdt entries should be
>>enough and since it's boot gdt, 256 is ok even if the code is run on SMP
>>with 64 cpus.
>>
> 
> 
> The first element has nothing to do with the number of GDT entries.
> It represents the LIMIT. Because the granularity bit is
> set meaning 4 kilobyte pages and 0x8000 * 0x1000  = 0x8000000
>                                       |      |
>                                       |      |_______ Page size
>                                       |______________ GDT value
> This is the size of address space that is unity-mapped for boot.
> 
> The granularity is also not the number of GDT entries. It
> represents the length for which the GDT definition applies.
> 
> Because this GDT is used only for booting, somebody decided that
> there would never be any boot code beyond 2 GB so there was no
> reason to make room for it. If you change the number to 0x0800,
> you are declaring that neither the boot code nor any RAM-disk
> combination will ever exceed 0x800 * 0x1000 = 0x800000 bytes.
> Therefore you broke my imbedded system. Do not do this.
> 
> 
>>At least the comment doesn't match the code. Either fix the code or fix
>>the comment.  We really needn't so many GDT entries. Let's use the intel
>>segmentation in a most limited way. Below follows a patch fixing the code.
>>
>>I don't have the latest 2.4.24, but setup.S isn't changed from 2.4.23 to
>>2.4.24.
>>
>>Regards, Coywolf
>>

Thank you for you kindly reply, though I really don not agree with you. 
But thanks very much, since you are the only one replying me. I CCed to 
all the 2.0 2.2 2.4 maintainers.


-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

