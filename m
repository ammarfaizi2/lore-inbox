Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbUKVXvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbUKVXvC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUKVXsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:48:32 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:38894 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262437AbUKVXqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:46:15 -0500
Date: Mon, 22 Nov 2004 16:48:06 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Davide Libenzi <davidel@xmailserver.org>,
       Roland McGrath <roland@redhat.com>, Andreas Schwab <schwab@suse.de>,
       Daniel Jacobowitz <dan@debian.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
Message-ID: <20041122234806.GA6833@tesore.ph.cox.net>
Mail-Followup-To: Jesse Allen <the3dfxdude@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	Roland McGrath <roland@redhat.com>, Andreas Schwab <schwab@suse.de>,
	Daniel Jacobowitz <dan@debian.org>,
	Eric Pouech <pouech-eric@wanadoo.fr>,
	Mike Hearn <mh@codeweavers.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
References: <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net> <Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org> <je7joe91wz.fsf@sykes.suse.de> <Pine.LNX.4.58.0411211703160.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411211947200.11274@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0411212022510.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411212212530.20993@ppc970.osdl.org> <20041122231521.GA5966@tesore.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122231521.GA5966@tesore.ph.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 04:15:21PM -0700, Jesse Allen wrote:
> 
> For the wine app in question, it does make a difference.  However, there is 
> a new problem.  The program gets stuck at the loading screen at 100% CPU.
> It's making a call to select, timing out, and then tries select again, 
> repeats.  It's waiting for something that seems to never happen.
> 
> I've captured a log, "loop.log.bz2", and shortened to have only the relevent
> information after the CMS32_MUTEX is created.  Look for occurances of
>  "select()" -- I think the second one is where it starts.  It's on my ftp if 
> anyone wants to take a look.  It probably can be compared to the working-
> version log where this doesn't occur, but it might be a pain to spot the 
> working particular instance.
> 
> 


Actually it's pretty obvious.  In the working version, it's supposed to be
getting SIGTRAPs while it's calling select().  So something's up there.  But
it's doing part of what it should be doing now.


