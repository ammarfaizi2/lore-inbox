Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVAUJYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVAUJYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 04:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVAUJYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 04:24:37 -0500
Received: from [81.23.229.73] ([81.23.229.73]:55014 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S262196AbVAUJY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 04:24:27 -0500
From: Norbert van Nobelen <norbert-kernel@edusupport.nl>
Organization: EduSupport BV
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Subject: Re: LVM2
Date: Fri, 21 Jan 2005 10:24:21 +0100
User-Agent: KMail/1.6.2
References: <1106250687.3413.6.camel@localhost.localdomain> <200501202240.02951.Norbert@edusupport.nl> <1106259457.3413.19.camel@localhost.localdomain>
In-Reply-To: <1106259457.3413.19.camel@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200501211024.21224.norbert-kernel@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With using RAID5 you can choose yourself howmany hot standby/failover disks 
you want to use. The number (or ratio) of disks used for failover of your 
raid will determine the chance that you have when one disk fails and complete 
failure of a raid.
It is still pretty safe just to have 7 active disks and 1 hot standby disk, 
thus getting you 3500 Manufacturers GB (3.34TB)

About LVM on a RAID: 
With hardware RAID it will work for sure.
With software RAID:
Make the RAID partitions and build your RAID.
On that RAID, set the partition type to LVM
And it should work
On LVM you can then use ext3 (your preferred fs)

On Thursday 20 January 2005 23:17, you wrote:
> It is for a group. For the most part it is data access/retention. Writes
> and such would be more similar to a desktop. I would use SATA if they
> were (nearly) equally priced and there were awesome 1394 to SATA bridge
> chips that worked well with Linux. So, right now, I am looking at ATA to
> 1394.
>
> So, to get 2TB of RAID5 you have 6 500 GB disks right? So, will this
> work within on LV? Or is it 2TB of diskspace total? So, are volume
> groups pretty fault tolerant if you have a bunch of RAID5 LVs below
> them? This is my one worry about this.
>
> Second, you mentioned file systems. We were talking about ext3. I have
> never used any others in Linux (barring ext2, minixfs, and fat). I had
> heard XFS from IBM was pretty good. I would rather not use reiserfs.
>
> Any recommendations.
>
> Trever
>
> P.S. Why won't an LV support over 2TB?
>
> S.P.S. I am not really worried about the boot and programs drive. They
> will be spun down most of the time I am sure.
>
> On Thu, 2005-01-20 at 22:40 +0100, Norbert van Nobelen wrote:
> > A logical volume in LVM will not handle more than 2TB. You can tie
> > together the LVs in a volume group, thus going over the 2TB limit. Choose
> > your filesystem well though, some have a 2TB limit too.
> >
> > Disk size: What are you doing with it. 500GB disks are ATA (maybe SATA).
> > ATA is good for low end servers or near line storage, SATA can be used
> > equally to SCSI (I am going to suffer for this remark).
> >
> > RAID5 in software works pretty good (survived a failed disk, and
> > recovered another failing raid in 1 month). Hardware is better since you
> > don't have a boot partition left which is usually just present on one
> > disk (you can mirror that yourself ofcourse).
> >
> > Regards,
> >
> > Norbert van Nobelen
> >
> > On Thursday 20 January 2005 20:51, you wrote:
> > > I recently saw Alan Cox say on this list that LVM won't handle more
> > > than 2 terabytes. Is this LVM2 or LVM? What is the maximum amount of
> > > disk space LVM2 (or any other RAID/MIRROR capable technology that is in
> > > Linus's kernel) handle? I am talking with various people and we are
> > > looking at Samba on Linux to do several different namespaces (obviously
> > > one tree), most averaging about 3 terabytes, but one would have in
> > > excess of 20 terabytes. We are looking at using 320 to 500 gigabyte
> > > drives in these arrays. (How? IEEE-1394. Which brings a question I will
> > > ask in a second email.)
> > >
> > > Is RAID 5 all that bad using this software method? Is RAID 5 available?
> > >
> > > Trever Adams
> > > --
> > > "They that can give up essential liberty to obtain a little temporary
> > > safety deserve neither liberty nor safety." -- Benjamin Franklin, 1759
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> --
> "Assassination is the extreme form of censorship." -- George Bernard
> Shaw (1856-1950)

-- 
<a href="http://www.edusupport.nl">EduSupport: Linux Desktop for schools and 
small to medium business in The Netherlands and Belgium</a>
