Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWAGKKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWAGKKV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 05:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWAGKKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 05:10:21 -0500
Received: from mail.gmx.de ([213.165.64.21]:39376 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030392AbWAGKKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 05:10:20 -0500
X-Authenticated: #4368190
Message-ID: <43BF938A.1080209@gmx.de>
Date: Sat, 07 Jan 2006 11:10:18 +0100
From: =?ISO-8859-1?Q?Hans-J=FCrgen_Lange?= <Hans-Juergen.Lange@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.x on IBM thin client 8363
References: <43BD0E1C.9060705@gmx.de>	<20060105191819.594767e0.rdunlap@xenotime.net>	<43BE34BB.70309@gmx.de> <20060106152121.18f2afe0.rdunlap@xenotime.net>
In-Reply-To: <20060106152121.18f2afe0.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Fri, 06 Jan 2006 10:13:31 +0100 Hans-Jürgen Lange wrote:
> 
> 
>>Randy.Dunlap wrote:
>>
>>>On Thu, 05 Jan 2006 13:16:28 +0100 Hans-Jürgen Lange wrote:
>>>
>>>
>>>
>>>>Hello,
>>>>
>>>>I would like to run a 2.6.x kernel on a IBM thin client 8363. There are 
>>>>patches available for the 2.4 series of kernels.
>>>>I had a look on these patches and the only thing they do is to expand 
>>>>the kernel commandline size to 512 Bytes and a change in 
>>>>arch/i386/kernel/head.S that changed the pointer to the commandline to a 
>>>>fixed address.
>>>
>>>
>>>Where are these 2.4 patches that you are referring to?
>>>
>>
>>O.K. this is the very important one. Because without it the 8363 wont start.
> 
> 
> Sorry, I have no idea about this patch.
> Where did you get these 2.4 patches?  are there others?
>

These are original IBM patches to the linux kernel to get the kernel 
running on there thin client. There are some others, which fixes some 
oddities in the hardware. The thin client is about 99% pc compatible. It 
  lacks of a realtime clock, so IBM has a patch to get the time from 
within the NFS protocol.
There are some more but they are not importent to get the kernel up and 
running.

> It looks a little like it may be dependent on your boot loader.
> What boot loader are you using?
> 

The boot process is very different and has nothing to do with that one 
on a PC. The method I use mounts a NFS share, downloads the kernel and 
does the unmount. Afterwards the kernel gets started.
The kernel commandline parameters are passed  from within the firmware.
Besides, the firmware itself is aware that it has to load a linux kernel.
The patch below sets a fixed value for the address where the commandline 
resides. This is not my problem to understand.

But to transfer this handling to the 2.6. kernel I need a real 
understanding of how the 2.4 kernel does commandline handling and how it 
has changed in 2.6 kernels. Then it seems possible to change the 2.6 
startup code to get the 2.6 kernel running on a 8363 Thin-Client.

> 
> 
>>--- linux/arch/i386/kernel/head.S.orig	Mon Jul 16 16:13:11 2001
>>+++ linux/arch/i386/kernel/head.S	Mon Jul 16 16:14:26 2001
>>@@ -158,7 +158,10 @@
>>  	movl $512,%ecx
>>  	rep
>>  	stosl
>>-	movl SYMBOL_NAME(empty_zero_page)+NEW_CL_POINTER,%esi
>>+/* NetVista */
>>+/*	movl SYMBOL_NAME(empty_zero_page)+NEW_CL_POINTER,%esi */
>>+	movl $0x98000, %esi
>>+
>>  	andl %esi,%esi
>>  	jnz 2f			# New command line protocol
>>  	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR
> 
> 
> 
> ---
> ~Randy
> 
> 



BR
Hans-Juergen Lange
