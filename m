Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262581AbRFNDRP>; Wed, 13 Jun 2001 23:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262593AbRFNDRF>; Wed, 13 Jun 2001 23:17:05 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:36873 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262581AbRFNDQ7>;
	Wed, 13 Jun 2001 23:16:59 -0400
Date: Thu, 14 Jun 2001 00:16:41 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <992483368.3b281828dde02@eargle.com>
Message-ID: <Pine.LNX.4.21.0106140013000.14934-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001, Tom Sightler wrote:
> Quoting Rik van Riel <riel@conectiva.com.br>:
> 
> > After the initial burst, the system should stabilise,
> > starting the writeout of pages before we run low on
> > memory. How to handle the initial burst is something
> > I haven't figured out yet ... ;)
> 
> Well, at least I know that this is expected with the VM, although I do
> still think this is bad behavior.  If my disk is idle why would I wait
> until I have greater than 100MB of data to write before I finally
> start actually moving some data to disk?

The file _could_ be a temporary file, which gets removed
before we'd get around to writing it to disk. Sure, the
chances of this happening with a single file are close to
zero, but having 100MB from 200 different temp files on a
shell server isn't unreasonable to expect.

> > This is due to this smarter handling of the flushing of
> > dirty pages and due to a more subtle bug where the system
> > ended up doing synchronous IO on too many pages, whereas
> > now it only does synchronous IO on _1_ page per scan ;)
> 
> And this is definately a noticeable fix, thanks for your continued
> work.  I know it's hard to get everything balanced out right, and I
> only wrote this email to describe some behavior I was seeing and make
> sure it was expected in the current VM.  You've let me know that it
> is, and it's really minor compared to problems some of the earlier
> kernels had.

I'll be sure to keep this problem in mind. I really want
to fix it, I just haven't figured out how yet  ;)

Maybe we should just see if anything in the first few MB
of inactive pages was freeable, limiting the first scan to
something like 1 or maybe even 5 MB maximum (freepages.min?
freepages.high?) and flushing as soon as we find more unfreeable
pages than that ?

Maybe another solution with bdflush tuning ?

I'll send a patch as soon as I figure this one out...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

