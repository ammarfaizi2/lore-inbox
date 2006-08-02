Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWHBRva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWHBRva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWHBRva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:51:30 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:57757 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932115AbWHBRv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:51:29 -0400
Subject: Re: Problems with 2.6.17-rt8
From: Steven Rostedt <rostedt@goodmis.org>
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Bill Huey <billh@gnuppy.monkey.org>
In-Reply-To: <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
	 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 13:51:19 -0400
Message-Id: <1154541079.25723.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 22:37 -0700, Robert Crocombe wrote:
> Trying again.  Hopefully gmail will send as plain/text this time.
> Ingo CC'd on the version with the text/html subpart (sorry).
> 
> I've just stuck up the relevant stuff on my little webserver at:
> 
>  http://66.93.162.103/~rcrocomb/lkml/
> 
>  The files are:
> 
>  config_2.6.17-rt8_local_00
>  config_2.6.17-rt8_local_01
>  dmesg_2.6.17-rt8_local_00_00
>  linux_version_info
>  output_from_lspci
>  scooter_log
> 
>  which should largely be self-explanatory, I think.  The local_00
> kernel does not have much in the way of debugging info turned on,
> because I was hoping for peak performance.  local_01 has a bunch more
> debug widgets enabled:
> 
>  +CONFIG_DEBUG_PREEMPT=y
>  +CONFIG_PREEMPT_TRACE=y
>  +CONFIG_DEBUG_INFO=y
>  +CONFIG_FRAME_POINTER=y
>  +CONFIG_UNWIND_INFO=y
>  +CONFIG_FORCED_INLINING=y
>  +CONFIG_IOMMU_DEBUG=y
> 
>  in the hope of providing better/more info.  The machine is 'scooter',
> and scooter_log is the dump from 'cu' on another machine.  I decided
> not to trim anything, since I wasn't sure what might/might not be
> relevant.  Note that at first we were running with the nvidia kernel
> module, but removed that later (scooter_log6 line 7142 or therebouts)
> so as to test with an untainted kernel.  I wasn't sure if the problems
> w/ the module would be of interest or not.
> 
>  I can pretty much guarantee problems with a kernel compile or two in parallel.
> 
>  The machine is built around the new IWill H8502 motherboard.  It's a
> 4-way 2.8GHz Opteron machine with 8GB of RAM and two 150GB SCSI disks
> in a RAID5 setup.  The person doing development on this machine says
> the problems are basically constant.  I am using a very similar
> machine, but with dual video cards and 32GB of RAM, and haven't
> experienced any problems.  That machine, too, is using the nvidia
> module.  Oh, the underlying distribution is Fedora Core 5.
> 

I'm confused,

You mention problems but I don't see you listing what exactly the
problems are.  Just saying "the problems exist" doesn't tell us
anything.

Don't assume that we will go to some web site to figure out what you're
talking about. Please list the problems you are facing.

I only looked at the dmesg and saw this:

BUG: scheduling while atomic: udev_run_devd/0x00000001/1568

Call Trace:
       <ffffffff8045c693>{__schedule+155}
       <ffffffff8045f156>{_raw_spin_unlock_irqrestore+53}
       <ffffffff80242241>{task_blocks_on_rt_mutex+518}
       <ffffffff80252da0>{free_pages_bulk+39}
       <ffffffff80252da0>{free_pages_bulk+39}
       <ffffffff8045d3bd>{schedule+236}
       <ffffffff8045e1fe>{rt_lock_slowlock+327}
       <ffffffff80252da0>{free_pages_bulk+39}
       <ffffffff802531f0>{__free_pages_ok+408}
       <ffffffff80226665>{free_task+18}
       <ffffffff8045d113>{thread_return+200}
       <ffffffff8026cdba>{kfree+56}
       <ffffffff8026cdba>{kfree+56}
       <ffffffff8045d9a8>{preempt_schedule_irq+82}
       <ffffffff80209eb4>{retint_kernel+38}
       <ffffffff8026cdba>{kfree+56}
       <ffffffff8045f09c>{_raw_spin_unlock+57}
       <ffffffff8026ce3f>{kfree+189}
       <ffffffff8028f642>{seq_release+24}
       <ffffffff80272f12>{__fput+161}
       <ffffffff80270664>{filp_close+89}
       <ffffffff80271b63>{sys_close+143}
       <ffffffff80209882>{system_call+126}
nvidia: module license 'NVIDIA' taints kernel.

Is this the problem you are talking about?  Bill Huey is working on this
same thing at this very moment.

-- Steve


>  I'll be glad to provide other info/run any patches/etc.
> 
>  Thanks.
> 
>  Oh, I'm not lkml subscribed, so please CC.


