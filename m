Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316637AbSGGXVc>; Sun, 7 Jul 2002 19:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316644AbSGGXVb>; Sun, 7 Jul 2002 19:21:31 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14037 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316637AbSGGXVa>;
	Sun, 7 Jul 2002 19:21:30 -0400
Message-ID: <3D28CD73.9000601@us.ibm.com>
Date: Sun, 07 Jul 2002 16:23:31 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.LNX.4.44.0207071702120.10105-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> On Sun, 7 Jul 2002, Dave Hansen wrote:
> 
>>Old Blue?  23 isn't _that_ old!
> 
> Obviously, you never read that book about the IBM s/370 named
> "Old Blue"...

Nope.  I missed that one.  Something like "The Little Mainfraime that 
could?"

>>BKL use isn't right or wrong -- it isn't a case of creating a deadlock 
>>or a race.  I'm picking a relatively random function from "grep -r 
>>lock_kernel * | grep /usb/".  I'll show what I think isn't optimal 
>>about it.
>>
>>"up" is a local variable.  There is no point in protecting its 
>>allocation.  If the goal is to protect data inside "up", there should 
>>probably be a subsystem-level lock for all "struct uhci_hcd"s or a 
>>lock contained inside of the structure itself.  Is this the kind of 
>>example you're looking for?
> 
> So the BKL isn't wrong here, but incorrectly used?

Not even incorrect, but badly used.  But, this was probably another 
VFS push.

> Is it really okay to "lock the whole kernel" because of one struct file? 
> This brings us back to spinlocks...

Don't think of it as locking the kernel, that isn't really what it 
does anymore.  You really need to think of it as a special spinlock.

> You're possibly right about this one. What did Greg K-H say?

Only time will tell...

-- 
Dave Hansen
haveblue@us.ibm.com

