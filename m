Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270452AbTHSO5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270628AbTHSO5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:57:34 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:8602 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S270479AbTHSO4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:56:03 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Con Kolivas <kernel@kolivas.org>, Wes Janzen <superchkn@sbcglobal.net>
Subject: Re: [RFC] Re: Blender profiling-1 O16.2int
Date: Tue, 19 Aug 2003 04:39:59 -0400
User-Agent: KMail/1.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030817003128.04855aed.voluspa@comhem.se> <3F416BD4.3040302@sbcglobal.net> <200308191028.11109.kernel@kolivas.org>
In-Reply-To: <200308191028.11109.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308190439.59273.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 August 2003 20:28, Con Kolivas wrote:
> On Tue, 19 Aug 2003 10:14, Wes Janzen wrote:
> > I think this problem is exacerbated when another app is competing for
> > the processor.  The machine just pauses unless I'm also doing something
> > else, in this case compiling XINE.  Once something is competing, it
> > looks like X takes an extraordinarily long time to come back into the
> > running queue.
>
> Yes that is correct behaviour and to be expected.
>
> > Is there a way to figure out when a process is spinning on a wait and
>
> That's the trick isn't it? No there isn't or else I'd fix it in a jiffy. If
> someone can think of a way I'd love to know.

Well, in theory you could fiddle with its memory map and force it to 
soft-fault all its pages back in, and count the soft faults.  But I know just 
enough about that to suspect it's a rast nest of evil complexity and loss of 
orthogonality.

Another thing is if it's calling the same syscalls in sequence with the same 
arguments...  (What syscalls IS it calling?)

Looking at the profile list you gave earlier, schedule is showing up.  If the 
sucker's calling schedule in the loop, that should be a heck of a hint that 
it's busy-waiting, dontcha think?

As long as you've got a queue for each priority, how about having an "I called 
schedule" queue?  (Or can you re-queue it somewhere lower than its actual 
priority?  How about one queue lower than the queue was on when it called 
schedule, without necessarily changing its dynamic priority...)

What DOES calling "schedule" from userspace mean with the current scheduler?

Rob


