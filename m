Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVDOS0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVDOS0g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVDOSYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:24:14 -0400
Received: from thunk.org ([69.25.196.29]:49875 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261908AbVDOSXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:23:39 -0400
Date: Fri, 15 Apr 2005 14:23:23 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux@horizon.com
Cc: jlcooke@certainkey.com, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Fortuna
Message-ID: <20050415182323.GA10480@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, linux@horizon.com,
	jlcooke@certainkey.com, linux-kernel@vger.kernel.org,
	mpm@selenic.com
References: <20050415144216.GA9352@thunk.org> <20050415153801.12619.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415153801.12619.qmail@science.horizon.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 03:38:01PM -0000, linux@horizon.com wrote:
> 
> First of all, people *on* the netowrk path can just *see* the packets.
> Or modify them.  Or whatever.
> The point is to prevent hijacking by people *not* on the path.

Yes, you're correct of course.  Of course, I'll note that people who
*not* on the path have to not only guess the ISN, but they also have
to somehow know that there is a TCP connection between hosts A and B,
and what ports they are using.  Someone not on the path isn't
necessarily going to know this, unless there are publically accessible
SNMP-enabled routers that are overly free with this sort of
information.  (Loose lips sink ships!)

> Further, if I capture ISNs from A and B in the same rekey interval as
> the initiation of the connection I'm trying to hijack, and that
> connection proceeds slowly, then I have the lifetime of the connection
> to solve the crypto problem.

True, although the longer it takes to break the crypto, the greater
the uncertainty of how much data has gone across the connection, which
makes the problem harder in other ways.

> > Furthermore, if you really cared about preventing TCP hijacks, the
> > only real way to do this is to use Real Crypto.  And these days, Cisco
> > boxes support Kerberized telnets and ssh connections, which is the
> > real Right Answer.
> 
> It's just so high-level.  While ipsec is the most general solution,
> setting it up is a PITA.  I've often thought about trying to add a TCP
> option for stream encryption what could provide opportunistic encryption
> for everyone.

But ssh is pretty easy, and even if you completely ignore the host key
issue (to protect you against man-in-the-middle attacks), a simple
diffie-helman type approach is plenty to protect you against the class
of attacks which the randomized ISN buys you.  

						- Ted
