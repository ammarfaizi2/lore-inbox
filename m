Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVBBWLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVBBWLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVBBVbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:31:55 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38606 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262569AbVBBVVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:21:22 -0500
Date: Wed, 2 Feb 2005 22:21:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050202212100.GA12808@elte.hu>
References: <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us> <20050202111045.GA12155@nietzsche.lynx.com> <87is5ahpy1.fsf@sulphur.joq.us> <20050202211405.GA13941@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202211405.GA13941@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <bhuey@lnxw.com> wrote:

> On Wed, Feb 02, 2005 at 10:44:22AM -0600, Jack O'Quin wrote:

> > I believe Ingo's RT patches already support this on a per-IRQ basis.
> > Each IRQ handler can run in a realtime thread with priority assigned
> > by the sysadmin.  Balancing the interrupt handler priorities with
> > those of other realtime activities allows excellent control.  
> 
> No they don't. That's a physical mapping of these kernel entities, not a
> logic organization that projects upward to things like individual sockets
> or file streams. [...]

yes and no. You are right in that the individual workloads (e.g.
softirqs) are not separated and identified/credited to the thread that
requested them. (in part due to the fact that you cannot e.g. credit a
thread for e.g. unrequested workloads like incoming sockets, or for
'merged' workloads like writeout of a commonly accessed file.)

but Jack is right in practical terms: the audio folks achieved pretty
good results with the current IRQ threading mechanism, partly due to the
fact that the audio stack doesnt use softirqs, so all the
latency-critical activities are in the audio IRQ thread and the
application itself.

	Ingo
