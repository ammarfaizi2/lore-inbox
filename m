Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSGDXhQ>; Thu, 4 Jul 2002 19:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSGDXhP>; Thu, 4 Jul 2002 19:37:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:20868 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314680AbSGDXhO>;
	Thu, 4 Jul 2002 19:37:14 -0400
Message-ID: <3D24DC8C.4060801@us.ibm.com>
Date: Thu, 04 Jul 2002 16:38:52 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] remove BKL from driverfs
References: <3D23EA93.7090106@us.ibm.com> <20020704071004.GI29657@kroah.com> <3D23F88C.2050502@us.ibm.com> <20020704222357.GD418@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing Al for comments...

Greg KH wrote:
> bleah, a proliferation of a zillion little spinlocks all across the
> kernel is not my idea of fun :(

A zillion locks each with a single purpose is a lot more fun than 1 
lock with a zillion different uses.

> I don't know if a simple spinlock can help us here.  Look at
> driverfs_get_inode() and follow that into the vfs layer.  Make sure all
> of that is race safe (and isn't currently relying on the BKL.)  I'll
> defer to Al Viro's opinion about this, as I don't quite know all of the
> side effects going on at this moment in time.

OK, I agree a simple spinlock is not the way to go because I now see 
the sleepable operations in there.  But, I don't think 
driverfs_get_inode() needs any more locking.  The inode that it 
references is freshly allocated and my only concern would be about 
access from the inode_in_use list.  Maybe down()ing i_sem will provide 
a bit more protection, but unless the access through inode_in_use is 
already a problem, i_sem isn't needed.  Any thoughts, Al?

-- 
Dave Hansen
haveblue@us.ibm.com

