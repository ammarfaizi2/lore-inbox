Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313311AbSC2AXU>; Thu, 28 Mar 2002 19:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313313AbSC2AXK>; Thu, 28 Mar 2002 19:23:10 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:32243
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313311AbSC2AWz>; Thu, 28 Mar 2002 19:22:55 -0500
Date: Thu, 28 Mar 2002 16:24:34 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Patch; setpriority
Message-ID: <20020329002434.GE8627@matchmail.com>
Mail-Followup-To: David Wagner <daw@mozart.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CA232A1.7040702@cisco.com> <a7td19$em8$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 09:19:37PM +0000, David Wagner wrote:
> What's the argument why this change to the semantics of setpriority()
> is a reasonable one to make?
> 
> Previously, non-root users [*] could not decrement their current priority
> value (i.e., make their own processes run faster).  Now you're allowing
> processes to decrement the current priority, so long as they stay within
> the range 0..19.  But what if the priority had been increased by the

> Am I overlooking something?

Yes.  (I didn't look at the patch itself) but, it should allow you to change
the *nice* value of the process.  It doesn't allow you to change the actual
priority of the process/thread.  The scheduler itself takes into account the
nice value and interactiveness (ingo's new scheduler at least...).

One thing to thing about though, is that maybe the administrator set the
user to nice value 5 and this would allow the user to get back down the the
default of 0.

One thing you could do in that case would be to set the *other* processes to
a higher priority...
