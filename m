Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTIHJuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbTIHJtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:49:03 -0400
Received: from angband.namesys.com ([212.16.7.85]:38596 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262321AbTIHJs0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:48:26 -0400
Date: Mon, 8 Sep 2003 13:48:25 +0400
From: Oleg Drokin <green@namesys.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030908094825.GD10487@namesys.com>
References: <slrnbl12sv.i4g.erik@bender.home.hensema.net> <3F50D986.6080707@namesys.com> <20030831191419.A23940@bitwizard.nl> <20030908081206.GA17718@namesys.com> <20030908105639.B26722@bitwizard.nl> <20030908090826.GB10487@namesys.com> <20030908113304.A28123@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908113304.A28123@bitwizard.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Sep 08, 2003 at 11:33:04AM +0200, Rogier Wolff wrote:
> > > > > There  is no installation program that will fail with: "Sorry, 
> > > > > you only have 100 million inodes free, this program will need
> > > > > 132 million after installation", and it allows me a quick way 
> > > > > of counting the number of actual files on the disk.... 
> > > > You cannot. statfs(2) only exports "Total number of inodes on disk" and
> > > > "number of free inodes on disk" values for fs. df substracts one from another one
> > > > to get "number of inodes in use".
> > > So, you report "oids_in_use + 100M" as total and "100M" as free inodes 
> > > on disk. Voila!
> > Yes, we thought about that too. Need to be careful to not overflow
> > "long int".  
> > And idea of filesystem with variable amount of inodes over time
> > sounds confusing to me, too.  ]
> SO? That's actually the case. So it's confusing. So you're confusing
> people even more by telling nothing. Great. 

Well, but statfs(2) does not return an "inodes in use" value, that's it.

> #define LARGE_NUMBER 100000
> out->total_inodes = fs->oids_in_use + LARGE_NUMBER; 
> if (out->total_inodes < fs->oids_in_use) 
>    out -> total_inods = MAXINT;
> out -> free_inodes = LARGE_NUMBER; 
> Three lines of code fixes that. 

Yes, and you get complete crap once you hit the overflow condition?

> > Well, if current interface does not allow to see all the stuff you want to,
> > time to change (introduce new one) interface, anyway.
> Fine, introduce a new interface. But report as much as you can on the
> old interface. Remember you can read/write/seek files using the 32bit
> interface even though the new (seek-, and stat-) interface uses 64
> bits.

You need to open a file with O_LARGEFILE first, so old binaries still won't work.

Bye,
    Oleg
