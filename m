Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316724AbSERBfz>; Fri, 17 May 2002 21:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316735AbSERBfy>; Fri, 17 May 2002 21:35:54 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:58885
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S316724AbSERBfx>; Fri, 17 May 2002 21:35:53 -0400
Date: Fri, 17 May 2002 18:35:37 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Thoughts on using fs/jbd from drivers/md
Message-ID: <20020518013537.GH627@matchmail.com>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <15587.18828.934431.941516@notabene.cse.unsw.edu.au> <20020516161749.D2410@redhat.com> <20020517182942.GF627@matchmail.com> <20020517193410.W2693@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 07:34:10PM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, May 17, 2002 at 11:29:42AM -0700, Mike Fedyk wrote:
> > On Thu, May 16, 2002 at 04:17:49PM +0100, Stephen C. Tweedie wrote:
> 
> > > Right.  The ability of soft raid5 to lose data in degraded mode over a
> > > reboot (including data that was not being modified at the time of the
> > > crash) is something that is not nearly as widely understood as it
> > > should be, and I'd love for us to do something about it.
> > 
> > Are there workarounds to avoid this problem?
> 
> No.
> 
> > What does it take to trigger the corruption?
> 
> It just takes degraded mode, an unexpected power cycle, and concurrent
> write activity.  
> 
> Degraded mode relies on the parity disk being in sync at all times ---

Doesn't degraded mode imply that there are not any parity
disk(raid4)/stripe(raid5) updates?

> you can't recover data from the missing spindle unless that is true.
> However, writes to a stripe are not atomic, and you can get a reboot
> when, say, a write to one of the surviving data chunks has succeeded,
> but the corresponding write to the parity disk has not.  If this
> happens, the parity is no longer in sync, and the data belonging to
> the missing spindle in that stripe will be lost forever.
> 
> > I ask this because I have used a degraded raid5 because the source drive
> > would become a member, but I needed to copy the data first.  While doing so,
> > I had to reboot a couple times to reconfigure the boot loader.  All seems to
> > be working fine on the system today though.
> 
> If it was a clean shutdown and reboot, you're fine.
>

OK, that's good.
