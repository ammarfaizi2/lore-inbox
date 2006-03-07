Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWCGRpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWCGRpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWCGRpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:45:21 -0500
Received: from tomts22.bellnexxia.net ([209.226.175.184]:64141 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751122AbWCGRpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:45:19 -0500
Date: Tue, 7 Mar 2006 12:45:18 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Serge Noiraud <serge.noiraud@bull.net>, linux-kernel@vger.kernel.org,
       ltt-dev@shafik.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: RT patch and arch/i386/kernel/time.c question
Message-ID: <20060307174517.GA24610@Krystal>
References: <200603071742.42262.Serge.Noiraud@bull.net> <Pine.LNX.4.58.0603071220100.15305@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0603071220100.15305@gandalf.stny.rr.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 12:41:47 up 4 days,  2:41,  3 users,  load average: 0.58, 0.20, 0.12
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt (rostedt@goodmis.org) wrote:
> 
> On Tue, 7 Mar 2006, Serge Noiraud wrote:
> 
> > hi,
> >
> > 	I'm trying to port the LTTng patch over the rt20 and I got the following problem :
> > The LTTng patch try to modify the arch/i386/kernel/time.c file in which the
> > timer_interrupt function doesn't exist anymore.
> >
> > In which file / function could I try to patch the equivalent function ?
> >
> 
> The -rt patch uses the lastest stuff from Thomas Gleixner, John Stultz and
> of course Ingo Molnar.  The functions you are interested in, are in
> kernel/time/ directory.  Take a look at clockevents.c and perhaps
> handle_tick().  I'm not sure what LTTng is doing there, but this will give
> you a direction in which way to look.
> 
> -- Steve
> 

LTTng is updating its logical clock there. Note that this clock is only used on
architectures missing a synchronised CPU timestamp counter (NUMA and old i586).

If you have a fairly standard architecture (i686 with TSC available), this
combination of jiffies counter and logical clock is not used.

Look for where the xtime_lock seqlock is taken in the -rt patch : that's where
the logical clock should be updated.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
