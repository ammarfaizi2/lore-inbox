Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318062AbSHHUn1>; Thu, 8 Aug 2002 16:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318064AbSHHUn1>; Thu, 8 Aug 2002 16:43:27 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:13307 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S318062AbSHHUn0>;
	Thu, 8 Aug 2002 16:43:26 -0400
Date: Thu, 8 Aug 2002 22:47:03 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@zip.com.au>, Paul Larson <plars@austin.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, davej@suse.de, frankeh@us.ibm.com,
       andrea@suse.de
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020808204703.GA700@win.tue.nl>
References: <1028757835.22405.300.camel@plars.austin.ibm.com> <3D51A7DD.A4F7C5E4@zip.com.au> <20020808002419.GA528@win.tue.nl> <20020808194238.GG15685@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020808194238.GG15685@holomorphy.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 12:42:38PM -0700, William Lee Irwin III wrote:

> The goal of the work that produced this was to remove the global
> tasklist. Changing ABI's and/or breaking userspace was not "within the
> rules" of that.

It feels wrong to add such complexity and simultaneously keep
such a small pid_t.

Very soon 30000 processes will not be enough.

Using a 32-bit pid_t does not break userspace. Indeed, user space uses
a 32-bit pid_t today. The only complaint I have heard was from
Albert Cahalan who maintains ps and was afraid that the ps output
would become uglier if pids would get more digits.

It is a real pity that going to a 64-bit pid is impossible (on x64).

Many algorithms can be really efficient if you have a large space
to work in. For example, I do not know what your motivation was
for wanting to remove the global tasklist. It is certainly needed
for sending signals. But if you want to avoid access to global stuff
in a MP situation, then it is easy to partition the pid space
so that each processor only gives out pids in its own region.
(So that simultaneous forks do not interfere.)

Andries
