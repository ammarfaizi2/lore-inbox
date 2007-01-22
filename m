Return-Path: <linux-kernel-owner+w=401wt.eu-S1751421AbXAVMSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbXAVMSN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 07:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXAVMSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 07:18:13 -0500
Received: from lucidpixels.com ([66.45.37.187]:34377 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbXAVMSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 07:18:12 -0500
Date: Mon, 22 Jan 2007 07:18:10 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: kyle <kylewong@southa.com>
cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: change strip_cache_size freeze the whole raid
In-Reply-To: <001801c73e14$c3177170$28df0f3d@kylecea1512a3f>
Message-ID: <Pine.LNX.4.64.0701220717200.30260@p34.internal.lan>
References: <001801c73e14$c3177170$28df0f3d@kylecea1512a3f>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jan 2007, kyle wrote:

> Hi,
> 
> Yesterday I tried to increase the value of strip_cache_size to see if I can
> get better performance or not. I increase the value from 2048 to something
> like 16384. After I did that, the raid5 freeze. Any proccess read / write to
> it stucked at D state. I tried to change it back to 2048, read
> strip_cache_active, cat /proc/mdstat, mdadm stop, etc. All didn't return back.
> I even cannot shutdown the machine. Finally I need to press the reset button
> in order to get back my control.
> 
> Kernel is 2.6.17.8 x86-64, running at AMD Athlon3000+, 2GB Ram, 8 x Seagate
> 8200.10 250GB HDD, nvidia chipset.
> 
> cat /proc/mdstat (after reboot):
> Personalities : [raid1] [raid5] [raid4]
> md1 : active raid1 hdc2[1] hda2[0]
>      6144768 blocks [2/2] [UU]
> 
> md2 : active raid5 sdf1[7] sde1[6] sdd1[5] sdc1[4] sdb1[3] sda1[2] hdc4[1]
> hda4[0]
>      1664893440 blocks level 5, 512k chunk, algorithm 2 [8/8] [UUUUUUUU]
> 
> md0 : active raid1 hdc1[1] hda1[0]
>      104320 blocks [2/2] [UU]
> 
> Kyle
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Yes, I noticed this bug too, if you change it too many times or change it 
at the 'wrong' time, it hangs up when you echo numbr > 
/proc/stripe_cache_size.

Basically don't run it more than once and don't run it at the 'wrong' time 
and it works.  Not sure where the bug lies, but yeah I've seen that on 3 
different machines!

Justin.

