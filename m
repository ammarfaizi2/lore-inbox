Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbRCWHCz>; Fri, 23 Mar 2001 02:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbRCWHCp>; Fri, 23 Mar 2001 02:02:45 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:64453 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129749AbRCWHCj>; Fri, 23 Mar 2001 02:02:39 -0500
Message-ID: <3ABAF49B.9080109@muppetlabs.com>
Date: Thu, 22 Mar 2001 23:00:43 -0800
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

Thanks for the response. PSB,

Werner Almesberger wrote:

> Amit D Chaudhary wrote:
> 
> No, you would continue using the file descriptors which are already
> open, i.e. on /dev/console on the old root.
So, makes sense. And the child process that follow will use now the new fd's.

>> Also, why chroot, why not call init directly?
> 
> 
> To make sure the root of the current process is indeed changed.
> pivot_root currently forces a chroot on all processes (except the
> ones that have explicitly moved out of /) in order to move all the
> kernel threads too, but this is not a nice solution. Once a better
> solution is implemented for the kernel threads, we might drop the
> forced chroot, and then the explicit chroot here becomes important.
So, it is not a requirement currently but it is useful to have the script not 
dependent on the current pivot_root implementation.


> You can run them later, e.g. /etc/rc.d/rc.local
> Or, if you needs the space immediately,  make "what-follows" a
> script than first frees them, and then exec's init.
Sure will put in a script that does it. I had left it in /linuxrc as I thought 
that's what initrd.txt suggested one to do. But other information in the 
initrd.txt mentions otherwise, hence the query here.

I am assuming umount and thereby blockdev after pivot_script and before "chroot 
. init ..." don't make sense as files(dev/console among others) are\might still 
be in use.

Best Regards
Amit


