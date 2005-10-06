Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVJFJ1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVJFJ1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 05:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVJFJ1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 05:27:52 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:43146 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750758AbVJFJ1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 05:27:51 -0400
Message-ID: <4344EE14.2020504@cosmosbay.com>
Date: Thu, 06 Oct 2005 11:27:48 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: devesh sharma <devesh28@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [NUMA x86_64] problem accessing global Node List pgdat_list
References: <309a667c0510042240y1dcc75c4l83abc7fe430e4f05@mail.gmail.com>	 <4343CA4F.8030003@cosmosbay.com>	 <309a667c0510050550x68e0c996q51e00e908813b5c1@mail.gmail.com> <309a667c0510060216q315d55b0n4a6934d168ebccfb@mail.gmail.com>
In-Reply-To: <309a667c0510060216q315d55b0n4a6934d168ebccfb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 06 Oct 2005 11:27:48 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devesh sharma a écrit :
> Hi Eric,
> I have tried numa=fake=4 on intel xeon with 2.6.13 kernel it is
> working fine and by adding EXPORT_SYMBOL(pgdat_list)  in
> mm/page_alloc.c now I am able to access pgdat_list also. But on
> opteron machine there is some problem in kernel compilation
> at make install stage I am getting following warning
> 
> WARNING: No module mptbase found for kernel 2.6.13, continuing anyway
> WARNING: No module mptscsih found for kernel 2.6.13, continuing anyway
> 
> now when I boot my kernel, panic is received
> 
> Booting the kernel.
> Red Hat nash version 4.1.18 starting
> mkrootdev: lable / not found
> mount: error 2 mounting ext3
> mount: error 2 mounting none
> switchroot: mount failed : 22
> umount : /initrd/dev failed : 22
> kernel panic - not syncing : Attempted to kill init
> 
> On the other hand when I complie same source code on XEON machine this
> works fine.
> 
> what could be the problem?

Hi Devesh

I believe you have basic kernel compilation problem :)

Your kernel cannot mount / because the boot loader was configured to find a 
root=LABEL=/
As this is a RedHat kernel extension, your self compiled 2.6.13 kernel cannot 
understand this.
You should change your lilo/grub config to match your root device as 
root=/dev/hda2  (if hda2 is your root device)

Also check that your kernel (or initrd) contains the disk driver you need.

Eric


