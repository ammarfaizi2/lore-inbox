Return-Path: <linux-kernel-owner+w=401wt.eu-S1422737AbWLUGBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbWLUGBI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422739AbWLUGBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:01:07 -0500
Received: from [213.184.169.205] ([213.184.169.205]:32867 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422737AbWLUGBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:01:06 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] procfs: export context switch counts in /proc/*/stat
Date: Thu, 21 Dec 2006 09:02:27 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612210902.27256.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> On 12/20/06, David Wragg <david@wragg.org> wrote:
> > "Albert Cahalan" <acahalan@gmail.com> writes:
> > > On Mon, Dec 18, 2006 at 11:50:08PM +0000, David Wragg wrote:
> > >> This patch (against 2.6.19/2.6.19.1) adds the four context
> > >> switch values (voluntary context switches, involuntary
> > >> context switches, and the same values accumulated from
> > >> terminated child processes) to the end of /proc/*/stat,
> > >> similarly to min_flt, maj_flt and the time used values.
> > >
> > > Hmmm, OK, do people have a use for these values?
> >
> > My reason for writing the patch was to track which processes are
> > active (i.e. got scheduled to run) by polling these context switch
> > values.  The time used values are not a reliable way to detect process
> > activity on fast machines.  So for example, when sorting by %CPU, top
> > often shows many processes using 0% CPU, despite the fact that these
> > processes are running occasionally.  If top sorted by (%CPU, context
> > switch count delta), it might give a more useful display of which
> > processes are active on the system.
>
> Oh, that'd be great.

It may be great, but it's really only a workaround.  The real fix is in 
changing the current probed proc-timing to an inlined one.

> The cumulative ones are still not justified though, and I fear they
> may be 64-bit even on i386. It turns out that an i386 procps spends
> much of its time doing 64-bit division to parse the damn ASCII crap.
> I suppose I could just skip those fields, but generating them isn't
> too cheap and probably I'd get stuck parsing them for some other
> reason -- having them separate is probably a good idea.

Agreed.  It may also be advisable to add a top3 line in /proc/stat, to 
circumvent parsing /proc/*/stat, when only checking who is eating CPU most. 


Thanks!

--
Al

