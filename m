Return-Path: <linux-kernel-owner+w=401wt.eu-S932461AbXARQo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbXARQo3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 11:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbXARQo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 11:44:29 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:37947 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932461AbXARQo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 11:44:28 -0500
Message-ID: <45AFA490.5000508@bull.net>
Date: Thu, 18 Jan 2007 17:47:12 +0100
From: Nadia Derbey <Nadia.Derbey@bull.net>
Organization: BULL/DT/OSwR&D/Linux
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: unable to mmap /dev/kmem
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/01/2007 17:52:46,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/01/2007 17:52:47,
	Serialize complete at 18/01/2007 17:52:47
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Trying to mmap /dev/kmem with an offset I take from /boot/System.map, I 
get an EIO error on a 2.6.20-rc4.
This is something that used to work on older kernels.

Had a look at mmap_kmem() in drivers/char/mem.c, and I'm wondering 
whether pfn is correctly computed there: shouldn't we have something like

pfn = PFN_DOWN(virt_to_phys((void *)PAGE_OFFSET)) +
       __pa(vma->vm_pgoff << PAGE_SHIFT);

instead of

pfn = PFN_DOWN(virt_to_phys((void *)PAGE_OFFSET)) + vma->vm_pgoff;

Or may be should I substract PAGE_OFFSET from the value I get from 
System.map before mmapping /dev/kmem?

Thanks for your help

Regards,
Nadia




