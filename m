Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbTGDCRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbTGDCPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:15:34 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:4554 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265677AbTGDCOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:14:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Tom Sightler <ttsig@tuxyturvy.com>
Subject: Re: 2.5.74-mm1 and Con Kolivas' CPU scheduler work
Date: Fri, 4 Jul 2003 12:29:06 +1000
User-Agent: KMail/1.5.2
Cc: "ismail (cartman) donmez" <kde@myrealbox.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <200307031936.34458.kde@myrealbox.com> <200307040949.18588.kernel@kolivas.org> <1057284551.1725.8.camel@iso-8590-lx.zeusinc.com>
In-Reply-To: <1057284551.1725.8.camel@iso-8590-lx.zeusinc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307041229.06238.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003 12:09, Tom Sightler wrote:
> On Thu, 2003-07-03 at 19:49, Con Kolivas wrote:
> > On Fri, 4 Jul 2003 02:36, ismail (cartman) donmez wrote:
> > > Hi,
> > >
> > > With Con Kolivas' cpu patch I got many slow downs. When I try to run
> > > CodeWeaver's CrossOver office box gets unresponsive at least for a one
> > > minute. While starting KDE ( when splash screen is running ) mouse gets
> > > too sluggish.
> >
> > While your wm starting if your mouse is sluggish it is probably not a big
> > problem, and it is part of something I'm already working on. The
> > codeweavers problem is impressive though; I don't have codeweavers and
> > have not seen anything like it. To get a full picture it would be helpful
> > if you could run top as root say reniced to -13 just so it doesn't miss
> > anything, and then start codeweavers, watch top and tell me what is
> > spinning away hogging the cpu.
>
> My guess is that he's seeing the same issue that I reported a few weeks
> ago with Crossover plugin.  That report generated a fairly long thread
> and a lot of patches and testing, but little actual progress.  Basically
> wine seems to have multiple threads and a client/server architecture and
> seems constantly spin on a pipe passing info back and forth to each
> other.  It seems one thread gets all the attention and starves the
> others although the others are critical for the main process to actually
> make progress.
>
> I've been wanting to do some testing with your patches so I'll give them
> a spin tonight and see how this acts.

Ah yes I believe I know this issue. The problem is the parent spinning madly 
waiting for the child and it is the parent that starves the child. While this 
is not a fix, if you can reproduce the problem can you try changing 
CHILD_PENALTY in kernel/sched.c from 50 to 100 and see if that makes the 
problem go away? I mentioned this hidden in a thread a while ago, and am 
trying to get a reasonable fix.

Con

