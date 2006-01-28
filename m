Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWA1NcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWA1NcK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 08:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWA1NcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 08:32:09 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:38627 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751343AbWA1NcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 08:32:08 -0500
Date: Sat, 28 Jan 2006 14:32:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-ID: <20060128133244.GA22704@elte.hu>
References: <20060127230659.GA4752@sgi.com> <20060127191400.aacb8539.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127191400.aacb8539.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> Jack wrote:
> > Should the following change be made to sched_getaffinity(). 
> > 
> > Index: linux/kernel/sched.c
> > ===================================================================
> > --- linux.orig/kernel/sched.c	2006-01-25 08:50:21.401747695 -0600
> > +++ linux/kernel/sched.c	2006-01-27 16:57:24.504871895 -0600
> > @@ -4031,7 +4031,7 @@ long sched_getaffinity(pid_t pid, cpumas
> >  		goto out_unlock;
> >  
> >  	retval = 0;
> > -	cpus_and(*mask, p->cpus_allowed, cpu_possible_map);
> > +	cpus_and(*mask, p->cpus_allowed, cpu_online_map);
> 
> Adding Robert Love to the cc list, as he is Mr. sched_getaffinity, I 
> believe.

i'm to blame for the syscall, Robert is to blame for the tool side
:-) In any case, Jack's change looks reasonable and obviously correct.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
