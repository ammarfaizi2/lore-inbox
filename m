Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVCLANb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVCLANb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVCLAMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 19:12:01 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:16298 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261811AbVCLAGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 19:06:23 -0500
Date: Fri, 11 Mar 2005 19:06:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: AGP bogosities
In-reply-to: <16946.9510.285579.725037@cargo.ozlabs.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@samba.org>, Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, benh@kernel.crashing.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503111906.21207.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
 <20050311222614.GH4185@redhat.com>
 <16946.9510.285579.725037@cargo.ozlabs.ibm.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 18:09, Paul Mackerras wrote:
>Dave Jones writes:
>> I'm fascinated that not a single person picked up on this problem
>> whilst the agp code sat in -mm. Even if DRI isn't enabled,
>> every box out there with AGP that uses the generic routines
>> (which is a majority), should have barfed loudly when it hit
>> this check during boot.  Does no-one read dmesg output any more ?
>
>That loop would only get executed when you enable AGP, which I think
>would generally only happen when starting X with DRI enabled.
>
>Paul.

Which I am doing here I believe, and my current dmesg ring does go 
back to the tail end of whats in /var/log/dmesg, but:  Its got a lot 
of crap about tainted kernels, AND its not by any means all from the 
stuff that pcHDTV-1.6 builds and inserts into the /var/modules/`name 
-r`/kernel/drivers etc etc directories. Its also bitching about 
nearly every i2c module loaded!  With lines along the general theme 
of this:
--------------
i2c_core: No versions for exported symbols. Tainting kernel.
i2c_algo_bit: No versions for exported symbols. Tainting kernel.
kobject_register failed for i2c_algo_bit (-17)
 [<c020d487>] kobject_register+0x57/0x60
 [<c012c3a0>] mod_sysfs_setup+0x50/0xb0
 [<c012d589>] load_module+0x889/0xb70
 [<c012d8c6>] sys_init_module+0x56/0x220
 [<c01026d9>] sysenter_past_esp+0x52/0x75
-----------
and yet, gkrellm, and sensors are both working quite nicely.  WTH?
I am rather certain that versioning info in the modules IS turned on 
in the .config:

However, a grep of .config makes a liar out of me, it is NOT set:

[root@coyote linux-2.6.11.2]# grep VERSION .config
CONFIG_LOCALVERSION=""
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set

Rebuild coming up. :(


>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
