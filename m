Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVJXKsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVJXKsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 06:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVJXKsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 06:48:47 -0400
Received: from mail.ncipher.com ([82.108.130.24]:38586 "EHLO mail.ncipher.com")
	by vger.kernel.org with ESMTP id S1750856AbVJXKsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 06:48:47 -0400
Message-ID: <435CBBFF.7000704@f0rmula.com>
Date: Mon, 24 Oct 2005 11:48:31 +0100
From: James Hansen <linux-kernel-list@f0rmula.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: Information on ioctl32
References: <4358CF73.3020602@f0rmula.com> <200510231603.58364.arnd@arndb.de> <435CA241.8050605@f0rmula.com> <200510241132.45334.arnd@arndb.de>
In-Reply-To: <200510241132.45334.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I'll explain a little more about I'm doing.

The kernel I'm running is the default kernel from the (unofficial) 
debian amd64 distro.  uname says it's 2.6.8-11-amd64-generic.  When 
running a 32bit app, linked against the 32bit libraries, calling a 64bit 
driver in, the kernel logs messages saying something along the lines of 
"ioctl32 not defined".

The headers I'm building my modules against are from the package 
'kernel-headers-2.6.8-11-amd64-generic' which leaves me with the 
directory 'kernel-headers-2.6.8-11-amd64-generic' in /usr/src. 

My problem is that when I look in the headers at the file_operations 
struct for compat_ioctl there's no entry there, and I therefore can't 
define a function for it.  I had no idea there was a dynamic system in 
place before what's mentioned on lwn.  I'd assumed that as my kernel was 
trying to call ioctl32, that it would have had the patch applied, and 
it's headers should have contained an appropriate entry in file_operations.

So it looks like I'll have implement both ways of doing things, one for 
pre-2.6.11 and another for post 2.6.11 kernels.

Would you know of anywhere else I could look for information on the 
dynamic method you mentioned that existed in kernels before 2.6.11.

Thanks for the help btw.  Much appreciated.

James

Arnd Bergmann wrote:

>On Maandag 24 Oktober 2005 10:58, James Hansen wrote:
>  
>
>> From what they say over on lwn.net, I need to apply a patch, but my 
>>current kernel (debian for amd64) is already trying to call it ioctl32.
>>    
>>
>
>No, you should not need to apply any patch, the compat_ioctl
>infrastructure has been in there since 2.6.11. The old dynamic
>ioctl32 subsystem has been removed for 2.6.14.
>
>  
>
>>Problem is, the kernel headers don't seem to have an entry in the 
>>file_operations struct for compat_ioctl.  Does anyone know if there's 
>>any other place (struct) I should be looking to put this function?
>>
>>I thought it a bit odd that the prebuilt default kernel is trying to 
>>call this function, but the headers for this kernel don't seem to allow 
>>me to insert it into the fops struct.
>>    
>>
>
>You seem to be mixing up stuff. Are you looking at the headers in
>the kernel source tree or another copy? Are you sure you are running
>a recent kernel level?
>
>	Arnd <><
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>  
>

