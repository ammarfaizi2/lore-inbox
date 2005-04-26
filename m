Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVDZJ4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVDZJ4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVDZJut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:50:49 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:61624 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261450AbVDZJrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:47:01 -0400
Date: Tue, 26 Apr 2005 11:46:35 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, dahinds@users.sourceforge.net,
       rddunlap@osdl.org
Subject: Re: [PATCH linux-2.6.12-rc2-mm3] smc91c92_cs: Reduce stack usage in smc91c92_event()
Message-ID: <20050426094634.GA20971@wohnheim.fh-wedel.de>
References: <df35dfeb05042115021c24638b@mail.gmail.com> <200504221122.51579.vda@port.imtp.ilyichevsk.odessa.ua> <20050423001228.GA6418@wohnheim.fh-wedel.de> <200504231821.31309.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504231821.31309.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 April 2005 18:21:30 +0300, Denis Vlasenko wrote:
> On Saturday 23 April 2005 03:12, Jörn Engel wrote:
> 
> > > 1) struct is unnamed and local to function
> > > 2) Variables do not change their type, the just sit in local-> now.
> > >    I can just add 'local->' to each affected variable,
> > >    without "it was an object, now it is a pointer" changes.
> > >    No need to replace . with ->, remove &, etc.
> > 
> > I'd have proposed the same, before reading further down in the patch.
> > Basically, the driver is full of duplication, so the exact same struct
> > can be used several times.  Therefore, the downsides of your approach
> > seem to prevail.
> 
> What downsides? I must admit I do not understand your answer here.

1. Read the patch.  All of it.

2. Virtually the same identical variables are stuffed into the stack
frames of:
o mhz_mfc_config,
o mhz_setup,
o mot_setup,
o smc_setup,
o osi_setup and
o smc91c92_config.

That is six functions.  If it were just one, I would definitely agree
with you.  For two functions, well, it wouldn't really matter either
way.  But should six functions all copy the exact same struct six
different times instead of referencing a single globally defined one?
Naa, that's barely an advantage.

> Instead, I'd do it like I described in previous mail:

If you would actually like to do something, please provide further
patches to that driver.  It sucks.  It sucks so bad, that it's hardly
possible to change anything without improving it.  There are much
grosser things to clean up than the one we're discussing right now.

Jörn

-- 
He who knows others is wise.
He who knows himself is enlightened.
-- Lao Tsu
