Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWARXhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWARXhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbWARXhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:37:15 -0500
Received: from ns1.suse.de ([195.135.220.2]:20874 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030458AbWARXhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:37:14 -0500
From: Neil Brown <neilb@suse.de>
To: Mark Lord <lkml@rtr.ca>
Date: Thu, 19 Jan 2006 10:37:03 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.53535.449726.814333@cse.unsw.edu.au>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Cynbe ru Taren <cynbe@muq.org>, linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
In-Reply-To: message from Mark Lord on Wednesday January 18
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
	<43CE1E52.3030907@aitel.hist.no>
	<43CE6997.6090005@rtr.ca>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday January 18, lkml@rtr.ca wrote:
> Helge Hafting wrote:
>  >
>  > As other have showed - "mdadm" can reassemble your
>  > broken raid - and it'll work well in those cases where
>  > the underlying drives indeed are ok.  It will fail
>  > spectacularly if you have a real double fault though,
>  > but then nothing short of raid-6 can save you.
> 
> No, actually there are several things we *could* do,
> if only the will-to-do-so existed.

You not only need the will.  You also need the ability and the time,
and the three must be combined into the one person...

> 
> For example, one bad sector on a drive doesn't mean that
> the entire drive has failed.  It just means that one 512-byte
> chunk of the drive has failed.
> 
> We could rewrite the failed area of the drive, allowing the
> onboard firmware to repair the fault internally, likely by
> remapping physical sectors.  This is nothing unusual, as all
> drives these days ship from the factory with many bad sectors
> that have already been remapped to "fix" them.  One or two
> more in the field is no reason to toss a perfectly good drive.

Very recent 2.6 kernels do exactly this.  They don't drop a drive on a
read error, only on a write error.  On a read error they generate the
data from elsewhere and schedule a write, then a re-read.

NeilBrown
