Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932836AbWF1PVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932836AbWF1PVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932837AbWF1PVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:21:54 -0400
Received: from cv3.cv.nrao.edu ([192.33.115.2]:30875 "EHLO cv3.cv.nrao.edu")
	by vger.kernel.org with ESMTP id S932836AbWF1PVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:21:52 -0400
Message-ID: <44A29E85.9000902@nrao.edu>
Date: Wed, 28 Jun 2006 11:21:41 -0400
From: Rodrigo Amestica <ramestic@nrao.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
CC: linux-kernel@vger.kernel.org, Rodrigo Amestica <ramestic@nrao.edu>
Subject: Re: vmalloc kernel parameter
References: <44A272CA.5000209@nrao.edu> <20060628163339.d2110437.vsu@altlinux.ru>
In-Reply-To: <20060628163339.d2110437.vsu@altlinux.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact postmaster@cv.nrao.edu for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-101.44, required 5,
	autolearn=disabled, ALL_TRUSTED -1.44, USER_IN_WHITELIST -100.00)
X-MailScanner-From: ramestic@nrao.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey, many thanks for the reply.

I saw those links before but I did not get their full meaning.

By setting uppermem to 512M it does actually work. However, now I'm trying to 
reserve RAM for DMA sake. For that I use mem=1899M; where 1899 comes from the 
total memory reported under normal booting less 128M, which are the Megs that 
I'm trying to reserve.

It seems that by adding mem to the boot line goes into conflicting with the 
uppermem+vmalloc arrangement.

Without providing more details on what's actually happening can you tell that 
there is something wrong on what I'm trying to do?

Would switching to lilo help any?

thanks,
  Rodrigo

Sergey Vlasov wrote:
> 
> This is a known problem with GRUB: it tries to put initrd at the highest
> possible address in memory, and assumes the standard vmalloc area size.
> You need to trick GRUB into thinking that your machine has less memory
> by using "uppermem 524288" (512M) or even lower - then the initrd data
> will still be accessible for the kernel even with larger vmalloc area.
> 
> http://lkml.org/lkml/2005/4/4/283
> http://lists.linbit.com/pipermail/drbd-user/2005-April/002890.html
> 
>> ps: my kernel version is 2.6.15.2, and my machine is a dual opteron
>> with 2GB of ram
>>
>> title with vmalloc
>>          root (hd0,0)
> 
> Add "uppermem 524288" here.
> 
>>          kernel /boot/vmlinuz ro root=LABEL=/ vmalloc=256M
>>          initrd /boot/initrd.img
