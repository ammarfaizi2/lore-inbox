Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTIHM7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 08:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTIHM7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 08:59:22 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:28378 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261299AbTIHM7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 08:59:21 -0400
Date: Mon, 8 Sep 2003 14:59:19 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Oleg Drokin <green@namesys.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030908125919.GA25325@DUK2.13thfloor.at>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
	Nikita Danilov <god@namesys.com>
References: <slrnbl12sv.i4g.erik@bender.home.hensema.net> <3F50D986.6080707@namesys.com> <20030831191419.A23940@bitwizard.nl> <20030908081206.GA17718@namesys.com> <20030908105639.B26722@bitwizard.nl> <20030908090826.GB10487@namesys.com> <20030908113304.A28123@bitwizard.nl> <20030908094825.GD10487@namesys.com> <20030908120531.A28937@bitwizard.nl> <20030908101704.GE10487@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908101704.GE10487@namesys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 02:17:04PM +0400, Oleg Drokin wrote:
> Hello!
> 
> On Mon, Sep 08, 2003 at 12:05:31PM +0200, Rogier Wolff wrote:
> > > Well, but statfs(2) does not return an "inodes in use" value, that's it.
> > > > #define LARGE_NUMBER 100000
> > > > out->total_inodes = fs->oids_in_use + LARGE_NUMBER; 
> > > > if (out->total_inodes < fs->oids_in_use) 
> > > >    out -> total_inods = MAXINT;
> > > > out -> free_inodes = LARGE_NUMBER; 
> > > > Three lines of code fixes that. 
> > > Yes, and you get complete crap once you hit the overflow condition?
> > No. Not complete crap. It's a thirty two bit integer. What do you expect
> > when you hit the "limit"?

what about

total_inods = MAXINT
free_inodes = total_inods - oids_in_use;

this would not change from one moment to
the other, reflect the correct amount, and
stay within limits for reasonable iods_in_use

best,
Herbert

