Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422652AbWJYS5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWJYS5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 14:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161372AbWJYS5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 14:57:14 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36526 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161370AbWJYS5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 14:57:13 -0400
Date: Wed, 25 Oct 2006 11:58:13 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Levon <levon@movementarian.org>, phil.el@wanadoo.fr,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       oprofile-list@lists.sourceforge.net, george@mvista.com
Subject: Re: oprofile can cause an NMI to schedule (was: [RT] scheduling and oprofile)
Message-ID: <20061025185813.GA4114@monkey.ibm.com>
References: <20061023212307.GA21498@monkey.beaverton.ibm.com> <1161656674.13276.17.camel@localhost.localdomain> <20061024124650.GA2668@totally.trollied.org> <Pine.LNX.4.58.0610240852450.949@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0610240852450.949@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 08:54:42AM -0400, Steven Rostedt wrote:
> On Tue, 24 Oct 2006, John Levon wrote:
> 
> > On Mon, Oct 23, 2006 at 10:24:34PM -0400, Steven Rostedt wrote:
> > in_atomic() is supposed to be true in this context, so the test in
> > do_page_fault() catches it.
> 
> Ahh, missed that one.  So this is an issue that _only_ rt needs to fix.
> OK, thanks for pointing that out.

Thanks!  This issue is with an older RT kernel that I am running.  In the
version of the kernel I am running nmi_enter() and nmi_exit() are commented
out as described here:

http://www.ussg.iu.edu/hypermail/linux/kernel/0508.1/1714.html

Newer RT kernels (such as linux-2.6.18-rt5) have reenabled the
add_preempt_count/sub_preempt_count calls in nmi_enter/exit.  If I
understand correctly the reason one could not modify the preempt_count
from NMI code is that it could have been in the process of being
modified by non-NMI code.  But, in recent RT kernels it appears that
preempt_count is still a single word modified by both NMI and
non-NMI code.  What am I missing that now makes this safe?

-- 
Mike
