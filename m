Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSGNKPw>; Sun, 14 Jul 2002 06:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSGNKPw>; Sun, 14 Jul 2002 06:15:52 -0400
Received: from holomorphy.com ([66.224.33.161]:3748 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315720AbSGNKPv>;
	Sun, 14 Jul 2002 06:15:51 -0400
Date: Sun, 14 Jul 2002 03:17:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] BH removal text
Message-ID: <20020714101730.GZ23693@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Matthew Wilcox <willy@debian.org>,
	Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk> <20020714010506.GW23693@holomorphy.com> <20020714102219.A9412@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020714102219.A9412@in.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 05:05:55AM +0100, Matthew Wilcox wrote:
>>> That doesn't mean that we shouldn't worry about the 38 files which use
>>> tq_timer, but they are almost all tty related and are therefore Hard ;-)

On Sat, Jul 13, 2002 at 06:05:06PM -0700, William Lee Irwin III wrote:
>> __global_cli(), timer_bh(), and bh_action() are crippling my machines.
>> Where do I start?

On Sun, Jul 14, 2002 at 10:22:19AM +0530, Dipankar Sarma wrote:
> Even if you replace timemr_bh() with a tasklet, you still need
> to take the global_bh_lock to ensure that timers don't race with
> single-threaded BH processing in drivers. I wrote this patch [included]
> to get rid of timer_bh in Ingo's smptimers, but it acquires
> global_bh_lock as well as net_bh_lock, the latter to ensure
> that some older protocol code that expected serialization of
> NET_BH and timers work correctly (see deliver_to_old_ones()).
> They need to be cleaned up too.

This is great stuff. I'll definitely try it out in an hour or two. I'd
be interested in helping with the cleanup of the things assuming the BH
things still exist but might need a wee bit of hand-holding to get
through it. I'll go around flagging people down who might be able to
help me with it as I go.

I actually suspect tty-related things are a likely culprit as
significant use of the serial console occurs.


On Sun, Jul 14, 2002 at 10:22:19AM +0530, Dipankar Sarma wrote:
> My patch of course was experimental to see what is needed to
> get rid of timer_bh. It needs some cleanup itself ;-)


I can at least try it out. The BH stuff is legacy, so killing it
entirely at some point makes sense. I did volunteer to help with
this at OLS, so I'll be delivering code at some point.


Cheers,
Bill
