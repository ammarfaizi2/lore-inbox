Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWGDI01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWGDI01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWGDI01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:26:27 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:58891 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932066AbWGDI00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:26:26 -0400
Message-ID: <44AA262E.906@argo.co.il>
Date: Tue, 04 Jul 2006 11:26:22 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
References: <17578.4725.914746.951778@cse.unsw.edu.au>
In-Reply-To: <17578.4725.914746.951778@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jul 2006 08:26:24.0846 (UTC) FILETIME=[89B2CEE0:01C69F43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
>
> On Tuesday July 4, avi@argo.co.il wrote:
> > Neil Brown wrote:
> > >
> > > To my mind, the only thing you should put between the filesystem and
> > > the raw devices is RAID (real-raid - not raid0 or linear).
> > >
> > I believe that implementing RAID in the filesystem has many benefits 
> too:
> >  - multiple RAID levels: store metadata in triple-mirror RAID 1, random
> > write intensive data in RAID 1, bulk data in RAID 5/6
> >  - improved write throughput - since stripes can be variable size, any
> > large enough write fills a whole stripe
>
> Maybe....
>
> Now imagine what would be required to rebuild a whole drive onto a
> spare after a drive failure.
>
> I'm sure it is possible, and I believe ZFS does something like that.
> I find it hard to imagine getting reasonable speed if there is much
> complexity.  And the longer it takes, the longer your data is exposed
> to multiple-failures.
>

A company called Isilon does this on a cluster.  They claim (IIRC) a one 
hour rebuild time for a failure.  AFAIK they rebuild into cluster free 
space, so they are not bound by the spare's bandwidth; they can utilize 
all cluster resources for a rebuild.

(You don't need spare disks, just spare free space; so you don't have 
idle disk heads)

In terms of complexity, I imagine one needs a reverse mapping (extent -> 
(inode, offset)); given that, one can very easily rebuild failed disks, 
and more features are easy to implement, like evacuation of a drive, or 
rebalancing data across all drives when new disks are added.

The same ideas can be applied to a non-clustered filesystem, of course.

-- 
error compiling committee.c: too many arguments to function

