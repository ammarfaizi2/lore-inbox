Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbRGMJKT>; Fri, 13 Jul 2001 05:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266988AbRGMJKM>; Fri, 13 Jul 2001 05:10:12 -0400
Received: from alb-66-24-215-176.nycap.rr.com ([66.24.215.176]:25358 "EHLO
	swamijr.dyndns.org") by vger.kernel.org with ESMTP
	id <S266987AbRGMJKC>; Fri, 13 Jul 2001 05:10:02 -0400
Message-ID: <XFMail.010713051004.n2por@amsat.org>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3b512f43.30115420@mail.mbay.net>
Date: Fri, 13 Jul 2001 05:10:04 -0400 (EDT)
From: Chuck Hemker <n2por@amsat.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Jul-01 John Alvord wrote:
> On Thu, 12 Jul 2001 00:48:15 -0400 (EDT), Frank Davis
> <fdavis@andrew.cmu.edu> wrote:
> 
>>Hello all,
>>  I believe that if such a project is to be undertaken, it first
>>needs to be designed, then coded. I agree that is a difficult problem...As
>>for its feasiblity, I'm unsure. Maybe the reason this topic comes up
>>here from time to time is because it hasn't been shown to be a bad
>>idea. It might be be, but if we don't start somewhere, then we'll never
>>really know, and the debate will continue. Just my .02 cents.
>>Regards,
> 
> This topic comes up once a twice a year.
> 
> Usually this topic comes to a grinding halt when someone points out
> that drivers can be created modular. They can be loaded and unloaded
> without rebooting Linux. One project used that technique to
> load/unload different schedulers. While this satisfies only part of
> the need, it is usually enough to satisfy the tinker-er.

One problem with this is many of the modules may be difficult to replace
because they are in use.

If someone did want to spend time on a project like this, one place they could
start would be to try to make some of the modules hot replaceable.

As an example that pops to mind would be a scsi driver:

1. Tell the kernel to stop sending it commands.
2. wait for things in progress to complete.
3. save whatever state you need to.
4. remove old.
5. start up new.
6. start restoring state.
6. reset scsi bus.
7. reprobe for devices?
8. finish restore state.
9. tell the kernel we are available.

This example was chosen not because I think the scsi drivers are buggy. :)
It was chosen type of module that someone might want to replace, but couldn't
because it was in use (a file system mounted on it).  
Maybe a network card would be easier to start with, with similar requirements.  
Then you could hope all the patches will be for modules. :)

I also haven't looked at the code to see if it was possible. :)

