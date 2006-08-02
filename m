Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWHBRgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWHBRgV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWHBRgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:36:21 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:47751
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751289AbWHBRgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:36:20 -0400
Date: Wed, 2 Aug 2006 10:35:53 -0700
To: Daniel Walker <dwalker@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.6.17-rt8 crash amd64
Message-ID: <20060802173553.GA29327@gnuppy.monkey.org>
References: <20060802011809.GA26313@gnuppy.monkey.org> <1154482302.30391.14.camel@localhost.localdomain> <20060802021956.GC26364@gnuppy.monkey.org> <20060802022539.GA26799@gnuppy.monkey.org> <20060802071348.GA28653@gnuppy.monkey.org> <1154539004.8620.16.camel@c-67-188-28-158.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154539004.8620.16.camel@c-67-188-28-158.hsd1.ca.comcast.net>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 10:16:44AM -0700, Daniel Walker wrote:
> On Wed, 2006-08-02 at 00:13 -0700, Bill Huey wrote:
> 
> >   [ 3254.657547] BUG: scheduling while atomic: mv/0x00000001/5222
> >   [ 3254.663380]
> >   [ 3254.663381] Call Trace:
> >   [ 3254.667255]        <ffffffff8025ef25>{__schedule+155}
> >   [ 3254.672491]
> >   <ffffffff802616cb>{_raw_spin_unlock_irqrestore+81}
> 
> >   [ 3254.836278]        <ffffffff8025df02>{ia32_sysret+0}
> >   [ 3254.841606] ---------------------------
> >   [ 3254.845554] | preempt count: 00000001 ]
> >   [ 3254.849503] | 1-level deep critical section nesting:
> >   [ 3254.854614] ----------------------------------------
> >   [ 3254.859725] .. [<ffffffff8025ef3d>] .... __schedule+0xb3/0xb2a
> >   [ 3254.865743] .....[<ffffffff8025fbab>] ..   ( <=
> >   preempt_schedule+0x55/0x8f)
> 
> 
> _raw_spin_unlock_irqrestore() calls preempt_schedule() which calls
> __schedule() , maybe (should be impossible though)? 
> 
> Are you using a 32-bit userspace and a 64-bit kernel ?

Yes, but this happens with 64 bit apps as well. I'm going to take a
deeper look at it today. My current track is to look at processes
reaping. That seems to be a common attribute in all of those stack
traces. I thought there was more debug instrumentation that dealt
with preempt_count tracking before ?

bill

