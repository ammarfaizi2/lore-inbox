Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312799AbSDXXJb>; Wed, 24 Apr 2002 19:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312803AbSDXXJb>; Wed, 24 Apr 2002 19:09:31 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30703
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312799AbSDXXJa>; Wed, 24 Apr 2002 19:09:30 -0400
Date: Wed, 24 Apr 2002 16:11:53 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "David S. Miller" <davem@redhat.com>, taka@valinux.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020424231153.GM574@matchmail.com>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Andi Kleen <ak@suse.de>, Jamie Lokier <lk@tantalophile.demon.co.uk>,
	"David S. Miller" <davem@redhat.com>, taka@valinux.co.jp,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020412.213011.45159995.taka@valinux.co.jp> <20020412143559.A25386@wotan.suse.de> <20020412222252.A25184@kushida.apsleyroad.org> <20020412.143150.74519563.davem@redhat.com> <20020413012142.A25295@kushida.apsleyroad.org> <20020413083952.A32648@wotan.suse.de> <m1662vjtil.fsf@frodo.biederman.org> <20020413213700.A17884@wotan.suse.de> <m1zo07ibi3.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002 at 02:34:12PM -0600, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > On Sat, Apr 13, 2002 at 01:19:46PM -0600, Eric W. Biederman wrote:
> > > Could the garbage from ext3 in writeback mode be considered an
> > > information leak?  I know that is why most places in the kernel
> > > initialize pages to 0.  So you don't accidentally see what another
> > > user put there.
> > 
> > Yes it could. But then ext2/ffs have the same problem and so far people were
> > able to live on with that.
> 
> The reason I asked, is the description sounded specific to ext3.  Also
> with ext3 a supported way to shutdown is to just pull the power on the
> machine.  And the filesystem comes back to life without a full fsck.
> 
> So if this can happen when all you need is to replay the journal, I
> have issues with it.  If this happens in the case of damaged
> filesystem I don't.
> 

Actually, with ext3 the only mode IIRC is data=journal that will keep this
from happening.  In ordered or writeback mode there is a window where the
pages will be zeroed in memory, but not on disk.  

Admittedly, the time window is largest in writeback mode, smaller in ordered
and smallest (non-existant?) in data journaling mode.

Mike
