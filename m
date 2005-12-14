Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVLNPQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVLNPQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 10:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVLNPQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 10:16:29 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:3753 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964795AbVLNPQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 10:16:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ctDZAQqNuOLroBXvshX0L/CyWDagCuQ34A4GMMC8AANE7Pu3+559U2GEVN76Y+9/sHFK4eMKfLWW/eFXptv1nVQ0ftw1BNtMnnEFKG1VclwHv//tQtCVJPDf1SdDqqhpCC9C2QOjvtsCCMrHTgARS5AFuZydbxWWvP+PDQm39ZQ=
Message-ID: <43A03747.9070808@gmail.com>
Date: Wed, 14 Dec 2005 23:16:23 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
CC: Knut Petersen <Knut_Petersen@t-online.de>, Andrew Morton <akpm@osdl.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and updated CyblaFB
References: <439EF4CB.8030007@t-online.de> <43A03568.6010602@gmail.com>
In-Reply-To: <43A03568.6010602@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> Knut Petersen wrote:
> 
> Wrong boolean check?  Should be if (vesafb & 4). Or might as
> well get rid of this check, it's redundant.
> 
>> +        release_mem_region(info->fix.smem_start,
>> +                   info->fix.smem_len);
>>     iounmap(io_virt);
>>  errout_mmio_remap:
>>     release_mem_region(info->fix.mmio_start,
>>                info->fix.mmio_len);
>>  errout_mmio_reqmem:
>> -//    release_region(0x3c0,32);
>> +    if (!(vesafb & 1))
>> +        release_region(0x3c0,32);
>>  errout_enable:
>> +    kfree(info->pixmap.addr);
>> + errout_alloc_pixmap:
>>     framebuffer_release(info);
>> - errout_alloc:
>> + errout_alloc_info:
>>     output("CyblaFB version %s aborting init.\n",VERSION);
>>     return -ENODEV;
>> }
>> @@ -1359,9 +1468,15 @@ static void __devexit cybla_pci_remove(s
>>     unregister_framebuffer(info);
>>     iounmap(io_virt);
>>     iounmap(info->screen_base);
>> -    release_mem_region(info->fix.smem_start,info->fix.smem_len);
>> +    if (!(vesafb & 4))
> 
> Shouldn't this be if (vesafb & 4)?
> 
>> +        release_mem_region(info->fix.smem_start,info->fix.smem_len);
>>     release_mem_region(info->fix.mmio_start,info->fix.mmio_len);
>>     fb_dealloc_cmap(&info->cmap);
>> +    if (!(vesafb & 2))
> 
> and this...
> 
>> +        release_region(GEBase,0x100);
>> +    if (!(vesafb & 1))
> 
> and this...?
> 

Disregard the last comments, you're right.

Tony
