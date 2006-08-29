Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWH2J07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWH2J07 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWH2J07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:26:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9347 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932239AbWH2J06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:26:58 -0400
From: Neil Brown <neilb@suse.de>
To: Nico Schottelius <nico-kernel20060829@schottelius.org>
Date: Tue, 29 Aug 2006 19:26:52 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17652.2140.871672.919816@cse.unsw.edu.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problem with md: Not rebuilding rai5
In-Reply-To: message from Nico Schottelius on Tuesday August 29
References: <20060829091205.GB21160@schottelius.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 29, nico-kernel20060829@schottelius.org wrote:
> Hello!
> 
> I created a degrated raid5 on top of md1 and hde1. Then moved the data
> from /dev/hdk to the mounted raid5, and then added hdk1 (repartitoned)
> to the array. The sync began, but after that hde1 was faulty.

So you created a raid5 containing one drive that was already faulty.
That is unfortunate!

> 
> I removed it, readded it, but now I've a raid5 with only one active
> disk (which should not be possible imho, a raid5 always needs 2 disks)
> AND what's even stranger for me, I've two spare disks.

If you have a raid5 with 2 working drives and one fails, how many
working drives do you expect to be left?  1.  So the raid is no longer
fully functional.  You might be able to read some data, but you want
able to write.
What did you expect to happen when hde1 failed?


> 
> Is there a way to force rebuilding the array?

Well, you can create the array over md1 and hde1 again, and your data
should still be there, but it will just  fail again whenever it tries
to access the block on hde1 which is bad.

I suggest you:
  - recreate the array over md1 and hde1
  - copy the data back to hdk
  - stop the array
  - replace hde1
  - make the array.
  - read the entire array (dd > /dev/null) to make sure it is safe
  - copy data back from hdk

NeilBrown
