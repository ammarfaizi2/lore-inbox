Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267086AbRGKEEr>; Wed, 11 Jul 2001 00:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267163AbRGKEEh>; Wed, 11 Jul 2001 00:04:37 -0400
Received: from www.wen-online.de ([212.223.88.39]:54799 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S267086AbRGKEEX>;
	Wed, 11 Jul 2001 00:04:23 -0400
Date: Wed, 11 Jul 2001 06:03:08 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Christoph Rohland <cr@sap.com>, Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.21.0107102201360.2021-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107110548410.583-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, Marcelo Tosatti wrote:

> On Mon, 9 Jul 2001, Mike Galbraith wrote:
>
> > On 9 Jul 2001, Christoph Rohland wrote:
> >

[snip]

> > > > So, did I fix it or just bust it in a convenient manner ;-)
> > >
> > > ... now you drop random pages. This of course helps reducing memory
> > > pressure ;-)
> >
> > (shoot.  I figured that was too easy to be right)
> >
> > > But still this may be a hint. You are not running out of swap, aren't
> > > you?
> >
> > I'm running oom whether I have swap enabled or not.  The inactive
> > dirty list starts growing forever, until it's full of (aparantly)
> > dirty pages and I'm utterly oom.
>
> We can make sure if this (inactive full of dirty pages) is really the case
> with the tracing code.

The problem turned out to be KDE.  It opens/unlinks two files in /tmp
per terminal, and lseeks/writes terminal output to them continually.
With tmpfs/ramfs mounted on /tmp....

> The shmem fix in 2.4.7-pre5 is the solution for your problem ?

No.  Now, the pages go to the active list.  The solution is to not
use KDE-2.1's terminals if I fire up X ;-)  It doesn't livelock at
oom anymore though.. thrashes uncontrollably until sysrq-e fixes it's
attitude problem.

(I never saw this problem before because I rarely run X, and never do
anything which generates enough terminal output to oom the box if I do
run it.  I only ran the tar thing by chance, trying to figure out why
people were reporting updatedb causing massive swapping, when it didn't
do that here.. shrug)

> If not, I'll port the tracing code to the pre5 and hopefully we can
> actually figure out what is going on here.

No need.  What looked like a really weird kernel bug turned out to be
a userland bug triggering oom livelock bug.

	-Mike


