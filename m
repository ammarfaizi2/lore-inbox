Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266447AbUAIIjs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 03:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266448AbUAIIjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 03:39:48 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:33287 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S266447AbUAIIjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 03:39:44 -0500
Message-ID: <3FFE6B8F.60502@aitel.hist.no>
Date: Fri, 09 Jan 2004 09:51:27 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
References: <E1Aeab1-0009FQ-00.arvidjaar-mail-ru@f20.mail.ru>
In-Reply-To: <E1Aeab1-0009FQ-00.arvidjaar-mail-ru@f20.mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
>>So, how does devfs stack up to the above problems and constraints:
>>  Problems:
>>    1) devfs only shows the dev entries for the devices in the system.
> 
> 
> Is this a problem? Where exactly this problem lies?
> 

Some people like to unload their (modular) devices so they don't use
memory when not in use.  This saves them a few kB.
It is then useful to have the device node sitting there anyway, functioning
as a trigger.  The kernel will autoload the module when the device is opened,
but that won't happen if there's no device node to open.

This approach can be made to work with devfs too - by splitting the device
into two pieces.  One that manages the device node, and autoloads the rest
when needed.


> 
>>    2) devfs does not handle the need for dynamic major/minor numbers
> 
> 
> Neither does udev. Both take whatever driver gives them.
> 
> 
>>    3) devfs does not provide a way to name devices in a persistent
>>       fashion.
> 
> 
> I am not sure what exactly you mean here.
> 
Probably something like
mv /dev/hda /dev/mydisk
and have it remembered upon the next reboot.  devfsd can do that though.

> 
>>    4) devfs does provide a deamon that userspace programs can hook > into
>>       to listen to see what devices are being created or removed.
>>  Constraints:
>>    1) devfs forces the devfs naming policy into the kernel.  If you
>>       don't like this naming scheme, tough.
> 
> 
> kernel imposes naming scheme for exporting devices in sysfs. It is
> possible to get rid of devfs_name in kernel and use those names
> that must exist anyway to support udev as well. devfs has
> devfsd that can call whatever naming agent you like.
> 
> 
>>    2) devfs does not follow the LSB device naming standard.
> 
> 
> it is user-space (devfsd) issue, not kernel space (devfs)
> 
> 
>>    3) devfs is small, and embedded devices use it.  However it is
>>       implemented in non-pagable memory.
> 
> 
> Same for sysfs. Other Unices have pageable kernel memory. If Linux
> had it any memory based filesystem could benefit from it. I did not
> look at backing store for sysfs patches but it is likely that same
> idea could be used for devfs.
> 
> 
>>Oh yeah, and there are the insolvable race conditions with the devfs
>>implementation in the kernel, but I'm not going to talk about them > right
> 
> 
> I do not argue that current devfs implementation is ugly and racy. I
> just beg you to point at what makes those races "unsolvable".
> 
They are of course not unsolvable.  Those understanding them seems
to believe that a complete rewrite will be easier than the rather
invasive changes necessary to fix the races.  This is why the
_current implementation_ is marked obsolete.  Nobody is volunteering
to fix devfs or rewrite it though.


Helge Hafting

