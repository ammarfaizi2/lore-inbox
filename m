Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292860AbSCEXGo>; Tue, 5 Mar 2002 18:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292817AbSCEXGf>; Tue, 5 Mar 2002 18:06:35 -0500
Received: from dsl-213-023-039-135.arcor-ip.net ([213.23.39.135]:37538 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292855AbSCEXFn>;
	Tue, 5 Mar 2002 18:05:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Wed, 6 Mar 2002 00:01:26 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <200203041457.g24EvvU01682@localhost.localdomain> <10203042322.ZM444253@classic.engr.sgi.com>
In-Reply-To: <10203042322.ZM444253@classic.engr.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16iNvy-0002lU-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 5, 2002 08:22 am, Jeremy Higdon wrote:
> On Mar 4,  8:57am, James Bottomley wrote:
> > 
> > > 2a) Are the filesystems asking for something impossible?  Can drives
> > > really write block N and N+1, making sure to commit N to media before
> > > N+1 (including an abort on N+1 if N fails), but still keeping up a
> > > nice seek free stream of writes? 
> > 
> > These are the "big" issues.  There's not much point doing all the work to 
> > implement ordered tags, if the end result is going to be no gain in 
> > performance.
> 
> If a drive does reduced latency writes, then blocks can be written out
> of order.  Also, for a trivial case:  with hardware RAIDs, when the
> data for a single command is split across multiple drives, you can get
> data blocks written out of order, no matter what you do.

That's ok, the journal takes care of this.  And hence the need to be so
careful about how the journal commit is handled.

> I don't think a filesystem can make any assumptions about blocks within
> a single command, though with ordered tags (assuming driver and device
> support) and no write caching, it can make assumptions between commands.

We're trying to get rid of the 'no write caching' requirement.

-- 
Daniel
