Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRCPJPq>; Fri, 16 Mar 2001 04:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbRCPJPg>; Fri, 16 Mar 2001 04:15:36 -0500
Received: from zeus.kernel.org ([209.10.41.242]:36063 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129346AbRCPJPY>;
	Fri, 16 Mar 2001 04:15:24 -0500
Date: Fri, 16 Mar 2001 09:11:24 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Lars Kellogg-Stedman <lars@larsshack.org>
Cc: Christoph Hellwig <hch@caldera.de>, John Jasen <jjasen1@umbc.edu>,
        linux-kernel@vger.kernel.org, AmNet Computers <amnet@amnet-comp.com>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
Message-ID: <20010316091124.A1771@redhat.com>
In-Reply-To: <200103141823.TAA11310@ns.caldera.de> <Pine.LNX.4.30.0103141410360.2004-100000@flowers.house.larsshack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0103141410360.2004-100000@flowers.house.larsshack.org>; from lars@larsshack.org on Wed, Mar 14, 2001 at 02:11:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 14, 2001 at 02:11:57PM -0500, Lars Kellogg-Stedman wrote:
> > Put LABEL=<label set with e2label> in you fstab in place of the device name.
> 
> Which is great, for filesystems that support labels.  Unfortunately,
> this isn't universally available -- for instance, you cannot mount
> a swap partition by label or uuid, so it is not possible to completely
> isolate yourself from the problems of disk device renumbering.

It's not convenient, but it is certainly possible: use a
single-partition raid0 logical device with raid autostart, and you get
a logical /dev/md* device which corresponds to a single partition and
which has a fixed name which is detected by the kernel at runtime and
mapped to the correct disk, wherever the disk may be.

The IBM EVMS folks are looking to generalise this sort of probing, but
for now there is at least one solution to this problem.  LVM works too
to some extent, but it currently lacks the automatic boot-time/
device-detect-time kernel probing step that the software raid code
has.

Cheers,
 Stephen
