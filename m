Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316638AbSEQSeW>; Fri, 17 May 2002 14:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316639AbSEQSeV>; Fri, 17 May 2002 14:34:21 -0400
Received: from pc-62-31-66-178-ed.blueyonder.co.uk ([62.31.66.178]:14724 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316638AbSEQSeV>; Fri, 17 May 2002 14:34:21 -0400
Date: Fri, 17 May 2002 19:34:10 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Thoughts on using fs/jbd from drivers/md
Message-ID: <20020517193410.W2693@redhat.com>
In-Reply-To: <15587.18828.934431.941516@notabene.cse.unsw.edu.au> <20020516161749.D2410@redhat.com> <20020517182942.GF627@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 17, 2002 at 11:29:42AM -0700, Mike Fedyk wrote:
> On Thu, May 16, 2002 at 04:17:49PM +0100, Stephen C. Tweedie wrote:

> > Right.  The ability of soft raid5 to lose data in degraded mode over a
> > reboot (including data that was not being modified at the time of the
> > crash) is something that is not nearly as widely understood as it
> > should be, and I'd love for us to do something about it.
> 
> Are there workarounds to avoid this problem?

No.

> What does it take to trigger the corruption?

It just takes degraded mode, an unexpected power cycle, and concurrent
write activity.  

Degraded mode relies on the parity disk being in sync at all times ---
you can't recover data from the missing spindle unless that is true.
However, writes to a stripe are not atomic, and you can get a reboot
when, say, a write to one of the surviving data chunks has succeeded,
but the corresponding write to the parity disk has not.  If this
happens, the parity is no longer in sync, and the data belonging to
the missing spindle in that stripe will be lost forever.

> I ask this because I have used a degraded raid5 because the source drive
> would become a member, but I needed to copy the data first.  While doing so,
> I had to reboot a couple times to reconfigure the boot loader.  All seems to
> be working fine on the system today though.

If it was a clean shutdown and reboot, you're fine.

Cheers, 
 Stephen
