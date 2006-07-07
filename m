Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWGGWbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWGGWbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWGGWbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:31:50 -0400
Received: from cantor2.suse.de ([195.135.220.15]:53177 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932347AbWGGWbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:31:49 -0400
From: Neil Brown <neilb@suse.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Sat, 8 Jul 2006 08:31:41 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17582.57549.204471.855655@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
In-Reply-To: message from Justin Piszcz on Friday July 7
References: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan>
	<Pine.LNX.4.64.0607070845280.2648@p34.internal.lan>
	<Pine.LNX.4.64.0607070849140.3010@p34.internal.lan>
	<Pine.LNX.4.64.0607071037190.5153@p34.internal.lan>
	<17582.55703.209583.446356@cse.unsw.edu.au>
	<Pine.LNX.4.64.0607071814510.8499@p34.internal.lan>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 7, jpiszcz@lucidpixels.com wrote:
> 
> Hey!  You're awake :)

Yes, and thinking about breakfast (it's 8:30am here).

> 
> I am going to try it with just 64kb to prove to myself it works with that, 
> but then I will re-create the raid5 again like I had it before and attempt 
> it again, I did not see that documented anywhere!! Also, how do you use 
> the --backup-file option? Nobody seems to know!

man mdadm
       --backup-file=
              This  is  needed  when  --grow is used to increase the number of
              raid-devices in a RAID5 if there  are no  spare  devices  avail-
              able.   See  the section below on RAID_DEVICE CHANGES.  The file
              should be stored on a separate device, not  on  the  raid  array
              being reshaped.


So e.g.
   mdadm --grow /dev/md3 --raid-disk=7 --backup-file=/root/md3-backup

mdadm will copy the first few stripes to /root/md3-backup and start
the reshape.  Once it gets past the critical section, mdadm will
remove the file.
If your system crashed during the critical section, then you wont be
able to assemble the array without providing the backup file:

e.g.
  mdadm --assemble /dev/md3 --backup-file=/root/md3-backup /dev/sd[a-g]

NeilBrown
