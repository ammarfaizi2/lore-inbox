Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVHPSw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVHPSw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVHPSw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:52:26 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:22426 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030296AbVHPSwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:52:25 -0400
Date: Tue, 16 Aug 2005 20:52:30 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Flash erase groups and filesystems
Message-ID: <20050816185230.GA2931@wohnheim.fh-wedel.de>
References: <4300F963.5040905@drzeus.cx> <20050816162735.GB21462@wohnheim.fh-wedel.de> <43021DB8.70909@drzeus.cx> <20050816181336.GA2014@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050816181336.GA2014@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 August 2005 20:13:36 +0200, Jörn Engel wrote:
> On Tue, 16 August 2005 19:09:12 +0200, Pierre Ossman wrote:
> > 
> > I'm not sure we're talking about the same thing. I'm not suggesting new
> > features in the VFS layer. I want to know if something breaks if I
> > implement this erase feature in the MMC layer. In essence the file
> > system has marked the sectors as "forget" by issuing a write to them.
> > The question is if it is assumed that they are unchanged if the write
> > fails half-way through.
> 
> Yes.  Most filesystems expect to find either 1) old data or 2) new
> data.  Blocks full of 0xff are non-expected.

Maybe this isn't obvious.  Because of this expectation, it is
absolutely not safe to pre-erase blocks, just because the fs will
write them anyway.  Unless you can guarantee that the write will
always succeed, even in case of power outage, you just broke the
expectation.

Fixing all filesystem is also not an option, even ignoring the
question whether such a change would be a fix, a change of behaviour
or a plain bug.

So the only remaining option is to add a new interface that lets
filesystems decide to support pre-erase in some form.  And one such
interface would be the "forget" operation.  Nice attribute of forget
is the fact that it would also help some FTL layers in the kernel.
There is nothing MMC-specific about it.

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens
