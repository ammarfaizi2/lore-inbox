Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316666AbSGGXnP>; Sun, 7 Jul 2002 19:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSGGXnO>; Sun, 7 Jul 2002 19:43:14 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2764 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316666AbSGGXnN>;
	Sun, 7 Jul 2002 19:43:13 -0400
Message-ID: <3D28D291.3020706@us.ibm.com>
Date: Sun, 07 Jul 2002 16:45:21 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.name>
CC: Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.LNX.4.44.0207071702120.10105-100000@hawkeye.luckynet.adm> <200207080131.06119.oliver@neukum.name>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
 >>> "up" is a local variable.  There is no point in protecting its
 >>> allocation.  If the goal is to protect data inside "up", there
 >>> should probably be a subsystem-level lock for all "struct
 >>> uhci_hcd"s or a lock contained inside of the structure itself.
 >>> Is this the kind of example you're looking for?
 >>
 >> So the BKL isn't wrong here, but incorrectly used?
 >
 > The BKL, unless used unbalanced, can never cause a bug. It could be
 > insufficient or superfluous, but never be really buggy in itself.

Does incredibly high lock contention qualify as a bug?

 >> Is it really okay to "lock the whole kernel" because of one
 >> struct file? This brings us back to spinlocks...
 >>
 >> You're possibly right about this one. What did Greg K-H say?
 >
 > I don't speak for Greg, but in this example it could be dropped
 > IMO. The spinlock protects the critical section anyway. As a rule,
 > if you do a kmalloc without GFP_ATOMIC under BKL you are doing
 > either insufficient locking (you may need a semaphore) or useless
 > locking.

Don't forget that the BKL is released on sleep.  It is OK to hold it
over a schedule()able operation.  If I remember right, there is no 
real protection needed for the file->private_data either because there 
is 1 and only 1 struct file per open, and the data is not shared among 
struct files.

 > This should have been posted on linux-usb long ago.

I just pulled it out of thin air 10 minutes ago!

-- 
Dave Hansen
haveblue@us.ibm.com

