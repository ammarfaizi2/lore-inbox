Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbTLLNj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264576AbTLLNj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:39:28 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:4053 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S264571AbTLLNj0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:39:26 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Fri, 12 Dec 2003 07:39:25 -0600
User-Agent: KMail/1.5
Cc: Hua Zhong <hzhong@cisco.com>, "'Andy Isaacson'" <adi@hexapodia.org>,
       linux-kernel@vger.kernel.org
References: <20031211125806.B2422@hexapodia.org> <200312111432.12683.rob@landley.net> <20031212125513.GC6112@wohnheim.fh-wedel.de>
In-Reply-To: <20031212125513.GC6112@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200312120739.25162.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 December 2003 06:55, Jörn Engel wrote:
> On Thu, 11 December 2003 14:32:12 -0600, Rob Landley wrote:
> > On Thursday 11 December 2003 13:48, Jörn Engel wrote:
> > > If you really do it, please don't add a syscall for it.  Simply check
> > > each written page if it is completely filled with zero.  (This will be
> > > a very quick check for most pages, as they will contain something
> > > nonzero in the first couple of words)
> >
> > Cache poisoning, streaming writes to large RAID arrays...  There are
> > about 8 zllion reasons not to do this.  Really.  (It defeats the whole
> > purpose of DMA, doesn't it?)
>
> Yes, the obvious and stupid implementation has a ton of problems.
> Most likely the right approach is some sort of background deamon
> (garbage collector, defragmenter, journald, whatever you may call it)
> that does exacly this even after the fact for the last unchecked
> writes.  Asyncronous under load, possibly even synchronous when almost
> idle.

Actually, I'd planned on implementing a cron job that could do it.  We're 
talking a dozen lines of Python code (which can be optimized to only look at 
files with timestamps since the last time it ran).  And doesn't need anything 
from the kernel but the syscall...

Rob
