Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268230AbTCFRmf>; Thu, 6 Mar 2003 12:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268231AbTCFRmf>; Thu, 6 Mar 2003 12:42:35 -0500
Received: from highland.isltd.insignia.com ([195.74.141.1]:54020 "EHLO
	highland.isltd.insignia.com") by vger.kernel.org with ESMTP
	id <S268230AbTCFRme>; Thu, 6 Mar 2003 12:42:34 -0500
To: mingo@elte.hu (Ingo Molnar)
Cc: Linus Torvalds <torvalds@transmeta.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
From: jvlists@ntlworld.com
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Date: Thu, 06 Mar 2003 17:52:54 +0000
In-Reply-To: <Pine.LNX.4.44.0303061801250.13726-100000@localhost.localdomain> (mingo@elte.hu's
 message of "Thu, 6 Mar 2003 17:15:09 -0000")
Message-ID: <g3of4owfex.fsf@bart.isltd.insignia.com>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) XEmacs/21.4 (Military
 Intelligence (RC1), i686-pc-linux)
References: <Pine.LNX.4.44.0303060842270.7206-100000@home.transmeta.com>
	<Pine.LNX.4.44.0303061801250.13726-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mingo@elte.hu (Ingo Molnar) writes:

> X is special. Especially in Andrew's wild-window-dragging experiment X is
> a pure CPU-bound task that just eats CPU cycles no end. There _only_ thing
> that makes it special is that there's a human looking at the output of the
> X client. This is information that is simply not available to the kernel.

Isn't it special because the window manager and other interactive
tasks are blocked waiting for it? Presumably during a wild-window drag
there will be loads of block-wakeup sequences between X and the window
manager. IF every such event gave a little boost to the X server that
would mean the X server would get loads of interactivity brownie
points.

This may be a stupid idea (feel free to ignore, it may even be what
the kernel already does), but if you had a separate input server and
display server instead of one X server you could follow the trail all
the way from the real user.

/dev/input/mice is special because we know it interfaces to the user.
The X input server gains points for waiting on  /dev/input/mice
interactive X program gains points for waiting on  X input server
X output server is special because it blocks waiting on the
interactive X program (and vice versa!)

The hard part would be detecting interactivity for stuff waiting on ip
sockets.

If this information was available to user programs then the X display
server could even prioritize rendering a new character in bash over
displaying the fishbowl animation running in the background.

Jan

P.S. IMVHO the xine problem is completely different as has nothing to
with interactivity but with the fact that it is soft
real-time. i.e. you need to distingish xine from say a gimp filter or
a 3D renderer with incremental live updates of the scene it is
creating.
