Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbVJ0R5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVJ0R5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 13:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVJ0R5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 13:57:11 -0400
Received: from smtp.preteco.com ([200.68.93.225]:8843 "EHLO smtp.preteco.com")
	by vger.kernel.org with ESMTP id S1751369AbVJ0R5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 13:57:10 -0400
Message-ID: <436114C0.4000701@rhla.com>
Date: Thu, 27 Oct 2005 15:56:16 -0200
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@rhla.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Panic + Intel SATA
References: <435FC886.7070105@rhla.com>	 <Pine.LNX.4.61.0510261523350.6174@chaos.analogic.com>	 <4360261E.4010202@rhla.com> <436026F2.1030206@rhla.com>	 <Pine.LNX.4.61.0510270839130.9512@chaos.analogic.com>	 <1130420072.10604.37.camel@localhost.localdomain>	 <4360E217.7000700@rhla.com> <1130430478.17679.0.camel@localhost>
In-Reply-To: <1130430478.17679.0.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>>If you are using LVM2 or MD you just need to be sure you have the right
>>>config options enabled (the Red Hat src.rpm is a good guide).
>>>
>>>Alan
>>> 
>>>
>>>      
>>>
>>I'm not using lvm or raid in the /root or the /boot partition. All 
>>partitions was made directly in the disk and formated with ext3 file 
>>system. I think all needed options was compiled in the new kernel, since 
>>I copied the /boot/config-2.6.12-1.1456_FC4 (config file from the kernel 
>>that works fine) and compiled the kernel.src.rpm without any 
>>modifications in the config file, and it still not working.
>>    
>>
>
>You also created a new initrd with mkinitrd ?
>  
>
Yes, I created it. I also extracted the initrd image and compared it 
with a initrd that works fine (the initrd-2.6.12-1.1456_FC4.img initrd 
image provided by the kernel-2.6.12-1.1456_FC4.i386.rpm kernel package) 
and the images have the same files.

I got the mkinitrd-5.0.8-1 package and the 
kernel-devel-2.6.12-1.1456_FC4.i686.rpm package too. I compiled the 
mkinitrd package with the command:

# rpmbuild --rebuild mkinitrd-5.0.8-1.src.rpm
# rpm -ivh /usr/src/redhat/RPMS/i386/mkinitrd-5.0.8-1.i386.rpm

I also changed parameters in the kernel.spec file and recompiled it. The 
parameters was changed from:

%define buildsmp 1
...
%patch800 -p1

To:

%define buildsmp 0
...
# %patch800 -p1

(the nonint patch was generating error messages during the kernel rpm 
compilation)

# rpmbuild --target i686 -ba /usr/src/redhat/SPECS/kernel.spec
# rpm -ivh /usr/src/redhat/RPMS/i686/kernel-2.6.12.ext3-2.i686.rpm

After I finished the process, I booted the machine and got the same 
error message. I also rebuilt the initrd image and built a new 2.6.13 
fedora core src.rpm kernel, but it still not working... any more idea??

Thank you.

Márcio.
