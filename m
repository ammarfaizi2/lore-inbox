Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVHIVhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVHIVhE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVHIVhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:37:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18052 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932286AbVHIVhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:37:03 -0400
From: Aaron Young <ayoung@google.engr.sgi.com>
Message-Id: <200508092136.OAA13698@google.engr.sgi.com>
Subject: Re: Standardize shutdown of the system from enviroment control
To: ghoward@sgi.com (Greg Howard)
Date: Tue, 9 Aug 2005 14:36:53 -0700 (PDT)
Cc: hch@lst.de (Christoph Hellwig), davem@davemloft.net,
       linux-kernel@vger.kernel.org (LKML), ayoung@sgi.com (Aaron Young)
In-Reply-To: <Pine.SGI.4.58.0508091619180.19699@gallifrey.americas.sgi.com> from "Greg Howard" at Aug 09, 2005 04:25:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> On Tue, 9 Aug 2005, Christoph Hellwig wrote:
> 
> > Currently snsc_event for Altix systems sends SIGPWR to init (and abuses
> > tasklist_lock..) while the sbus drivers call execve for /sbin/shutdown
> > (which is also ugly, it should at least use call_usermodehelper)
> > With normal sysvinit both will end up the same, but I suspect the
> > shutdown variant, maybe with a sysctl to chose the exact path to call
> > would be cleaner.  What do you guys think about adding a common function
> > to do this.
> 
> Sounds reasonable to me.  I'll copy Aaron Young, who I think
> actually wrote the code to send the SIGPWR, in case he had a Good
> Reason for doing it this way.  (Aaron, if I'm remembering wrong
> and you're not the guy who wrote this, let me know...)

  Yep, that was me. I couldn't really find a better way to do it at
  the time. An 'execve shutdown' probably would have been better in retrospect
  because I think sending SIGPWR to init doesn't always shutdown the machine.
  It depends on how some config files are setup (inittab, powerfail).
  I'd rather not depend on any config files and just force a shutdown/poweroff.

> 
> > Could you test such a patch for me?
> 
> Sure.  I'll need to get hold of some hardware/firmware that will
> reproduce a critical environmental situation...  Might take a
> litte while...

 Testing should be easy - on a Deskside Prism system, just hit the
 power button while up at Linux.
