Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289954AbSAKNqX>; Fri, 11 Jan 2002 08:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289953AbSAKNqN>; Fri, 11 Jan 2002 08:46:13 -0500
Received: from [195.63.194.11] ([195.63.194.11]:6661 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S289951AbSAKNqB>;
	Fri, 11 Jan 2002 08:46:01 -0500
Message-ID: <3C3EEC94.7020001@evision-ventures.com>
Date: Fri, 11 Jan 2002 14:45:56 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Big patch: linux-2.5.2-pre11/drivers/scsi compilation fixes
In-Reply-To: <20020111051456.A12788@baldur.yggdrasil.com> <20020111141850.B19814@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Fri, Jan 11 2002, Adam J. Richter wrote:
>
>>	Today I plan to post patches to make everything in
>>linux-2.5.2-pre11/drivers/scsi compile, at least everything under
>>x86, compiled as modules.  They compile, and, the only undefined
>>symbol in when I boot is scsi_mark_host_reset in BusLogic.c.
>>However, the 2.5.2-pre11 patches are completely untested.
>>
>
>Please hang on with this for a week or so, there will be other changes
>to SCSI drivers required. You'll just end up doing the work twice.
>

For the record. We have a file called: sun3_NCR5380.c inside dirvers/scis.

There appers to be code there, which is using some of the oboslted error 
handling facilities.
But under a compilation switch, there is code for the new error 
management as well
already there, with some notes about the midlayer having problems.

If there is nobody supporting this driver, pleas consider switching 
those macros... the
oboslete stuff,won't compile anyway.

However I doubt, that sun3 is supported anyway at all... so if not, then 
please
consider this driver seriously  for total removal ftom the kernel soruce 
tree.

Here is the  actual cided code:

#if 1 /* XXX Should now be done by midlevel code, but it's broken XXX */
      /* XXX see below                                            XXX */

    /* MSch: old-style reset: actually abort all command processing here */

    /* After the reset, there are no more connected or disconnected commands
     * and no busy units; to avoid problems with re-inserting the commands
     * into the issue_queue (via scsi_done())

And later down:
#else /* 1 */

    /* MSch: new-style reset handling: let the mid-level do what it can */

    /* ++guenther: MID-LEVEL IS STILL BROKEN.
     * Mid-level is supposed to requeue all commands that were active on the
     * various low-l


Both are quite at the end of the file...


