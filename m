Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUJONvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUJONvY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUJONub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:50:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22656 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267776AbUJONrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:47:46 -0400
Date: Fri, 15 Oct 2004 09:47:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephan <support@bbi.co.bw>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: ERROR: /bin/insmod exited abnormally!
In-Reply-To: <002c01c4b2ba$a7d5bbc0$0200060a@STEPHANFCN56VN>
Message-ID: <Pine.LNX.4.61.0410150935440.24590@chaos.analogic.com>
References: <002c01c4b2ba$a7d5bbc0$0200060a@STEPHANFCN56VN>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Stephan wrote:

> Hi there,
>
> System Configuration...
> LSI Megaraid 320-1 SCSI Card
> Redhat ES 3 , build 3
> Boot loader : lilo
>
> I'm running Redhat ES 3 release and after much struggle finally  succeeded in 
> compiling the kernel successfully.... I hope :). I'm getting the following 
> problems after I've rebooted the system on the newly installed kernel.
>
> Now I've done some reading on google about this and the only thing I could 
> find was that I should try to change (append="root=LABEL=/") to the actual 
> device name where root can be found. I got the same affect.....
>
> Any ideas would be apreciated.
>
> <------------------------------error----------------------------------->
> ERROR: /bin/insmod exited abnormally!
> Loading sd_mod.ko module
> insmod QM_MODULES:
>

Your insmod may need updating (the one used by initrd).
As you can see, it was unable to load even the first
module necessary to eventually access your root file-system.

The new kernel has QUERY_MODULES removed (don't ask why, normally
there would be some kind of compatibility-overlap). So, your
older `insmod` or `insmod.static` is trying to use the old-
method of loading modules.

[SNIPPED...]

You may not be able to recover easily. I found that I needed
to rebuild the kernel with the necessary SCSI drivers in the
kernel. This would allow me to boot and mount a root file-system.
Save the previous kernel ".config" file. You must rebuild
with the 'loop' device in the kernel as well (or else you
can't make a new initrd RAM disk).

Then you can install the new modutils package.

Then you can change back to the previous configuration with
`make clean ; make oldconfig`....etc. Rebuild the kernel,
install and boot happy.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

