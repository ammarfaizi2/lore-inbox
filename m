Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVATTcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVATTcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVATTcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:32:03 -0500
Received: from mail.joq.us ([67.65.12.105]:19847 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261785AbVATTbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:31:43 -0500
To: "Rui Nuno Capela" <rncbc@rncbc.org>
Cc: "Con Kolivas" <kernel@kolivas.org>, "linux" <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, "CK Kernel" <ck@vds.kolivas.org>,
       "utz" <utz@s2y4n2c.de>, "Andrew Morton" <akpm@osdl.org>,
       alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt    
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>
	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>
	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>
	<87oefkd7ew.fsf@sulphur.joq.us>
	<10752.195.245.190.93.1106211979.squirrel@195.245.190.93>
	<65352.195.245.190.94.1106240981.squirrel@195.245.190.94>
From: "Jack O'Quin" <joq@io.com>
Date: Thu, 20 Jan 2005 13:32:20 -0600
In-Reply-To: <65352.195.245.190.94.1106240981.squirrel@195.245.190.94> (Rui
 Nuno Capela's message of "Thu, 20 Jan 2005 17:09:41 -0000 (WET)")
Message-ID: <874qhb99rv.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rui Nuno Capela" <rncbc@rncbc.org> writes:

> OK. Here goes my fresh and newly jack_test4.1 test suite. It might be
> still rough, as usual ;)

Thanks for all your work on this fine test suite.

> This phenomenon, so to speak, shows up as a sudden full increase of
> DSP/CPU load after a few minutes running jackd while perfectly normal and
> stable until that moment. Once that occurs, and it does now everytime I
> run jack_test4_run.sh with default parameters (14 clients, 4x4 ports), you
> end under a horrible XRUN storm--see attached chart--you can even hear it
> perfectly as the 1KHz audible tone burps and stutters, resembling
> radioactivity morse pulses.

Looking at the graph, it appears that your DSP load is hovering just
above 70% most of the time.  This happens to be the default threshold
for revoking realtime privileges.  Perhaps that is the problem.  Try
running it with the threshold set to 90%.  (I don't recall exactly
how, but I think there's a /proc/sys/kernel control somewhere.)

> So it seems that this showstopper is an issue only under extreme loads,
> and is probably relative to the hardware you're running into. On my other
> P4@3.3Ghz/HT desktop I could not reproduce this. Instead, I hit a rather
> older issue, which comes like the magic 14 client limit. As it seems, I
> now find trouble when starting more than 14 connected clients, as the
> jack_watchdog kills everything in sight beyhond that point. This wasn't
> happening with the jack_test3.2 suite, suspectedly because those clients
> weren't being connected to each other.

I'll take a look.  The old problem with more than 14 clients has been
fixed.  I routinely run 30 or 40 without trouble.  

Perhaps we're running out of some port resource?

> Please check this out, and would you try at least to reproduce the naughty
> behavior such as the pictured on the attached chart?

Will do.
-- 
  joq
