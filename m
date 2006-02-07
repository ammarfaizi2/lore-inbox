Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWBGXCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWBGXCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWBGXCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:02:00 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:12700 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030233AbWBGXB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:01:59 -0500
Message-ID: <43E926CA.3000601@us.ibm.com>
Date: Tue, 07 Feb 2006 15:01:30 -0800
From: Haren Myneni <haren@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linuxppc64-dev@ozlabs.org, Milton Miller <miltonm@bga.com>,
       hpa@zytor.com
Subject: Re: [PATCH] Fix in free initrd when overlapped with crashkernel region
References: <43E818EB.7010003@us.ibm.com> <17384.24235.960221.979322@cargo.ozlabs.ibm.com>
In-Reply-To: <17384.24235.960221.979322@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:

>Haren Myneni writes:
>
>  
>
>>--- 2616-rc2.orig/include/linux/kexec.h	2006-02-06 19:08:01.000000000 -0800
>>+++ 2616-rc2/include/linux/kexec.h	2006-02-06 19:06:37.000000000 -0800
>>@@ -6,6 +6,7 @@
>> #include <linux/list.h>
>> #include <linux/linkage.h>
>> #include <linux/compat.h>
>>+#include <linux/ioport.h>
>> #include <asm/kexec.h>
>>    
>>
>
>What's this hunk for?
>
>Paul.
>  
>

crashk_res is an extern declaration in kexec.h. Declared as "struct 
resource" which is defined in linux/ioport.h.
For other places wherever this variable is used, ioport.h got included 
through some other header file.  Whereas for initramfs.c, either we need 
to include ioport.h explicitly or include in kexec.h. Chosen the later 
one. Probably, some comment would be better to make it clear.

Paul, do you prefer to repost the patch with the comment?

Thanks
Haren

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

