Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312827AbSCVUYr>; Fri, 22 Mar 2002 15:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312833AbSCVUYh>; Fri, 22 Mar 2002 15:24:37 -0500
Received: from [195.39.17.254] ([195.39.17.254]:55939 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312827AbSCVUY3>;
	Fri, 22 Mar 2002 15:24:29 -0500
Date: Fri, 22 Mar 2002 16:05:43 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
Message-ID: <20020322160542.G37@toy.ucw.cz>
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk> <3C959716.6040308@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We don't need fadvise IMHO. That is what open(2) is for. The streaming 
> > request you are asking for is just a normal open(2). It will do read 
> > ahead which is perfect for streaming (of data size << RAM size in its 
> > current form).
> >
> > When you want large data streaming, i.e. you start getting worried 
> > about memory pressure, then you want open(2) + O_DIRECT. No caching 
> > done. Perfect for large data streams and we have that already. I agree 
> > that you may want some form of asynchronous read ahead with passed 
> > pages being dropped from the cache but that could be just a open(2) + 
> > O_SEQUENTIAL (doesn't exist yet).
> >
> > All of what you are asking for exists in Windows and all the semantics 
> > are implemented through a very powerful open(2) equivalent. I don't 
> > see why we shouldn't do the same. It makes more sense to me than 
> > inventing yet another system call...
> 
> 
> 
> I disagree, and here's the main reasons:
> 
> * fadvise(2) usefulness extends past open(2).  It may be useful to call 
> it at various points during runtime.

open(/proc/self/fd/0, O_NEW_FLAGS)?

> * I think putting hints in open(2) is the wrong direction to go.  Hints 
> have a potential to be very flexible.  open(2) O_xxx bits are not to be 
> squandered lightly, while I see a lot more value in being a little more 
> loose and free with the bit assignment for an "fadvise mask" (just a 
> list of hint bits).  IMO it should be easier to introduce and retire 
> hints, far easier than O_xxx flags.

I don't like idea of new syscall when open works just fine. First prove
O_X hints are usefull, then extend them.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

