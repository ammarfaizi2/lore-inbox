Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbUCYXLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUCYXIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:08:15 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:10255 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263741AbUCYXAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:00:25 -0500
Date: Thu, 25 Mar 2004 15:59:00 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org
cc: Jeff Garzik <jgarzik@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <1019470000.1080255540@aslan.btc.adaptec.com>
In-Reply-To: <200403251200.35199.kevcorry@us.ibm.com>
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Independent DM efforts have already started supporting MD raid0/1
>> metadata from what I understand, though these efforts don't seem to post
>> to linux-kernel or linux-raid much at all.  :/
> 
> I post on lkml.....occasionally. :)

...

> This decision was not based on any real dislike of the MD driver, but rather 
> for the benefits that are gained by using Device-Mapper. In particular, 
> Device-Mapper provides the ability to change out the device mapping on the 
> fly, by temporarily suspending I/O, changing the table, and resuming the I/O 
> I'm sure many of you know this already. But I'm not sure everyone fully 
> understands how powerful a feature this is. For instance, it means EVMS can 
> now expand RAID-linear devices online. While that particular example may not 
> sound all that exciting, if things like RAID-1 and RAID-5 were "ported" to 
> Device-Mapper, this feature would then allow you to do stuff like add new 
> "active" members to a RAID-1 online (think changing from 2-way mirror to 
> 3-way mirror). It would be possible to convert from RAID-0 to RAID-4 online 
> simply by adding a new disk (assuming other limitations, e.g. a single 
> stripe-zone). Unfortunately, these are things the MD driver can't do online, 
> because you need to completely stop the MD device before making such changes 
> (to prevent the kernel and user-space from trampling on the same metadata), 
> and MD won't stop the device if it's open (i.e. if it's mounted or if you 
> have other device (LVM) built on top of MD). Often times this means you need 
> to boot to a rescue-CD to make these types of configuration changes.

We should be clear about your argument here.  It is not that DM makes
generic morphing easy and possible, it is that with DM the most basic
types of morphing (no data striping or de-striping) is easily accomplished.
You sight two examples:

1) Adding another member to a RAID-1.  While MD may not allow this to
   occur while the array is operational, EMD does.  This is possible
   because there is only one entity controlling the meta-data.

2) Converting a RAID0 to a RAID4 while possible with DM is not particularly
   interesting from an end user perspective.

The fact of the matter is that neither EMD nor DM provide a generic
morphing capability.  If this is desirable, we can discuss how it could
be achieved, but my initial belief is that attempting any type of
complicated morphing from userland would be slow, prone to deadlocks,
and thus difficult to achieve in a fashion that guaranteed no loss of
data in the face of unexpected system restarts.

--
Justin

