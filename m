Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261984AbSJ0ARa>; Sat, 26 Oct 2002 20:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbSJ0ARa>; Sat, 26 Oct 2002 20:17:30 -0400
Received: from hermes.domdv.de ([193.102.202.1]:64786 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S261984AbSJ0AR3>;
	Sat, 26 Oct 2002 20:17:29 -0400
Message-ID: <3DBB31D6.90207@domdv.de>
Date: Sun, 27 Oct 2002 02:22:46 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: rootfs exposure in /proc/mounts
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu> <3DBAE931.7000409@domdv.de> <3DBAEC79.5050605@pobox.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andreas Steinmetz wrote:
> 
>> Alexander Viro wrote:
>>
>>>
>>> On Sat, 26 Oct 2002, Andreas Steinmetz wrote:
>>>
>>>
>>>> Maybe I do oversee the obious but:
>>>>
>>>> can somebody please explain why rootfs is exposed in /proc/mounts (I 
>>>> do mean the "rootfs / rootfs rw 0 0" entry) and if there is a good 
>>>> reason for the exposure?
>>>
>>>
>>>
>>>
>>> Mostly the fact that it _is_ mounted and special-casing its removal from
>>> /proc/mounts is more PITA than it's worth.
>>>
>> Acceptable but somewhat sad as it confuses e.g. "umount -avt noproc" 
>> which is somewhat standard in shutdown/reboot scripts (using a 
>> softlink from /etc/mtab to /proc/mounts).
> 
> 
> 
> Bug 1 - don't softlink directly to /proc/mounts :)  embedded guys 
> typically do this, and you see why it bites you in the ass :)
> 
> Bug 2 - "noproc" clearly does not avoid ramfs mounts, which is rootfs's 
> filesystem type.  And more and more ramfs filesystems will be appearing, 
> so that should be taken into consideration.
> 
> Sounds like userspace slackness to me, and nothing that the kernel guys 
> need to worry about...
> 
Only if there's another method to retrieve all filesystems mounted from 
userspace from the kernel. Though this may not be your view of things it 
is the only way to ensure that one gets a valid mount list. And as 
/proc/mounts is an interface to userspace it is my opinion that in 
kernel private mounts that can't be modified from userspace don't need 
to be listed there. Not my decision, anyway.

