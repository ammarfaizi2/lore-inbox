Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161269AbWGJAER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbWGJAER (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbWGJAER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:04:17 -0400
Received: from ns.suse.de ([195.135.220.2]:23736 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161269AbWGJAEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:04:16 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] i386: use thread_info flags for debug regs and IO  bitmaps
Date: Mon, 10 Jul 2006 01:59:44 +0200
User-Agent: KMail/1.9.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Stephane Eranian <eranian@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200607071155_MC3-1-C45F-B7C2@compuserve.com> <Pine.LNX.4.64.0607081425430.3869@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607081425430.3869@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607100159.44625.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 23:26, Linus Torvalds wrote:
> 
> On Fri, 7 Jul 2006, Chuck Ebbert wrote:
> >
> > From: Stephane Eranian <eranian@hpl.hp.com>
> > 
> > Use thread info flags to track use of debug registers and IO bitmaps.
> >  
> > 	- add TIF_DEBUG to track when debug registers are active
> >  	- add TIF_IO_BITMAP to track when I/O bitmap is used
> >  	- modify __switch_to() to use the new TIF flags
> 
> Can you explain what the advantages of this are?
> 
> I don't see it. It's just creating new state to describe state that we 
> already had, and as far as I can tell, it's just a way to potentially have 
> more new bugs thanks to the new state getting out of sync with the old 
> one?

It turns two checks in context switch into a single one. With some luck
it will even touch one cache line less.

I requested this for x86-64 because Stephane wants to add more state to check
(performance counters) in there for his perfmon2 patches, and with that 
infrastructure in place it can be added without adding more cost for the 
common case.

Chuck ported the x86-64 version to i386.

-Andi
