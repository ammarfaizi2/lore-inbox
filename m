Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281118AbRKGXtn>; Wed, 7 Nov 2001 18:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRKGXte>; Wed, 7 Nov 2001 18:49:34 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7924
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281118AbRKGXtU>; Wed, 7 Nov 2001 18:49:20 -0500
Date: Wed, 7 Nov 2001 15:49:13 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107154913.B560@mikef-linux.matchmail.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <E161Y87-00052r-00@the-village.bc.nu>, <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk> <3BE99650.70AF640E@zip.com.au>, <3BE99650.70AF640E@zip.com.au> <20011107133301.C20245@mikef-linux.matchmail.com> <3BE9AF15.50524856@zip.com.au> <20011107145229.A560@mikef-linux.matchmail.com> <20011107153805.B27157@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011107153805.B27157@thune.mrc-home.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 03:38:05PM -0800, Mike Castle wrote:
> On Wed, Nov 07, 2001 at 02:52:29PM -0800, Mike Fedyk wrote:
> > On Wed, Nov 07, 2001 at 02:00:53PM -0800, Andrew Morton wrote:
> > > Try  adding `rootflags=data=journal' to your kernel boot
> > > commandline.
> > 
> > adding that line to an ext2 only kernel will make it kernel panic when it
> > tries to mount root because it doesn't understand the option!
> 
> 
> So set that option only for ext3 enabled kernels.  If you're using lilo,
> instead of using a global append= setting, use a local one for that ext3
> kernel, and leave it off for the ext2-only kernel.
> 

Yep, I know how to work around the problem.

The question is: why do I *need* to have to do that???

One of the features of ext3 is the backwards compatibility with ext2, but if
you choose to take advantage of ext3 (non default journal mode) to its full
capabilities, ext2 borks on those settings.

With careful consideration, this problem can be avoided with everything the
way it is now, but it is a bit of a hassle...

Though, with non ext3 you wouldn't even have the possibility of mounting the
FS without the correct FS driver loaded...

I think the easiest way to avoid this problem would be a compile time option
to set the default journal mode.  But, that would add another question the ext3
developers would have to ask... "what is your default journal mode"... But
they probably already have to ask that since it's settable from kernel
command line, and /etc/fstab...

Mike
