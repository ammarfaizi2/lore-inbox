Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310510AbSCEHZC>; Tue, 5 Mar 2002 02:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310483AbSCEHYv>; Tue, 5 Mar 2002 02:24:51 -0500
Received: from rj.sgi.com ([204.94.215.100]:23448 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S293614AbSCEHYh>;
	Tue, 5 Mar 2002 02:24:37 -0500
Date: Mon, 4 Mar 2002 23:22:52 -0800 (PST)
From: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Message-Id: <10203042322.ZM444253@classic.engr.sgi.com>
In-Reply-To: James Bottomley <James.Bottomley@SteelEye.com>
        "Re: [PATCH] 2.4.x write barriers (updated for ext3)" (Mar  4,  8:57am)
In-Reply-To: <200203041457.g24EvvU01682@localhost.localdomain>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 4,  8:57am, James Bottomley wrote:
> 
> > 2a) Are the filesystems asking for something impossible?  Can drives
> > really write block N and N+1, making sure to commit N to media before
> > N+1 (including an abort on N+1 if N fails), but still keeping up a
> > nice seek free stream of writes? 
> 
> These are the "big" issues.  There's not much point doing all the work to 
> implement ordered tags, if the end result is going to be no gain in 
> performance.


If a drive does reduced latency writes, then blocks can be written out
of order.  Also, for a trivial case:  with hardware RAIDs, when the
data for a single command is split across multiple drives, you can get
data blocks written out of order, no matter what you do.

I don't think a filesystem can make any assumptions about blocks within
a single command, though with ordered tags (assuming driver and device
support) and no write caching, it can make assumptions between commands.

jeremy
