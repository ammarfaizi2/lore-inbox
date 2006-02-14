Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbWBNQYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWBNQYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWBNQYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:24:51 -0500
Received: from smtpout.mac.com ([17.250.248.44]:1746 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161113AbWBNQYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:24:50 -0500
In-Reply-To: <43F17850.8080600@cfl.rr.com>
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com> <43F13BDF.3060208@cfl.rr.com> <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com> <43F17850.8080600@cfl.rr.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F157E3C4-0D62-413C-B08B-91A567B8C09B@mac.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Tue, 14 Feb 2006 11:23:53 -0500
To: Phillip Susi <psusi@cfl.rr.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 14, 2006, at 01:27, Phillip Susi wrote:
> Kyle Moffett wrote:
>> No, that's _exactly_ what the spec says (well, not verbatim but  
>> close enough).  When you disconnect, both the master and slave  
>> devices are perfectly free to assume that the connection is  
>> completely broken and no state is maintained.  Anything that  
>> breaks that assumption is against the spec and likely to break in  
>> odd scenarios.
>
> Perfectly free to != required to.

In this case they _are_ equivalent due to symmetry.  If the other  
device _may_ assume that the connection is broken, then you _must_  
assume that the connection is broken.  Since either device _may_  
assume that, both devices therefore _must_ according to spec.

>> Which causes worse data-loss, writing out cached pages and  
>> filesystem metadata to a filesystem that has changed in the mean- 
>> time (possibly allocating those for metadata, etc) or forcibly  
>> unmounting it as though the user pulled the cable?  Most  
>> filesystems are designed to handle the latter (it's the same as a  
>> hard-shutdown), whereas _none_ are designed to handle the former.
>
> So you condemn the common correct use case to always suffer data  
> loss to give _slightly_ better protection to the uncommon and  
> incorrect use case?

No, as I said before, a good set of USB suspend scripts can solve  
this problem.  All of the ones I am aware of *now* already sync all  
data, which is good enough to prevent data-loss in _every_ case where  
the device is spontaneously unplugged.  On the other hand, this is  
_never_ good enough if the device is accidentally switched underneath  
us while suspended (and that's not so terribly uncommon, I know a lot  
of people who would do that accidentally, myself included).

> I think most users prefer a system that works right when you use it  
> right to one that doesn't break quite as badly when you do  
> something stupid.

I think you just proved my point.  Running the "sync" command a  
couple times then unplugging the USB stick basically never results in  
data loss even if the filesystem is mounted.  Spontaneously switching  
block devices under a mounted filesystem is guaranteed to either  
panic the machine or cause massive data corruption or both.

> Also why is this argument more valid for USB than SCSI?  I am just  
> as free to unplug a scsi disk and replace it with a different one  
> while hibernated, yet I don't suffer data loss when I don't do such  
> foolishness.

SCSI != USB.  Users generally don't expect to hotplug SCSI devices  
while booted and running (with the exception of some _really_  
expensive hotplug-bays where we expect the admin to know what the  
hell they're doing).  On the other hand, users _do_ expect to hotplug  
random USB devices whenever they feel like it.

Cheers,
Kyle Moffett

--
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.



