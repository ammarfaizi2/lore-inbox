Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTFJTAf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFJTAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:00:07 -0400
Received: from holomorphy.com ([66.224.33.161]:20185 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261757AbTFJS60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:58:26 -0400
Date: Tue, 10 Jun 2003 12:11:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm6
Message-ID: <20030610191147.GC26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mike Galbraith <efault@gmx.de>,
	Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <5.2.0.9.2.20030610125606.00cd04a0@pop.gmx.net> <Pine.LNX.4.51.0306101052160.14891@dns.toxicfilms.tv> <46580000.1055180345@flay> <Pine.LNX.4.51.0306092017390.25458@dns.toxicfilms.tv> <51250000.1055184690@flay> <Pine.LNX.4.51.0306092140450.32624@dns.toxicfilms.tv> <20030609200411.GA26348@holomorphy.com> <Pine.LNX.4.51.0306101052160.14891@dns.toxicfilms.tv> <5.2.0.9.2.20030610125606.00cd04a0@pop.gmx.net> <5.2.0.9.2.20030610193426.00cd9528@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.0.9.2.20030610193426.00cd9528@pop.gmx.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:41 AM 6/10/2003 -0700, William Lee Irwin III wrote:
>> \vomit{Next you'll be telling me worse is better.}

On Tue, Jun 10, 2003 at 08:53:51PM +0200, Mike Galbraith wrote:
> That's an unearned criticism.
> Timeslice management is currently an approximation.  IFF the approximation 
> is good enough, it will/must out perform pedantic bean-counting.  Current 
> timeslice management apparently isn't quite good enough, so I'm trying to 
> find a way to increase it's informational content without the (in general 
> case useless) overhead of attempted perfection.  I'm failing miserably btw 
> ;-)

The criticism was of the maxim invoked, not the specific direction
you're hacking in.


At 04:41 AM 6/10/2003 -0700, William Lee Irwin III wrote:
>> The issue is the driver returning garbage; not having as good of
>> precision from hardware is no fault of the method. I'd say timer_pit
>> should just return jiffies converted to nanoseconds.

On Tue, Jun 10, 2003 at 08:53:51PM +0200, Mike Galbraith wrote:
> That's the option that I figured was April 1 material, because of the 
> missing precision.  If it could be made (somehow that I don't understand) 
> to produce a reasonable approximation of a high resolution clock, sure.

If there's a TSC, it can be used for extra interpolation. But I think
timer_tsc already does that. I don't think it's quite so laughable; the
machines missing reliable time sources are truly crippled in some way,
by obsolescence or misdesign. I wouldn't call this a deficit. The
major platforms will do fine, and the rest will do no worse than now
apart from perhaps some function call and arithmetic overhead.


At 04:41 AM 6/10/2003 -0700, William Lee Irwin III wrote:
>> Also, I posted the "thud" fix earlier in this thread in addition to the
>> monotonic_clock() bits. AFAICT it mitigates (or perhaps even fixes) an
>> infinite priority escalation scenario.

On Tue, Jun 10, 2003 at 08:53:51PM +0200, Mike Galbraith wrote:
> (yes, mitigates... maybe cures with round down, not really sure)
> Couple that change with reintroduction of backboost to offset some of it's 
> other effects and a serious reduction of CHILD_PENALTY and you'll have a 
> very snappy desktop.  However, there is another side of the 
> equation.  Large instantaneous variance in sleep_avg/prio also enables the 
> scheduler to react quickly such that tasks which were delayed for whatever 
> reason rapidly get a chance collect their ticks and catch up.  It can and 
> does cause perceived unfairness... which is in reality quite fair.  It's 
> horrible for short period concurrency, but great for long period 
> throughput.  AFAIKT, it's a hard problem.

I don't know that there are answers better than mitigation.

I propose we err on the other side of the fence and back off as cases
where the larger instantaneous variances are more clearly needed arise.


-- wli
