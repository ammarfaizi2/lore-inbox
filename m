Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269589AbTGJWP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbTGJWP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:15:27 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:27808 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S269589AbTGJWNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:13:33 -0400
Date: Thu, 10 Jul 2003 15:28:08 -0700
From: Larry McVoy <lm@bitmover.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Style question: Should one check for NULL pointers?
Message-ID: <20030710222808.GA19308@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <7QmZ.5RP.17@gated-at.bofh.it> <3F0DD3FD.3030403@triphoenix.de> <bekof0$g7i$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bekof0$g7i$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 03:13:52PM -0700, H. Peter Anvin wrote:
> Followup to:  <3F0DD3FD.3030403@triphoenix.de>
> By author:    Dennis Bliefernicht <itsme.nospam@triphoenix.de>
> In newsgroup: linux.dev.kernel
> > 
> > The problem is IMHO code where some pretty fragile things are handled, 
> > especially file systems. I'd say: DO the paranoia checks if some fragile 
> > things are involved like key structures of the file system that can take 
> > _permanent_ damage. If you check for a NULL pointer you still have the 
> > chance to properly leave the system in a consistent state and no user 
> > will be happy if his filesystem goes messy just because someone saved a 
> > check to have nicer code, even if the original of the NULL pointer 
> > wasn't his fault, even if it's a developing version. So if the check 
> > isn't a total performace disaster, do it whenever permanent damage could 
> > occur.
> > 
> 
> Actually, you have it somewhat backwards.
> 
> In most cases, checking for NULL pointers (and returning an error
> whatnot) is actually *more* likely to cause permanent damage than
> having the kernel bomb out.  At least with the kernel bombing out you
> won't keep grinding on a filesystem for which your kernel
> datastructures are bad.  This is *IMPORTANT*.

In BK, we have a READ_ONLY flag on each revision history file.  Whenever
we get into a state where we don't understand what's going on, we set that
flag.  That flag is checked in the code path which writes the file and it
will simply refuse the write the file if the flag is set.

Seems like the same idea would work here.  I can imagine a lot of use for
a file system which remounts itself as read only the second it sees a 
problem it can't handle.  At least you can poke around and try and figure
out what is going on.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
