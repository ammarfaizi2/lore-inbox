Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRCPC5q>; Thu, 15 Mar 2001 21:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129679AbRCPC5g>; Thu, 15 Mar 2001 21:57:36 -0500
Received: from baghira.han.de ([212.63.63.2]:13836 "EHLO baghira.han.de")
	by vger.kernel.org with ESMTP id <S129624AbRCPC52>;
	Thu, 15 Mar 2001 21:57:28 -0500
Message-ID: <20010316033712.A11658@ichabod.han.de>
Date: Fri, 16 Mar 2001 03:37:12 +0100
From: Michail Brzitwa <michail@brzitwa.de>
To: linux-kernel@vger.kernel.org
Cc: Andries.Brouwer@cwi.nl
Subject: Re: [util-linux] Re: magic device renumbering was -- Re: Linux 2.4.2ac20
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1i
In-Reply-To: <mng==UTC200103152331.AAA2159588.aeb@vlet.cwi.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <mng==UTC200103152331.AAA2159588.aeb@vlet.cwi.nl> you wrote:
> The real problem is that our disks usually do not have a volume label.
> Outside of all file systems.
> The "signatures" that we rely on today are located in different places,
> so that a filesystem can have several valid signatures at the same time.
> And we first know where to look when we know the type already.
>
> Design a Linux partition table format, where a partition descriptor
> has fields start, end, fstype, fslabel, and the whole disk has a vollabel.
> Put it in sector 0-N for an all-Linux disk, and in sectors pointed at
> by a classical DOS-type partition table entry when the disk is shared.

I don't understand that. Do you propose something like *BSD or Solaris
disklabels? In that case a whole new set of user utilities would be
needed to create your new tables as well as maintaining the old style
partition tables.

The process of copying or moving fs around disks seems to be quite common
as tools like partition magic or parted suggest. Your idea would make
that process more difficult and less user-friendly. It should imho always
be simple to backup an fs to tape from a dying disk and restore it to
a new one without losing the label etc.

Perhaps putting this kind of information into a generalized start sector
for all Linux fs would be a better idea (is that what you meant?). Copying
an fs would again be as easy as using dd or cp. Of course this means
that most Linux fs types including swap partitions should leave this
start sector alone. A common mkfs would create that leading block after
the mkfs.<fs type> successfully created the fs meta-contents.

It would be optimal imho if the partition table entry contains the start
sector and size only, and all other information like type, uuid, label
etc. is within the fs disk space. No out-of-band fs information anymore.

The disk volume label should be located outside all fs as you mentioned
but separated from the actual fs labels.
-- 
Michail Brzitwa           <michail@brzitwa.de>            +49-511-343215
