Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWIQRPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWIQRPP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWIQRPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:15:14 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:3535 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S965033AbWIQRPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:15:12 -0400
Date: Sun, 17 Sep 2006 13:15:10 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Roman Zippel <zippel@linux-m68k.org>,
       Thomas Gleixner <tglx@linutronix.de>, karim@opersys.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060917171509.GA31658@Krystal>
References: <Pine.LNX.4.64.0609152314250.6761@scrub.home> <20060915215112.GB12789@elte.hu> <Pine.LNX.4.64.0609160018110.6761@scrub.home> <20060915231419.GA24731@elte.hu> <Pine.LNX.4.64.0609160139130.6761@scrub.home> <20060916082214.GD6317@elte.hu> <Pine.LNX.4.64.0609161831270.6761@scrub.home> <20060916231407.GA23132@elte.hu> <y0mr6yaefts.fsf@ton.toronto.redhat.com> <20060917153156.GA26209@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060917153156.GA26209@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:00:53 up 25 days, 14:09,  3 users,  load average: 0.53, 0.37, 0.23
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Frank Ch. Eigler <fche@redhat.com> wrote:
> 
> > As for Karim's proposed comment-based markers, I don't have a strong 
> > opinion, not being one whose kernel-side code would be marked up one 
> > way or the other. [...]
> 
> What makes the difference isnt just the format of markup (although i 
> fully agree that the least visually intrusive markup format should be 
> used for static markers, and the range of possibilities includes 
> comment-based markers too), but what makes the differen is:
> 
>  the /guarantee/ of a full (comprehensive) set to /static tracers/
> 
> The moment we allow a static tracer into the upstream kernel, we make 
> that guarantee, implicitly and explicitly. (I've expanded on this line 
> of argument in the previous few mails, extensively.)
> 

Ingo, your definition of a static tracer seems to be slightly off from LTTng's
reality in two ways :

First, the kernel tracer supports dynamically loadable "event types", which
makes it quite more flexible than a static tracer that would have to guarantee
a full set of trace points. There is a clear difference between statically
adding instrumentation and statically adding new event types in that forcing a
static set of events would indeed break the user space tools when an event is
added or removed.

Second, the user space analysis tools are built so that they can handle missing
information. So, if they lack things like scheduler change or irq entry/exit
events, they will still show the available information. No "breakage" would
result from a missing probe. Moreover, the LTTV trace analysis tool being
modular and plugin-based, developers can choose to load or not analysis on the
data based on the instrumentation present in the traced kernel.

So there is no guarantee of any full instrumentation set : both instrumentation
and analysis tools are extensible by the users when needed.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
