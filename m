Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbTFFOoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTFFOoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:44:04 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:44649 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S261548AbTFFOoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:44:03 -0400
Message-ID: <3EE0AAC3.4090506@rackable.com>
Date: Fri, 06 Jun 2003 07:52:51 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Sheltraw <sheltraw@unm.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: recompiling RH9 with SCSI driver
References: <1054859772.3edfe1fcaaa6e@webdjn.unm.edu>
In-Reply-To: <1054859772.3edfe1fcaaa6e@webdjn.unm.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2003 14:57:36.0289 (UTC) FILETIME=[F775C910:01C32C3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Sheltraw wrote:

>Hello kernel list
>
>I knowm this is not really a kernel problem but I have been unable
>to get this problem solved on other lists. I am having trouble
>building a new 2.4.20 kernel on a machine running RedHat9 and
>it appears that the problem has something to do with the mptbase
>module (scsi module?).
>
>The machine is a Dell Precision 350 machine and lspci tells me this
>about my SCSI controller:
>
>02:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
>02:07.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
>
>
>I am trying to recompile my kernel but after when doing a "make install"
>I get the folloeing error message:
>
>sh -x ./install.sh 2.4.20-rthal5 bzImage /usr/src/linux-2.4.20/System.map ""
>+ '[' -x /root/bin/installkernel ']'
>+ '[' -x /sbin/installkernel ']'
>+ exec /sbin/installkernel 2.4.20-rthal5 bzImage
>/usr/src/linux-2.4.20/System.map ''
>No module mptbase found for kernel 2.4.20-rthal5
>mkinitrd failed
>make[1]: *** [install] Error 1
>make[1]: Leaving directory `/usr/src/linux-2.4.20/arch/i386/boot'
>make: *** [install] Error 2
>
>There does not exist a /lib/modules directory for my new modules
>and it looks like "make install" can't find the mptbase driver.
>Does any one know how to fix this?
>  
>

   You likely have the mpt module referenced in your /etc/modules.conf.  
Likely this is something like a scsi_hostadapter alias.  When the 
install script attempts to create an initrd it fails as it can't find 
the module in question.  This could be caused by one of several things.

1)You didn't compile support for the mpt driver at all.
2)You compiled the driver into the kernel instead of as a module.

  In the case of #2 commenting out the alias in modules.conf should 
"fix" your issue.  (Of course new kernel's from your vendor won't know 
to load the driver.)  Or you could just manually install the kernel.  In 
the case of #2 you really need to compile the mpt driver.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


