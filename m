Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbTFMRK0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbTFMRKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:10:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:60864 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265404AbTFMRKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:10:16 -0400
Date: Fri, 13 Jun 2003 10:19:43 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Ben Collins <bcollins@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Torrey Hoffman <thoffman@arnor.net>, linux-scsi@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: scsi_add_device() broken? (was Re: SBP2 hotplug doesn't update /proc/partitions)
Message-ID: <20030613101943.A22559@beaverton.ibm.com>
References: <1054770509.1198.79.camel@torrey.et.myrio.com> <3EDE870C.1EFA566C@digeo.com> <1054838369.1737.11.camel@torrey.et.myrio.com> <20030605175412.GF625@phunnypharm.org> <1054858724.3519.19.camel@torrey.et.myrio.com> <20030606025721.GJ625@phunnypharm.org> <1055446080.3480.291.camel@torrey.et.myrio.com> <20030612195243.GV4695@phunnypharm.org> <20030613024044.GA499@hopper.phunnypharm.org> <20030613160812.GA520@hopper.phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030613160812.GA520@hopper.phunnypharm.org>; from bcollins@debian.org on Fri, Jun 13, 2003 at 12:08:12PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 12:08:12PM -0400, Ben Collins wrote:

> Here's the scenario. scsi_add_lun doesn't set sdp->devfs_name before
> calling scsi_register_device(). Since scsi_register_device calls down to
> things like sd_probe, which do try to use sdp->devfs_name, things fail.
> 
> Just an easy change, moving the sdp->devfs_name creation before calling
> scsi_register_device(). Patch fixes this.

It really needs to move into the caller of scsi_add_lun, so we setup all
the other fields, and possibly call scsi_unlock_floptical before
registering.

And the return value should be checked - then on failure just set res (in
scsi_probe_and_add_lun) so it is cleaned up.

-- Patrick Mansfield
