Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbVI3OXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVI3OXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbVI3OXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:23:34 -0400
Received: from magic.adaptec.com ([216.52.22.17]:6866 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030320AbVI3OXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:23:33 -0400
Message-ID: <433D4A5A.1090704@adaptec.com>
Date: Fri, 30 Sep 2005 10:23:22 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <20050929232013.95117.qmail@web31810.mail.mud.yahoo.com> <Pine.LNX.4.64.0509291730360.3378@g5.osdl.org> <433CE961.3040504@torque.net>
In-Reply-To: <433CE961.3040504@torque.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 14:23:31.0939 (UTC) FILETIME=[88D0FB30:01C5C5CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/05 03:29, Douglas Gilbert wrote:
> 
> For SAS we have a well thought out definition for what the
> interface should be to hardware specific drivers IMO. It is
> called CSMI, rechristened SDI. The editor of SDI is also
> the editor of SAS, SAS-1.1 and SAS-2. Judging from his work,
> he knows his stuff. Unfortunately SDI uses ioctls to define
> its interface, which is mainly between two kernel layers
> (if one ignores pass throughs). Sorry, did I mention "ioctl",

Hi Doug,

Almost all of the SDI stuff can be extracted by a user space
library reading the SAS sysfs domain tree (which is the result
of domain discovery).

Pictures of can be found here:
http://marc.theaimsgroup.com/?l=linux-scsi&m=112629509826900&w=2

Since MPT-based hardware does domain discovery in the FIRMWARE,
this is why you do not have the domain picture as easily.

> oh that makes SDI unacceptable. Almost a year ago that is what
> happened to the first proposed SAS driver for Linux. That
> decision has pushed Luben (amongst others) into the position
> he is in now: come up with a "better" design, produce code
> and then watch it get rejected. So please cut Luben a bit
> of slack.

What James Bottomley et al. complained back then is that
"common code" to SAS should be pulled out in a "common layer".

This layer is the SAS Transport layer.

But in the mean time, LSI came out with SAS, whose driver
as you can see had nothing to do with SAS -- it was an MPT
driver after all, so James Bottomley decides that whatever
else comes along, it would use _his_ design.  Whether it
works for open transport, he doesn't want to listen.  He
is using his political power to enforce it.

> Just in case people think that I agree with Luben on using
> sysfs to represent the whole SAS topology and interesting
> bits suspended in it (i.e. SAS expanders), then I don't.
> I am, however, prepared to argue the detail. Since the

Sorry, since the discover process keeps an internal
representation of "what is out there" via discovery,
I just tacked a kobject to each structure I have anyway,
and showed it in sysfs.

I thought that was the whole purpose of sysfs -- to show
kernel internal structures and dependencies.

Plus, this is what it _actually_ looks in the physical world.

Also you have to admit -- it looks cool:
http://marc.theaimsgroup.com/?l=linux-scsi&m=112629509826900&w=2

> days of Eric Youngdale I have believed that SCSI Host Bus
> Adapters (HBAs) should be addressable devices, just like
> network interfaces. IMO it is the block layer and its
> associated end devices that are the legacy thinking.

Host Adapters are addressable -- if there's an initiator
on the domain, the discover process will discover it
and it will show up in the SAS sysfs tree.

> It is ironic that as the author of the SG_IO
> passthrough ioctl the "specs" that I am
> often asked to help circumvent are the "we
> know better" variety built into various layers
> of the linux kernel :-)

Indeed.

	Luben
