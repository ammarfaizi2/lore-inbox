Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267310AbUG1Qqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUG1Qqu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUG1Qp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:45:56 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:4998 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S267311AbUG1Qpc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:45:32 -0400
From: Rob Landley <rob@landley.net>
To: Marc Ballarin <Ballarin.Marc@gmx.de>, Paul Jackson <pj@sgi.com>
Subject: Re: Interesting race condition...
Date: Wed, 28 Jul 2004 11:46:49 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200407222204.46799.rob@landley.net> <20040728010546.3b7933d5.pj@sgi.com> <20040728135444.79e67ea9.Ballarin.Marc@gmx.de>
In-Reply-To: <20040728135444.79e67ea9.Ballarin.Marc@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407281146.49166.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 July 2004 06:54, Marc Ballarin wrote:
> On Wed, 28 Jul 2004 01:05:46 -0700
>
> Paul Jackson <pj@sgi.com> wrote:
> > Rob wrote:
> > > I just saw a funky thing.  Here's the cut and past from the xterm...
> >
> > Can you reproduce this by cat'ing /proc/<pid>/cmdline?  Can you get a
> > dump of the proc cmdline file to leak the environment sometimes?
> >
> > It is this file that 'ps' is dumping for these options.  Adding the
> > 'e' option would also dump the /proc/<pid>/environ file (if readable).
> >
> > But you aren't adding 'e', so presumably the environment is "leaking"
> > into the the cmdline file.
> >
> > I suspect a kernel bug here - the ps code seems rather obvious and
> > unimpeachable.
>
> I ran the following loop for a while (> 9 million times) and could not
> reproduce the bug, but that might just be coincidence.
> Conditions were the same as in my other, succesful test.
>
> while [ 1 ];do
>         cat /proc/self/cmdline >> TEST
> done
>
> Marc

I might have actually just killed the process I was grepping for (I was 
grepping to see if it had actually gone away yet).  Dunno if that helps...

I haven't been able to reproduce it either.  I think the pipe to grep (or 
something similar) is important because your test isn't doing what mine did: 
one process was looking at another process at the instant of process creation 
(or perhaps exit).  Maybe the appropriate null terminator is written out 
after the process goes live?

This is a UP system, but I have preemption on...

Rob
-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

