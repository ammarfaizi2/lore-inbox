Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268434AbRGXTPw>; Tue, 24 Jul 2001 15:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268436AbRGXTPn>; Tue, 24 Jul 2001 15:15:43 -0400
Received: from chmls05.mediaone.net ([24.147.1.143]:40163 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S268434AbRGXTPc>; Tue, 24 Jul 2001 15:15:32 -0400
From: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Tue, 24 Jul 2001 15:05:35 -0400
To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
Message-ID: <20010724150535.B27771@pimlott.ne.mediaone.net>
Mail-Followup-To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
	linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
	martizab@libertsurf.fr, rusty@rustcorp.com.au
In-Reply-To: <3B5C91DA.3C8073AC@wanadoo.fr> <20010724090704.A27771@pimlott.ne.mediaone.net> <3B5DACDA.69D0B81A@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B5DACDA.69D0B81A@wanadoo.fr>; from jerome.de-vivie@wanadoo.fr on Tue, Jul 24, 2001 at 07:14:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 07:14:02PM +0200, Jerome de Vivie wrote:
> Andrew Pimlott a ?crit :
> > per-user?  So how do I let another developer look at what I'm
> > working on?  In ClearCase, it's one private version per-view, which
> > is much more flexible.
> 
> No.

So you're saying if I have a file on my UFL, there's no way anyone
else can see it unless I copy it to another filesystem?

> > If I have to check in all files at once, it is even more important
> > that I be able to have multiple "views".  What if, in the middle of
> > a big change, I make a small fix that I want to check in
> > independently?
> 
> It's impossible. If you want to go back, you have to put a label on 
> each step you want and, set the $CONFIGURATION to this label.

Again, this seems exceedingly restrictive.

> > You just threw away the most useful feature of filesystem
> > integration: comparing different versions.  How do I do this if
> > everything is keyed off $CONFIGURATION?
> 
> With 2 process and shared memory, it should be possible but i haven't
> though deeper.

Standard tools, please.  (Can I tell you how painful I would find
ClearCase if I had to use their diff instead of GNU diff?)

> > I really don't see what you've gained over CVS.  (Once you add in
> > all the little things you didn't mention: setting up the filesystem,
> > adding files to version control, etc, I don't think you can argue
> > that your system is simpler.)
> 
> A developper has a minimum operation to do:
> -set his configuration
> -commit his work
> 
> That's all ! No branch, no config-spec, no view server, no vob server,
> no registery server, no ci, no co, ...

I said, compared to CVS, not ClearCase!  The analog in CVS is
- cvs checkout
- cvs update

The only advantages your have are 1) you don't have to specify the
repository/modules and 2) you're faster.

Also, you have left out at least one important step.  Say I set
CONFIGURATION=A, do my work, and label it with B.  How do other
developers know to switch to B?   What if they're already working
off A--how do they merge up their private copies?

If you say your system is not intended for concurrent development, I
think it is not worth doing.  And from what I can see, you're
building in restrictions that would make concurrent development
hard.

> > How will the existing merge tool work, if a single process can only
> > see one $CONFIGURATION?
> 
> Same as for diff (...but now, obolete)

But you said "existing" merge tool.

What do you mean by obsolete?  You don't mean to say that the need
for merging is eliminated, do you?

> Using the same system 
> (labelization) to identify both individual version and configuration 
> is also a neat idea.

It is neat, but eventually will become a pain in the neck.  You'll
need a way to come up with a unique label for every checkin, so you
will inevitably just decide to use incrementing numbers, so pretty
soon you will end up with files having versions 1, 5, 329, and
18473.  Ugh.

Andrew
