Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265016AbTGGPMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266661AbTGGPMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:12:25 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:4044 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S265016AbTGGPMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:12:24 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Davide Libenzi <davidel@xmailserver.org>, Mel Gorman <mel@csn.ul.ie>
Subject: Re: 2.5.74-mm1
Date: Mon, 7 Jul 2003 17:28:08 +0200
User-Agent: KMail/1.5.2
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
References: <20030703023714.55d13934.akpm@osdl.org> <Pine.LNX.4.53.0307071408440.5007@skynet> <Pine.LNX.4.55.0307070745250.4428@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0307070745250.4428@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307071728.08753.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 July 2003 16:47, Davide Libenzi wrote:
> On Mon, 7 Jul 2003, Mel Gorman wrote:
> > On Mon, 7 Jul 2003, Daniel Phillips wrote:
> > > And set up distros to grant it by default.  Yes.
> > >
> > > The problem I see is that it lets user space priorities invade the
> > > range of priorities used by root processes.
> >
> > That is the main drawback all right but it could be addressed by having a
> > CAP_SYS_USERNICE capability which allows a user to renice only their own
> > processes to a highest priority of -5, or some other reasonable value
> > that wouldn't interfere with root processes. This capability would only
> > be for applications like music players which need to give hints to the
> > scheduler.
>
> The scheduler has to work w/out external input, period. If it doesn't we
> have to fix it and not to force the user to submit external hints.

That's not correct in this case, because the sound servicing routine is 
realtime, which makes it special.  Furthermore, Zinf is already trying to 
provide the kernel with the hint it needs via PThreads SetPriority but 
because Linux has brain damage - both in the kernel and user space imho - the 
hint isn't accomplishing what it's supposed to.

As I said earlier: trying to detect automagically which threads are realtime 
and which aren't is stupid.  Such policy decisions don't belong in the 
kernel.

Regards,

Daniel

