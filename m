Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUE1Jip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUE1Jip (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbUE1Jim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:38:42 -0400
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:51037 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S262398AbUE1Jh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:37:57 -0400
Message-ID: <40B7086D.9010904@ThinRope.net>
Date: Fri, 28 May 2004 18:37:49 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: "David N. Welton" <davidw@eidetix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: boot from usb flash - wake boot process when disk is ready?
References: <40B700F2.80208@eidetix.com>
In-Reply-To: <40B700F2.80208@eidetix.com>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David N. Welton wrote:
> [ Please CC replies to me - thanks! ]
> 
> Hi,
> 
> We're toying around with the idea of booting an embedded system off of 
> USB flash (pros, cons, and advice about this would be appreciated, by 
> the way), and I had a look at several of the existing patches to do this 
> without going through the process of creating an initrd image.  That 
> adds complexity and time to the boot process that we would prefer to 
> avoid, although it appears that the kernel folks in the first thread 
> cited are in favor of initrd....
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.3/1182.html
> 
> This mentions a couple of patches, both the "keep looping until it 
> works" one, which I couldn't get working with 2.6.6, and Willy Tarreu's 
> "wait a given period of time before continuing" patch:
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0405.0/0224.html
> 
> I don't think either of those approaches are particularly elegant... 
> although I'm sure my own efforts are good for a snort as well.
I tried this with 2.6.6 and modified it a bit, but to no avail.
It seems that the sd driver initializes the disk long before the wait
and does not bother anymore.

> In genhd.c I wake up a waitqueue when the disk comes on line.    The 
> init process waits on this before going on with prepare_namespace(). 
> Ideally, this would look and make sure it's the right disk, that 
> selected for the root fs:-)  Not being very familiar with the 'lay of 
> the land' in the kernel, I declared the wait queue as a global in 
> genhd.c.  The thing I don't like about this approach is that it builds a 
> connection between two bits of the kernel that seem separate... maybe 
> (ok, quite probably) there is a better/cleaner way of doing this?
> 
> Patch is at: http://dedasys.com/freesoftware/files/usb-wakeup.patch

Looks OK to me to try, but I am far from expert here.
Unfortunately I cannot test it in the next few days :-(
May be later.

I am in a search for non-initrd USB-booting as well...

Keep the discussion on LKML as well.

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
