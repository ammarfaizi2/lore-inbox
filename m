Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133051AbRDWNTD>; Mon, 23 Apr 2001 09:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133073AbRDWNSv>; Mon, 23 Apr 2001 09:18:51 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:12999 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S133066AbRDWNR4>; Mon, 23 Apr 2001 09:17:56 -0400
Date: Mon, 23 Apr 2001 15:17:53 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Christoph Rohland <cr@sap.com>
Cc: "David L. Parsley" <parsley@linuxjedi.org>, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
Subject: Re: hundreds of mount --bind mountpoints?
Message-ID: <20010423151753.C719@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3AE307AD.821AB47C@linuxjedi.org> <m3r8yjrgdc.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <m3r8yjrgdc.fsf@linux.local>; from cr@sap.com on Mon, Apr 23, 2001 at 01:43:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 01:43:27PM +0200, Christoph Rohland wrote:
> On Sun, 22 Apr 2001, David L. Parsley wrote:
> > attach packages inside it.  Since symlinks in a tmpfs filesystem
> > cost 4k each (ouch!), I'm considering using mount --bind for
> > everything.
> 
> What about fixing tmpfs instead?

The question is: How? If you do it like ramfs, you cannot swap
these symlinks and this is effectively a mlock(symlink) operation
allowed for normal users. -> BAD!

One idea is to only use a page, if the entry will be pushed into
swap and thus only wasting swap, not memory (where we have more
of it).

But allocating a page on memory pressure is also not a bright
idea.

OTOH we could force this entry to swap immedately, after we
copied it from the dentry. So we can do an GFP_ATOMIC allocation
and do not too much harm to memory pressure and only make the IO
a bit stormier.

I think there are a lot of races, which I don't see now.

So please don't beat me too much, if this is a completly stupid
idea, ok?  ;-)


Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
