Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSE3UDj>; Thu, 30 May 2002 16:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316861AbSE3UDi>; Thu, 30 May 2002 16:03:38 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:44301
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S316857AbSE3UDg>; Thu, 30 May 2002 16:03:36 -0400
Date: Thu, 30 May 2002 13:03:32 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Processes stuck in D state with autofs + smbfs
Message-ID: <20020530200332.GD1136@matchmail.com>
Mail-Followup-To: Urban Widmark <urban@teststation.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020529172616.GB1136@matchmail.com> <Pine.LNX.4.33.0205301421540.1921-100000@cola.enlightnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 02:36:43PM +0200, Urban Widmark wrote:
> On Wed, 29 May 2002, Mike Fedyk wrote:
> 
> > I'm currently running 2.4.19-pre6-vm33 on this 2x664Mhz P3 machine, but I've
> > also had the problem in the previous UP machine.
> > 
> > I'm not sure what information will be helpful in debugging this probem.
> > Would sysrq+t run through ksymoops be helpful?
> 
> Yes, it could show where the process is stuck. Probably what has happened
> is that some process is blocked while holding the smbfs semaphore (there
> is one per mount).
> 
> All others will then get stuck in 'D' state trying to get that semaphore.
> 
> The "classic" way to get this is to have a server that is shutdown while
> it is mounted. There are patches to help with that (and if I wasn't so
> slow sometimes a simple fix would already be in 2.4.something, after
> 2.4.19 I promise).
>

Yes, the remote server was shut down and caused this problem.

> > I also have this in my kernel log:
> > May 26 06:33:16 fileserver kernel: Uhhuh. NMI received. Dazed and confused, but trying to continue
> > May 26 06:33:16 fileserver kernel: You probably have a hardware problem with your RAM chips
> 
> However, this error could (but I don't really know what the effects are of
> this) potentially stop a process at some random point. If a process
> crashes, for example an oops, while holding the semaphore that semaphore
> will still be held and everyone trying to get in will stop in D state.
>

I will resove this issue soon, but don't forget that the processes stuck in
D state has been happening for a while on another machine also.

> 
> There are some patches here:
> http://www.hojdpunkten.ac.se/054/samba/index.html
> 
> But that server appears to be down right now.
> 
> There is one patch that uses poll to help with the problem of a server
> that is gone, and another that changes a lot of how smbfs sends requests
> and additionaly makes the user processes always(?) be interruptible.
>

Do these require any changes to the samba userspace?

> But if the NMIs are killing things at random points then none of those
> patches will help.

AFAICT, no processes have been killed.  I'm going to try to reproduce this
on another machine and I'll post the sysrq+t ksymoops output from that.
I'll probably have to do it next week though.

Mike
