Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWG0SdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWG0SdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWG0SdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:33:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21734 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751645AbWG0SdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:33:15 -0400
Message-ID: <44C906CB.8050100@sandeen.net>
Date: Thu, 27 Jul 2006 13:32:43 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>, jack@suse.cz,
       20@madingley.org, marcel@holtmann.org, linux-kernel@vger.kernel.org,
       sct@redhat.com, adilger@clusterfs.com
Subject: Re: Bad ext3/nfs DoS bug
References: <20060718145614.GA27788@circe.esc.cam.ac.uk>	<1153236136.10006.5.camel@localhost>	<20060718152341.GB27788@circe.esc.cam.ac.uk>	<1153253907.21024.25.camel@localhost>	<20060719092810.GA4347@circe.esc.cam.ac.uk>	<20060719155502.GD3270@atrey.karlin.mff.cuni.cz>	<17599.2754.962927.627515@cse.unsw.edu.au>	<20060720160639.GF25111@atrey.karlin.mff.cuni.cz>	<17600.30372.397971.955987@cse.unsw.edu.au>	<20060721170627.4cbea27d.akpm@osdl.org>	<20060722131759.GC7321@thunk.org>	<20060724185604.9181714c.akpm@osdl.org>	<17605.32781.909741.310735@cse.unsw.edu.au>	<44C7A272.8030401@sandeen.net> <17608.96.409298.126686@cse.unsw.edu.au>
In-Reply-To: <17608.96.409298.126686@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Wednesday July 26, sandeen@sandeen.net wrote:

>> Hm, with this, ext3.ko has a new dependency on exportfs.ko.  Is that 
>> desirable/acceptable?
> 
> Drat, you're right.
> No, I don't think that is what we want.
> I'll do it differently in a day or so.

Would moving export_iget into fs/inode.c & exporting it from there be a 
reasonable way to go?  At least ext2 & ext3 both have this need (prevent 
nfs access to special inodes) so putting the bulk of what they need for 
get_dentry (i.e. export_iget) somewhere common seems like a decent 
option to me.

-Eric
