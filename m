Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266921AbRGOULA>; Sun, 15 Jul 2001 16:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266911AbRGOUKu>; Sun, 15 Jul 2001 16:10:50 -0400
Received: from ns.suse.de ([213.95.15.193]:31495 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S266921AbRGOUKh>;
	Sun, 15 Jul 2001 16:10:37 -0400
Date: Sun, 15 Jul 2001 22:10:38 +0200
From: Andi Kleen <ak@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Mike Kravetz <mkravetz@sequent.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@suse.de>, lse-tech@lists.sourceforge.net,
        Larry McVoy <lm@bitmover.com>,
        David Lang <david.lang@digitalinsight.com>
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency
Message-ID: <20010715221038.A14480@gruyere.muc.suse.de>
In-Reply-To: <20010713154305.G1137@w-mikek2.des.beaverton.ibm.com> <XFMail.20010715130221.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010715130221.davidel@xmailserver.org>; from davidel@xmailserver.org on Sun, Jul 15, 2001 at 01:02:21PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 01:02:21PM -0700, Davide Libenzi wrote:
> The problem of the current scheduler is that it acts like an infinite feedback
> system.
> When we're going to decide if we've to move a task we analyze the status at the
> current time without taking in account the system status at previous time
> values.
> But the feedback we send ( IPI to move the task ) take a finite time to hit the
> target CPU and, meanwhile, the system status changes.
> So we're going to apply a feedback calculated in time T0 to a time Tn, and this
> will result in system auto-oscillation that we perceive as tasks bouncing
> between CPUs.
> This is kind of electronic example but it applies to all feedback systems.
> The solution to this problem, given that we can't have a zero feedback delivery
> time, is :
> 
> 1) lower the feedback amount, that means, try to minimize task movements
> 
> 2) a low pass filter, that means, when we're going to decide the sort ( move )
>         of a task, we've to weight the system status with the one that it had
>         at previous time values

Nice analysis. I think Mike's proposal of the 'saved_cpus_allowed' field
to temporarily bind the task to the target would just act as such an low 
pass filter.

-Andi
