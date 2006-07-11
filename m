Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbWGKFUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWGKFUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 01:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWGKFUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 01:20:52 -0400
Received: from 1wt.eu ([62.212.114.60]:15882 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S965172AbWGKFUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 01:20:52 -0400
Date: Tue, 11 Jul 2006 07:20:40 +0200
From: Willy Tarreau <w@1wt.eu>
To: Tony Borras <tonyb@thekrnl.sysdev.org>
Cc: linux-kernel@vger.kernel.org, gmorris@toyecorp.com
Subject: Re: Memory tables corruption - kernel v2.4.33-rc1
Message-ID: <20060711052040.GE2037@1wt.eu>
References: <20060710203938.134a4d16.tonyb@sysdev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710203938.134a4d16.tonyb@sysdev.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 10, 2006 at 08:39:38PM -0800, Tony Borras wrote:
> Please fwd to 2.4.33 Team.
> 
> One of my customers reported in tests that, after some runtime,
> his 59MB ram drive suddenly, randomly shrinks.
> 
> Same customer s/w has been running fine with 2.4.31 kernel.
> 
> 
> Report follows:
> 
> I have two Advantech (i486 Geode's w/64MB ram, ~49MB usable, as
> configured in the kernel make) test units where Dosemu crashed
> this weekend. For some reason the Via unit was fine.
> 
> Here is what happened:
> 
> 1. Linux was O.K., dosemu 1.3.2 had shut down.
> It appears both units were out of RAM.
> 
> 2. The first unit showed the RAM drive size to be
> 14661 1k blocks using the df command. The 1K blocks
> should be 47595, as they were after boot. The other unit
> showed the correct value of 1K blocks=47595. Even after
> restarting the Advantech, the 1K blocks would not go back to
> normal, so my software cannot even load.
> 
> 3. The second Advantech unit showed correct values with the df
> command, but when I used the du -cbs command, I found the /tmp
> directory had only 110796 bytes, instead of the normal ~15 MB.
> When I restarted Linux, all the RAM came back, and the
> unit started working again.
> 
>                               ---------
> 
> Thanks, I will check further with this customer.

2.4.33-rc1 has a bug in vfs_unlink(). Probably you've been hitting
it when removing lots of files from /tmp which might not have been
really freed. -rc2 has this fixed. You should try it instead. Other
people reported kernel panics on -rc1 with NFS.

> Tony Borras

Regards,
Willy

