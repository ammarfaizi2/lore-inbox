Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWFIUim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWFIUim (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWFIUil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:38:41 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:40489 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965143AbWFIUik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:38:40 -0400
Date: Fri, 9 Jun 2006 13:38:03 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
       Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609203803.GF3574@ca-server1.us.oracle.com>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609195750.GD10524@thunk.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 03:57:50PM -0400, Theodore Tso wrote:
> We don't do this with the SCSI layer where we make a complete clone of
> the driver layer so that there is a /usr/src/linux/driver/scsi and
> /usr/src/linux/driver/scsi2, do we?  And we didn't do that with the
> networking layer either, as we added ipsec, ipv6, softnet, and a whole
> host of other changes and improvements.  

Ted,
	We don't have any permanent, physical representation of the
state either.  With a filesystem we do.  I don't care how many changes
you made to the SCSI stack.  The code from a year ago could be entirely
different.  However, if the old stack and the new stack both support
card X, then it Just Works.  The Adaptec driver is a case in point.
When the new driver was still flaky, folks and distros could select the
old driver with impunity.  Running the new driver didn't fundamentally
change your Adaptec card so you couldn't run the old one.
	Filesystem features are different.  There is a permanent state
that the older code cannot read.  Alex claims people just shouldn't use
"-o extents", but the fact is their distro will choose it for them.  We
have multiboot machines in our test lab, because like many people we
don't have unlimited funds.  What happened when we installed the 2.6
distros?  All of a sudden the older 2.4 distros wouldn't mount the
shared filesystems, becuase of ext3 features.  This wasn't the kernel
driver, this was merely the tools!  Surprise!  We made no choice to use
new features, and they were thrust upon us.  This will happen to others.

Joel

-- 

"Sometimes one pays most for the things one gets for nothing."
        - Albert Einstein

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
