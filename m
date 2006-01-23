Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWAWB0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWAWB0I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 20:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWAWB0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 20:26:08 -0500
Received: from mx1.suse.de ([195.135.220.2]:31932 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751155AbWAWB0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 20:26:06 -0500
From: Neil Brown <neilb@suse.de>
To: John Hendrikx <hjohn@xs4all.nl>
Date: Mon, 23 Jan 2006 12:25:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17364.12454.643875.626906@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
In-Reply-To: message from John Hendrikx on Monday January 23
References: <20060117174531.27739.patches@notabene>
	<43D42CA8.6060507@xs4all.nl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 23, hjohn@xs4all.nl wrote:
> NeilBrown wrote:
> > In line with the principle of "release early", following are 5 patches
> > against md in 2.6.latest which implement reshaping of a raid5 array.
> > By this I mean adding 1 or more drives to the array and then re-laying
> > out all of the data.
> >   
> I think my question is already answered by this, but...
> 
> Would this also allow changing the size of each raid device?  Let's say 
> I currently have 160 GB x 6, could I change that to 300 GB x 6 or am I 
> only allowed to add more 160 GB devices?

Changing the size of the devices is a separate operation that has been
supported for a while.
For each device in turn, you fail it and replace it with a larger
device. (This means the array runs degraded for a while, which isn't
ideal and might be fixed one day).

Once all the devices in the array are of the desired size, you run
  mdadm --grow /dev/mdX --size=max
and the array (raid1, raid5, raid6) will use up all available space on
the devices, and a resync will start to make sure that extra space is
in-sync.

NeilBrown
