Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTI1KFz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 06:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTI1KFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 06:05:55 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:8576 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S261681AbTI1KFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 06:05:53 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Con Kolivas <kernel@kolivas.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
Date: Sun, 28 Sep 2003 05:02:36 -0500
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <200309281703.53067.kernel@kolivas.org>
In-Reply-To: <200309281703.53067.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309280502.36177.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 September 2003 02:03, Con Kolivas wrote:
> On Sun, 28 Sep 2003 11:27, Linus Torvalds wrote:
> > from Andrew Morton. Most notably perhaps Con's scheduler changes that
> > have been discussed extensively and made it into the -mm tree for
> > testing.
>
> For those who are trying this for the first time, please note that the
> scheduler has been tuned to tell the difference between tasks of the _same_
> nice level. This means do NOT renice X or it will make audio skip unless
> you also renice your audio application by the same amount. Lots of
> distributions have done this for the old 2.4 scheduler which could not
> treat equal "nice" levels as differently as the new scheduler does and 2.6
> shouldn't need special treatment.
>
> So for testing note the following points:
>
> Make sure X is NOT reniced to -10 as many distributions are doing.
> Some shells spawn processes at nice +5 by default and this will make audio
> apps suffer.
> Make sure your hard disk, graphics card and audio card are performing at
> equal standard to your 2.4 kernel (ie dma is working, graphics is fully
> accelerated etc).

I.E. with your new scheduler, priority levels actually have enough of an 
effect now that things that aren't reniced can be noticeably starved by 
things that are.

This is, in point of fact, progress.  If you nice X to -10, X will hog the CPU 
to update the display, potentially starving your audio output process enough 
to cause skips.  This is not a bug, this is what you asked the system to do.  
Don't Do That Then.

Rob

(Renicing X can even make the display jittery if the application can't 
promptly get CPU time to respond to redraw requests or mouse movement events 
because X is busy doing things like issuing more redraw requests and mouse 
movement events... :)
