Return-Path: <linux-kernel-owner+w=401wt.eu-S1754916AbXACHld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916AbXACHld (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754896AbXACHld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:41:33 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:55605
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbXACHlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:41:32 -0500
Date: Tue, 2 Jan 2007 23:41:24 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: "Chen, Tim C" <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Message-ID: <20070103074124.GA25594@gnuppy.monkey.org>
References: <9D2C22909C6E774EBFB8B5583AE5291C019998CA@fmsmsx414.amr.corp.intel.com> <20061229232618.GA11239@gnuppy.monkey.org> <20061230111940.GA8412@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061230111940.GA8412@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2006 at 12:19:40PM +0100, Ingo Molnar wrote:
> your patch looks pretty ok to me in principle. A couple of suggestions 
> to make it more mergable:
> 
>  - instead of BUG_ON()s please use DEBUG_LOCKS_WARN_ON() and make sure 
>    the code is never entered again if one assertion has been triggered.
>    Pass down a return result of '0' to signal failure. See
>    kernel/lockdep.c about how to do this. One thing we dont need are
>    bugs in instrumentation bringing down a machine.

I'm using a non-fatal error checking instead of BUG_ON. BUG_ON was a more
aggressive way that I use to find problem initiallly.

>  - remove dead (#if 0) code

Done.

>  - Documentation/CodingStyle compliance - the code is not ugly per se
>    but still looks a bit 'alien' - please try to make it look Linuxish,
>    if i apply this we'll probably stick with it forever. This is the
>    major reason i havent applied it yet.

I reformatted most of the patch to be 80 column limited. I simplified a
number of names, but I'm open to suggestions and patches to how to go
about this. Much of this code was a style experiment, but now I have to
make this more mergable.

>  - the xfs/wrap_lock change looks bogus - the lock is initialized
>    already. What am i missing?

Correct. This has been removed.

I've applied Daniel Walker's changes as well.

Patch here:

	http://mmlinux.sourceforge.net/public/patch-2.6.20-rc2-rt2.2.lock_stat.patch

bill

