Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWEIBks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWEIBks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 21:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWEIBks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 21:40:48 -0400
Received: from ns.suse.de ([195.135.220.2]:63137 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751086AbWEIBkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 21:40:47 -0400
From: Neil Brown <neilb@suse.de>
To: bert hubert <bert.hubert@netherlabs.nl>
Date: Tue, 9 May 2006 11:40:26 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17503.62218.637245.890380@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 004 of 11] md: Increase the delay before marking metadata clean, and make it configurable.
In-Reply-To: message from bert hubert on Tuesday May 2
References: <20060501152229.18367.patches@notabene>
	<1060501053019.22949@suse.de>
	<20060502055621.GA552@outpost.ds9a.nl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 2, bert.hubert@netherlabs.nl wrote:
> On Mon, May 01, 2006 at 03:30:19PM +1000, NeilBrown wrote:
> > When a md array has been idle (no writes) for 20msecs it is marked as
> > 'clean'.  This delay turns out to be too short for some real
> > workloads.  So increase it to 200msec (the time to update the metadata
> > should be a tiny fraction of that) and make it sysfs-configurable.
> 
> What does this mean, 'too short'? What happens in that case, backing block
> devices are still busy writing? When making this configurable, the help text
> better explain what the trade offs are.

"too short" means that the update happens often enough to cause a
noticeable performance degradation.

In an application writes steadily very 21msecs (or maybe 30msecs) then
there will be 2 superblock writes and 1 application write every
21msecs, and this causes enough disk io to close the app down. - I
guess all the updates fill up the 21msec space.

With a larger delay - 200msec - you could still get bad situations
e.g. with the app writing every 210msecs.  However 2 superblock
updates plus one app write is a much smaller fraction of 200msecs, so
there shouldn't be as many problems.

Yes, a more detailed explanation should go in Documentation/md.txt

NeilBrown
