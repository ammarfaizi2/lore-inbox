Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbULaULt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbULaULt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 15:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbULaULt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 15:11:49 -0500
Received: from terminus.zytor.com ([209.128.68.124]:45222 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262151AbULaULr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 15:11:47 -0500
Message-ID: <41D5B247.1080700@zytor.com>
Date: Fri, 31 Dec 2004 12:10:47 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, SYSLINUX@zytor.com
Subject: Re: [PATCH] /proc/sys/kernel/bootloader_type
References: <41D34E3A.3090708@zytor.com> <20041231013443.313a3320.akpm@osdl.org>
In-Reply-To: <20041231013443.313a3320.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> 
>>This patch exports to userspace the boot loader ID which has been 
>> exported by (b)zImage boot loaders since boot protocol version 2.
> 
> Why does userspace need to know this?
> 

In order to try to figure out what the boot medium was.  For some boot 
loaders, like grub, it could be more or less anything, but others, e.g. 
syslinux, knowing what the boot loader is lets you know what the medium was.

> 
>> --- linux-2.5/arch/i386/Makefile	24 Dec 2004 21:09:54 -0000	1.73
>> +++ linux-2.5/arch/i386/Makefile	28 Dec 2004 04:56:17 -0000
>> @@ -20,6 +20,10 @@
>>  LDFLAGS_vmlinux :=
>>  CHECKFLAGS	+= -D__i386__
>>  
>> +# This allows compilation with an x86-64 compiler
>> +CC_M32		:= $(call cc-option,-m32)
>> +CC 		+= $(CC_M32)
> 
> 
> Was this hunk deliberately a part of this patch?

No, that was a separate patch I submitted several weeks ago which was 
apparently still in that tree.  Would be good to get that patch into the 
tree, though; it allows an x86-64 setup to compile an i386 kernel with 
only make ARCH=i386.

	-hpa
