Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311463AbSC1CQZ>; Wed, 27 Mar 2002 21:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311519AbSC1CQP>; Wed, 27 Mar 2002 21:16:15 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59381
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311463AbSC1CQI>; Wed, 27 Mar 2002 21:16:08 -0500
Date: Wed, 27 Mar 2002 18:17:31 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
Message-ID: <20020328021731.GC8627@matchmail.com>
Mail-Followup-To: Matthew Kirkwood <matthew@hairy.beasts.org>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <p73y9ge3xww.fsf@oldwotan.suse.de> <Pine.LNX.4.33.0203271419230.28110-100000@sphinx.mythic-beasts.com> <20020327180247.GU21133@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 11:02:47AM -0700, Andreas Dilger wrote:
> On Mar 27, 2002  14:47 +0000, Matthew Kirkwood wrote:
> > Postgres doesn't pre-allocate datafiles.  They reckon it's not
> > their job to implement a filesystem, and I'm inclined to agree.
> > They do prefer fdatasync on datafiles and (I think) O_DATASYNC
> > for their journal files where available, but I haven't checked
> > that my build is doing that.
> 
> If the I/O is normally sync driven, you should consider testing ext3
> with "data=journal".  While this seems counterintuitive because it is
> writing the data to disk twice, it can often be faster in real-world
> "bursty" environments because the sync I/O goes to the journal in one
> contiguous write, and it can then be written to the rest of the fs
> asynchronously safely. 

Don't forget to have enough extra memory so that it can have time to do
those async writes later.

When is ext3 going to get high and low watermarks?

Currently it hits a (50%?) high usage level and then sync writes the entire
journal contents. :(  Has that changed?
