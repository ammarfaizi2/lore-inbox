Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRCBTq3>; Fri, 2 Mar 2001 14:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbRCBTqU>; Fri, 2 Mar 2001 14:46:20 -0500
Received: from [209.102.105.34] ([209.102.105.34]:52748 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129443AbRCBTqH>;
	Fri, 2 Mar 2001 14:46:07 -0500
Date: Fri, 2 Mar 2001 11:45:41 -0800
From: Tim Wright <timw@splhi.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Scott Laird <laird@internap.com>, linux-kernel@vger.kernel.org
Subject: Re: Another rsync over ssh hang (repeatable, with 2.4.1 on both ends)
Message-ID: <20010302114541.C1438@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	Scott Laird <laird@internap.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0103011607540.17365-100000@laird.ocp.internap.com> <20010302101236.A21799@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010302101236.A21799@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Mar 02, 2001 at 10:12:36AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2001 at 10:12:36AM +0000, Russell King wrote:
> On Thu, Mar 01, 2001 at 04:41:01PM -0800, Scott Laird wrote:
> > I have a fairly repeatable rsync over ssh stall that I'm seeing between
> > two Linux boxes, both running identical 2.4.1 kernels.  The stall is
> > fairly easy to repeat in our environment -- it can happen up to several
> > times per minute, and usually happens at least once per minute.  It
> > doesn't really seem to be data-sensitive.  The stall will last until the
> > session times out *unless* I take one of two steps to "unstall" it.  The
> > easiest way to do this is to run 'strace -p $PID' against the sending ssh
> > process.  As soon as the strace is started, rsync starts working again,
> > but will stall again (even with strace still running) after a short period
> > of time.
> >...
> > According to 'ps l', the ssh process is waiting in 'sock_wait_for_wmem'.
> 
> I've also reported this recently, and got told that it was because I was
> running 2.2.15pre13 on one end.  Thanks for confirming that 2.2.15pre13
> is not the cause.
> 

Be very careful here. He did nothing of the sort. He merely indicated that
there is at least one problem running rsync over ssh between 2.4.1 systems.
There is no guarantee that your problem and his are identical. As Alexey
pointed out, there are bad bugs in 2.2.15 which can cause a TCP connection to
get stuck. Given that you are running 2.2.15, you'd need a tcpdump to
determine whether you hit one of these or not.

I've been bitten too many times assuming something was one big problem only
to find out later it was actually several smaller ones.

Regards,

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
