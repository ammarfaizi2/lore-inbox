Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTDSUWx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTDSUWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:22:53 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:16126 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263451AbTDSUWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:22:52 -0400
Date: Sat, 19 Apr 2003 14:33:25 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: John Bradford <john@grabjohn.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-ID: <20030419143325.T26054@schatzie.adilger.int>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030419185201.55cbaf43.skraw@ithnet.com> <200304192004.h3JK4Sgc000152@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304192004.h3JK4Sgc000152@81-2-122-30.bradfords.org.uk>; from john@grabjohn.com on Sat, Apr 19, 2003 at 09:04:28PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 19, 2003  21:04 +0100, John Bradford wrote:
> > > > I wonder whether it would be a good idea to give the linux-fs
> > > > (namely my preferred reiser and ext2 :-) some fault-tolerance.

I'm not against this in principle, but in practise it is almost useless.
Modern disk drives do bad sector remapping at write time, so unless something
is terribly wrong you will never see a write error (which is exactly the time
that the filesystem could do such remapping).  Normally, you will only see
an error like this at read time, at which point it is too late to fix.

If you do an fsck, it would normally detect the read error and try to write
back the repaired data, and cause the device to do remapping.  It will not
normally be possible to regenerate metadata with anything less than a full
fsck (if at all).

> > > Fault tollerance should be done at a lower level than the filesystem.
> > 
> > I know it _should_ to live in a nice and easy world. Unfortunately
> > real life is different. The simple question is: you have tons of
> > low-level drivers for all kinds of storage media, but you have
> > comparably few filesystems. To me this sound like the preferred
> > place for this type of behaviour can be fs, because all drivers
> > inherit the feature if it lives in fs.
> 
> The sort of feature you are describing would really belong in a
> separate layer, somewhat analogous to the MD driver, but for defect
> management.  You could create a virtual block device that has 90% of
> the capacity of the real block device, then allocte spare blocks from
> the real device if and when blocks failed.

Hmm, like the "bad blocks relocation" plugin for EVMS?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

