Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752045AbWG1Qpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbWG1Qpf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbWG1Qpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:45:35 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:1162 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1752045AbWG1Qpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:45:34 -0400
Subject: Re: A better interface, perhaps: a timed signal flag
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Theodore Tso <tytso@mit.edu>, Neil Horman <nhorman@tuxdriver.com>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <1154104885.13509.142.camel@localhost.localdomain>
References: <44C67E1A.7050105@zytor.com>
	 <20060725204736.GK4608@hmsreliant.homelinux.net>
	 <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain>
	 <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org>
	 <20060725235644.GA5147@localhost.localdomain> <44C6B117.80300@zytor.com>
	 <20060726002043.GA5192@localhost.localdomain>
	 <20060726144536.GA28597@thunk.org>
	 <1154093606.19722.11.camel@localhost.localdomain>
	 <20060728145210.GA3566@thunk.org>
	 <1154104885.13509.142.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 12:44:49 -0400
Message-Id: <1154105089.19722.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 17:41 +0100, Alan Cox wrote:
> Ar Gwe, 2006-07-28 am 10:52 -0400, ysgrifennodd Theodore Tso:
> > Good point, and limiting this facility to one such timeout per
> > task_struct seems like a reasonable restriction. 
> 
> Why is this any better than using a thread or signal handler ? From the
> implementation side its certainly horrible - we will be trying to write
> user pages from an IRQ event. Far better to let the existing thread code
> deal with it.
> 

If the user page is special, in that it is really a kernel page mapped
to userspace.  The implementation on making sure it doesn't disappear on
the interrupt isn't that difficult.

But for real-time applications, the signal handling has a huge latency.
Where as what Theodore wants to do is very light weight.  ie. have a
high prio task doing smaller tasks until a specific time that tells it
to stop.  Having a signal, would create the latency on having that task
stop.

These little requests make sense really only in the real-time space.
The normal uses can get by with signals.  But I will say, the normal
uses for computing these days are starting to want the real-time
powers. :)

-- Steve


