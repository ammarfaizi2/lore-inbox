Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTEKRo5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTEKRo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:44:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57166 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261807AbTEKRo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:44:56 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <jamie@shareable.org>, Jos Hulzink <josh@stack.nl>,
       Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
References: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 May 2003 11:54:20 -0600
In-Reply-To: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com>
Message-ID: <m1k7cx74j7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sat, 10 May 2003, Jamie Lokier wrote:
> > Jos Hulzink wrote:
> > > For the sake of bad behaving BIOSes however, I'd vote for the f000:fff0 
> > > vector, unless someone can hand me a paper that says it is wrong.
> > 
> > I agree, for the simple reason that it is what the chip does on a
> > hardware reset signal.
> 
> Hmm.. Doesnt' a _real_ hardware reset actually use a magic segment that
> isn't even really true real mode? I have this memory that the reset value
> for a i386 has CS=0xf000, but the shadow base register actually contains
> 0xffff0000. In other words, the CPU actually starts up in "unreal" mode,
> and will fetch the first instruction from physical address 0xfffffff0.
> 
> At least that was true on an original 386. It's something that could 
> easily have changed since.

Correct.  And no one has changed it since.  I use that all of the time.
 
> In other words, you're all wrong. Nyaah, nyaah.

However 0xf000:fff0 is as close as you can get, and since that is usually
RAM it can do something different on a reset vs a reboot if it wants
to.  

Using 0xf000 is just polite as it allows relative jumps.

Eric
