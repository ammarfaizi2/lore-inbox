Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbRCWHKF>; Fri, 23 Mar 2001 02:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRCWHJz>; Fri, 23 Mar 2001 02:09:55 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:34502 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129828AbRCWHJu>; Fri, 23 Mar 2001 02:09:50 -0500
Message-ID: <3ABAF64A.1040106@muppetlabs.com>
Date: Thu, 22 Mar 2001 23:07:54 -0800
From: Amit D Chaudhary <amit@muppetlabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
CC: lermen@fgan.de, linux-kernel@vger.kernel.org
Subject: Re: /linuxrc query
In-Reply-To: <3ABAEED2.6020708@muppetlabs.com> <20010323075107.Q3932@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Also as a note, what we are doing is keeping our rootfs on flash as a tar.gz and 
reading it and mounting it on a ramfs in the /linuxrc before doing a pivot_root. 
To summarize, pivot_root has been a life saver as the earlier real_root_dev 
might not have been useful in this case.
Not using the ramfs limits for now, will do soon.

Thanks
Amit

Werner Almesberger wrote:

> Amit D Chaudhary wrote:
> 
>> what does redirecting stdin\stdout\stderr to dev/console achieve? I thought 
>> since the root is now the "new" root, dev/console will be used automatically?
> 
> 
> No, you would continue using the file descriptors which are already
> open, i.e. on /dev/console on the old root.
> 
> 
>> Also, why chroot, why not call init directly?
> 
> 
> To make sure the root of the current process is indeed changed.
> pivot_root currently forces a chroot on all processes (except the
> ones that have explicitly moved out of /) in order to move all the
> kernel threads too, but this is not a nice solution. Once a better
> solution is implemented for the kernel threads, we might drop the
> forced chroot, and then the explicit chroot here becomes important.
> 
> 
>> Since the above never returns, what follows in not freed.
> 
> 
> You can run them later, e.g. /etc/rc.d/rc.local
> Or, if you needs the space immediately,  make "what-follows" a
> script than first frees them, and then exec's init.
> 
> - Werner

