Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWBNSkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWBNSkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWBNSkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:40:45 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:13020 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1030352AbWBNSko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:40:44 -0500
Message-ID: <43F223EF.1000309@cfl.rr.com>
Date: Tue, 14 Feb 2006 13:39:43 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com> <43F13BDF.3060208@cfl.rr.com> <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com> <43F17850.8080600@cfl.rr.com> <F157E3C4-0D62-413C-B08B-91A567B8C09B@mac.com>
In-Reply-To: <F157E3C4-0D62-413C-B08B-91A567B8C09B@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2006 18:41:57.0672 (UTC) FILETIME=[558BD280:01C63196]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14267.000
X-TM-AS-Result: No--16.499000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> In this case they _are_ equivalent due to symmetry.  If the other 
> device _may_ assume that the connection is broken, then you _must_ 
> assume that the connection is broken.  Since either device _may_ 
> assume that, both devices therefore _must_ according to spec.
>
Only insofar as the kernel can not assume the device is still 
connected.  If the kernel sees that it is immediately reconnected and 
has every reason to believe that the 'disconnect' was only a result of 
momentary power loss, and it can probably continue to access the device 
with no consequences, then it should do so. 
>
> No, as I said before, a good set of USB suspend scripts can solve this 
> problem.  All of the ones I am aware of *now* already sync all data, 
> which is good enough to prevent data-loss in _every_ case where the 
> device is spontaneously unplugged.  On the other hand, this is _never_ 
> good enough if the device is accidentally switched underneath us while 
> suspended (and that's not so terribly uncommon, I know a lot of people 
> who would do that accidentally, myself included).
>

I suppose this is true.  Syncing before suspend will (mostly) keep the 
kernel from shooting the user in the foot. 

>> I think most users prefer a system that works right when you use it 
>> right to one that doesn't break quite as badly when you do something 
>> stupid.
>
> I think you just proved my point.  Running the "sync" command a couple 
> times then unplugging the USB stick basically never results in data 
> loss even if the filesystem is mounted.  Spontaneously switching block 
> devices under a mounted filesystem is guaranteed to either panic the 
> machine or cause massive data corruption or both.
>

But who cares?  There are plenty of really stupid things users can do to 
hose their system, it isn't right to prevent them from doing something 
perfectly reasonable just because it reduces the damage done when they 
do something completely unreasonable. 

>> Also why is this argument more valid for USB than SCSI?  I am just as 
>> free to unplug a scsi disk and replace it with a different one while 
>> hibernated, yet I don't suffer data loss when I don't do such 
>> foolishness.
>
> SCSI != USB.  Users generally don't expect to hotplug SCSI devices 
> while booted and running (with the exception of some _really_ 
> expensive hotplug-bays where we expect the admin to know what the hell 
> they're doing).  On the other hand, users _do_ expect to hotplug 
> random USB devices whenever they feel like it.
>

So because SCSI is more expensive than USB, it is ok to assume it will 
only be used by people who know what they are doing?  And since USB will 
be used by people who don't know what they are doing, we must assume 
they will always do silly things ( swap or modify the drive while 
suspended ), at the expense of those who don't?


