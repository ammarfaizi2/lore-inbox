Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVKUSwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVKUSwP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVKUSwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:52:15 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3229 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932404AbVKUSwO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:52:14 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Tarkan Erimer <tarkane@gmail.com>
Subject: Re: what is our answer to ZFS?
Date: Mon, 21 Nov 2005 12:52:04 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Diego Calleja <diegocg@gmail.com>
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121124544.9e502404.diegocg@gmail.com> <9611fa230511210619l208b10a8w77aedaa249345448@mail.gmail.com>
In-Reply-To: <9611fa230511210619l208b10a8w77aedaa249345448@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511211252.04217.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 08:19, Tarkan Erimer wrote:
> On 11/21/05, Diego Calleja <diegocg@gmail.com> wrote:
> If It happenned, Sun or someone has port it to linux.
> We will need some VFS changes to handle 128 bit FS as "Jörn ENGEL"
> mentionned previous mail in this thread. Is there any plan or action
> to make VFS handle 128 bit File Sytems like ZFS or future 128 bit
> File Systems ? Any VFS people reply to this, please?

I believe that on 64 bit platforms, Linux has a 64 bit clean VFS.  Python says 
2**64 is 18446744073709551616, and that's roughly:
18,446,744,073,709,551,616 bytes
18,446,744,073,709 megs
18,446,744,073 gigs
18,446,744 terabytes
18,446 ...  what are those, petabytes?
18 Really big lumps of data we won't be using for a while yet.

And that's just 64 bits.  Keep in mind it took us around fifty years to burn 
through the _first_ thirty two (which makes sense, since Moore's Law says we 
need 1 more bit every 18 months).  We may go through it faster than we went 
through the first 32 bits, but it'll last us a couple decades at least.

Now I'm not saying we won't exhaust 64 bits eventually.  Back to chemistry, it 
takes 6.02*10^23 protons to weigh 1 gram, and that's just about 2^79, so it's 
feasible that someday we might be able to store more than 64 bits of data per 
gram, let alone in big room-sized clusters.   But it's not going to be for 
years and years, and that's a design problem for Sun.

Sun is proposing it can predict what storage layout will be efficient for as 
yet unheard of quantities of data, with unknown access patterns, at least a 
couple decades from now.  It's also proposing that data compression and 
checksumming are the filesystem's job.  Hands up anybody who spots 
conflicting trends here already?  Who thinks the 128 bit requirement came 
from marketing rather than the engineers?

If you're worried about being able to access your data 2 or 3 decades from 
now, you should _not_ be worried about choice of filesystem.  You should be 
worried about making it _independent_ of what filesystem it's on.  For 
example, none of the current journaling filesystems in Linux were available 
20 years ago, because fsck didn't emerge as a bottleneck until filesystem 
sizes got really big.

Rob
