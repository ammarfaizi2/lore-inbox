Return-Path: <linux-kernel-owner+w=401wt.eu-S932160AbXARLta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbXARLta (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 06:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbXARLta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 06:49:30 -0500
Received: from mail.syneticon.net ([213.239.212.131]:37398 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197AbXARLt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 06:49:29 -0500
Message-ID: <45AF5E8E.9020607@wpkg.org>
Date: Thu, 18 Jan 2007 12:48:30 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061110 Mandriva/1.5.0.8-1mdv2007.1 (2007.1) Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
References: <45AE1D65.4010804@wpkg.org> <Pine.LNX.4.61.0701171435060.18562@yvahk01.tjqt.qr> <45AE2E25.50309@wpkg.org> <45AE8818.1050803@zytor.com> <45AF4CF9.1070801@wpkg.org> <45AF502F.9010009@zytor.com>
In-Reply-To: <45AF502F.9010009@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Tomasz Chmielewski wrote:
>> H. Peter Anvin wrote:
>>> Tomasz Chmielewski wrote:
>>>>
>>>> All right.
>>>> I see that initramfs is attached to the kernel itself.
>>>>
>>>> So it leaves me only a question: will I fit all tools into 300 kB 
>>>> (considering I'll use uClibc and busybox)?
>>>>
>>>
>>> You don't need to use busybox and have a bunch of tools.
>>>
>>> The klibc distribution comes with "kinit", which does the equivalent 
>>> to the kernel root-mounting code; it's in the tens of kilobytes, at 
>>> least on x86.  If you're using ARM, you can compile it as Thumb.
>>
>> Hmm, I'm having problems compiling klibc-1.4 on ARM (using gcc-4.1.1):
>>
> 
> Could you send me your kernel .config, as well as what version of the 
> kernel you're building against?

I managed to compile a "Testing" 1.4.31 version (in fact, version 1.4 
didn't compile because I didn't have a "linux" link pointing to kernel 
sources; version 1.4.31 tells that it's missing - so both versions 
compile fine).

The problem is... I'm not sure how to start with it. The package doesn't 
have much documentation (other than "read the source"), does it?

On the other hand, I see it comes with a couple of useful tools, like sh 
(dash)... They are also pretty small, so everything should fit into 300 
kB (dash=70kB, kinit=70kB, mount=12kB).

As I understand, this is what I have to do:

1. compile a kernel with initramfs, which will include a cpio image with 
some tools

2. tools/scripts in cpio image should do the following:

mount /proc
DISKS=$(cat /proc/diskstats)
for WORD in $DISKS
do
[ $WORD = sdb1 ] && echo "partition found, what next?..."
done

# do a similar logic for sda1


Am I correct? Of course I'd appreciate how to achieve point 2 (where now 
"partition found, what next?..." is).


-- 
Tomasz Chmielewski
http://wpkg.org

