Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTLLMz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 07:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264570AbTLLMz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 07:55:29 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:44203 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264569AbTLLMz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 07:55:28 -0500
Date: Fri, 12 Dec 2003 13:55:13 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Rob Landley <rob@landley.net>
Cc: Hua Zhong <hzhong@cisco.com>, "'Andy Isaacson'" <adi@hexapodia.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031212125513.GC6112@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org> <017c01c3c01b$232bd130$d43147ab@amer.cisco.com> <20031211194815.GA10029@wohnheim.fh-wedel.de> <200312111432.12683.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200312111432.12683.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 December 2003 14:32:12 -0600, Rob Landley wrote:
> On Thursday 11 December 2003 13:48, Jörn Engel wrote:
> >
> > If you really do it, please don't add a syscall for it.  Simply check
> > each written page if it is completely filled with zero.  (This will be
> > a very quick check for most pages, as they will contain something
> > nonzero in the first couple of words)
> 
> Cache poisoning, streaming writes to large RAID arrays...  There are about 8 
> zllion reasons not to do this.  Really.  (It defeats the whole purpose of 
> DMA, doesn't it?)

Yes, the obvious and stupid implementation has a ton of problems.
Most likely the right approach is some sort of background deamon
(garbage collector, defragmenter, journald, whatever you may call it)
that does exacly this even after the fact for the last unchecked
writes.  Asyncronous under load, possibly even synchronous when almost
idle.

A stupid implementation would still help for some workload (few, while
hurting many) and already get the code tested, so even a stupid
implementation helps.

Jörn

-- 
There's nothing better for promoting creativity in a medium than
making an audience feel "Hmm ­ I could do better than that!"
-- Douglas Adams in a slashdot interview
