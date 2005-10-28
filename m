Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVJ1OwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVJ1OwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVJ1OwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:52:17 -0400
Received: from [213.8.54.133] ([213.8.54.133]:24986 "EHLO fw.netmor.com")
	by vger.kernel.org with ESMTP id S1030202AbVJ1OwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:52:17 -0400
Message-ID: <43623B1B.50309@weizmann.ac.il>
Date: Fri, 28 Oct 2005 16:52:11 +0200
From: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en, ru, he
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
References: <4360C0A7.4050708@weizmann.ac.il> <200510280726.56684.rob@landley.net> <4362248C.3060401@weizmann.ac.il> <200510280850.40609.rob@landley.net>
In-Reply-To: <200510280850.40609.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> You're forgetting the cacheing (dentry and page caches).
> 
> We have a writeable filesystem mounted on a read-only block device.  This is 
> an impossible situation we should never have gotten into in the first place.  
> That's the bug.
> 
> For performance reasons, the write stuffs the data into the page cache, and 
> returns long before the system even attempts to write the data to disk.  
> (Unless you mount the filesystem O_SYNC, which will kill performance.)

You're right, when I mount the floppy with "-o sync", touch fails 
immediately (I did try earlier sync(1), as somebody suggested, and it 
didn't matter; yes, I know about the difference between sync(2) and 
fsync(2)). On the other hand, umount is supposed to flush all the data 
by the time it returns yet still it succeeded.

But overall I agree that we're discussing a situation which should never 
happen in the first place, i.e. remount should fail.

Regards,

Evgeny
