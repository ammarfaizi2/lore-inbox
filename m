Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTDZJFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 05:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTDZJFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 05:05:37 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:52695 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261287AbTDZJFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 05:05:36 -0400
Date: Sat, 26 Apr 2003 11:17:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: rmoser <mlmoser@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re:  Swap Compression
Message-ID: <20030426091747.GD23757@wohnheim.fh-wedel.de>
References: <200304251848410590.00DEC185@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304251848410590.00DEC185@smtp.comcast.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 April 2003 18:48:41 -0400, rmoser wrote:
> 
> Yeah, I had to mail it 3 times.  Lst time I figured it out.

<more formal junk>
- Your mailer doesn't generate In-Reply-To: or References: Headers.
This breaks threading.
- It is usually more readable if you reply below the quoted text you
refer to.
- Most people prefer, if you reply to all. Not everyone here is
actually subscribed to the list.
- Feel free to ignore any of this, as long as the mail contains
interesting information. :)
</more formal junk>

> As for the performance hit, the original idea of that very tiny format was
> to pack 6502 programs into 4k of code.  The expansion phase is very
> tight and very efficient, and on a ... anything... it will provide no problem.
> The swap-on-ram as long as it's not like 200 MB uncompressed SOR and
> 1 MB RAM will I think work great in the decompression phase.
> 
> Compression will take a little overhead.  I think if you use a boyer-moore
> fast string search algo for binary strings (yes you can do this), you can
> quickly compress the data.  It may be like.. just a guess... 10-30 times
> more overhead than the decompression phase.  So use it on at least a
> 10-30 mhz processor.  If I ever write the code, it won't be kernel; just the
> compression/decompression program (userspace).  Take the code and
> stuff it into the kernel if I do.  I'll at the point of the algo coming in to
> existence make another estimate.

A userspace program would be just fine. Send it to me and I'll convert
it to the kernel, putting it somewhere under lib/.
Do you have any problems with a GPL license to your code (necessary
for kernel port)?

> The real power in this is Swap on RAM, but setting that as having precidence
> over swap on disk (normal swaps) would decrease disk swap usage by
> supplying more RAM in RAM.  And of course swapping RAM to RAM is
> a lot faster.  I'm looking at this for PDA's but yes I will be running this on
> my desktop the day we see it.

Swapping RAM to RAM sounds interesting, but also quite complicated. As
a first step, I would try to compress the swap data before going to
disk, that should be relatively simple to do.

("I would" means, I will if I find the time for it.)

> Well, I could work on the compression code, mebbe I can put the tarball up
> here.  If I do I'd expect someone to add the code to swap to work with it--in
> kernel 2.4 at the very least (port it to dev kernel later!).  As a separate module.
> We don't want code that could be mean in the real swap driver. :)

Right. But for 2.4, there is no swap driver, that you can simply
enable or disable. I hacked up a patch, but so far, disabling swap
eats ~100k of memory every second, so that clearly needs more work.

Jörn

-- 
Do not stop an army on its way home.
-- Sun Tzu
