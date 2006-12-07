Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163434AbWLGVlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163434AbWLGVlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163437AbWLGVlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:41:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:37302 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163434AbWLGVle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:41:34 -0500
Message-ID: <45788A56.9010706@us.ibm.com>
Date: Thu, 07 Dec 2006 13:40:38 -0800
From: Haren Myneni <haren@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: Michael Neuling <mikey@neuling.org>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@ftp.linux.org.uk>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Fastboot] [PATCH] free initrds boot option
References: <4410.1165450723@neuling.org>	<20061206163021.f434f09b.akpm@osdl.org> <4577624A.6010008@zytor.com>	<13639.1165462578@neuling.org> <20061207164756.GA13873@in.ibm.com>
In-Reply-To: <20061207164756.GA13873@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:

>On Thu, Dec 07, 2006 at 02:36:18PM +1100, Michael Neuling wrote:
>  
>
>>>I would have to agree with this; it also seems a bit odd to me to have
>>>this at all (kexec provides a new kernel image, surely it also
>>>provides a new initrd image???)
>>>      
>>>
>
>Yes, kexec provides the option --initrd, so that a user can supply an
>initrd image to be loaded along with kernel.
>
>  
>
>>The first boot will need to hold a copy of the in memory fs for the
>>second boot.  This image can be large (much larger than the kernel),
>>hence we can save time when the memory loader is slow.  Also, it reduces
>>the memory footprint while extracting the first boot since you don't
>>need another copy of the fs.
>>
>>    
>>
>
>Is there a kexec-tools patch too? How does second kernel know about
>the location of the first kernel's initrd to be reused?
>  
>
kexec-tools has to be modified to pass the first kernel initrd. On 
powerpc, initrd locations are exported using device-tree. At present, 
kexec-tool ignores the first kernel initrd property values and creates 
new initrd properties if the user passes '--initrd' option to the kexec 
command. So, will be an issue unless first kernel device-tree is passed 
as buffer.

>In general kexec can overwrite all the previous kernel's memory. It
>just knows about the segments the user has passed to it and it will
>place these segments to their destination locations. There are no
>gurantees that in this process some data from first kernel will not
>be overwritten. So it might not be a very safe scheme.
>  
>
Initrd memory can be excluded like other segments such as RTAS and TCE 
on powerpc. However it is not implemented yet even on powerpc and is an 
issue on other archs.

Thanks
Haren

>Thanks
>Vivek
>_______________________________________________
>fastboot mailing list
>fastboot@lists.osdl.org
>https://lists.osdl.org/mailman/listinfo/fastboot
>  
>

