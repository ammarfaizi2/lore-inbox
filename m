Return-Path: <linux-kernel-owner+w=401wt.eu-S1030215AbWLTRg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWLTRg0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 12:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWLTRg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 12:36:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:60539 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030215AbWLTRgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 12:36:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AgtfKR40hAtkszgS5ifZfignpSBkBtIWtq40IixYLhr9Q+fDGwEW9l5eM81Jnakvx5LnhveS++MnO2JHUaPDbtSD7zQ/ouw8dpRG4fx/WALd+Wj/e4dY7i8Gnkp71ibCWAQ51cLbY9LfjkfANqK9VT0wIwXhSd9UqxdqDyjab4k=
Message-ID: <787b0d920612200936w186a783aj81d10384c54dfc7e@mail.gmail.com>
Date: Wed, 20 Dec 2006 12:36:23 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "David Wragg" <david@wragg.org>
Subject: Re: [PATCH] procfs: export context switch counts in /proc/*/stat
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <878xh2aelz.fsf@wragg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920612192140o37a28e8fnccdd51670cb9a766@mail.gmail.com>
	 <878xh2aelz.fsf@wragg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, David Wragg <david@wragg.org> wrote:
> "Albert Cahalan" <acahalan@gmail.com> writes:
> > On Mon, Dec 18, 2006 at 11:50:08PM +0000, David Wragg wrote:
> >> This patch (against 2.6.19/2.6.19.1) adds the four context
> >> switch values (voluntary context switches, involuntary
> >> context switches, and the same values accumulated from
> >> terminated child processes) to the end of /proc/*/stat,
> >> similarly to min_flt, maj_flt and the time used values.
> >
> > Hmmm, OK, do people have a use for these values?
>
> My reason for writing the patch was to track which processes are
> active (i.e. got scheduled to run) by polling these context switch
> values.  The time used values are not a reliable way to detect process
> activity on fast machines.  So for example, when sorting by %CPU, top
> often shows many processes using 0% CPU, despite the fact that these
> processes are running occasionally.  If top sorted by (%CPU, context
> switch count delta), it might give a more useful display of which
> processes are active on the system.

Oh, that'd be great.

The cumulative ones are still not justified though, and I fear they
may be 64-bit even on i386. It turns out that an i386 procps spends
much of its time doing 64-bit division to parse the damn ASCII crap.
I suppose I could just skip those fields, but generating them isn't
too cheap and probably I'd get stuck parsing them for some other
reason -- having them separate is probably a good idea.
