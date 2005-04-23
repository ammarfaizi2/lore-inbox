Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVDWSWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVDWSWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDWSWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:22:33 -0400
Received: from orb.pobox.com ([207.8.226.5]:44218 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261651AbVDWSWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:22:31 -0400
Date: Sat, 23 Apr 2005 13:22:27 -0500
From: Nathan Lynch <ntl@pobox.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hotplug CPU and setaffinity?
Message-ID: <20050423182227.GE18688@otto>
References: <20050423173514.GA7111@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423173514.GA7111@gallifrey>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. David Alan Gilbert wrote:
>
>   I got to wondering how Hotplug CPU and sched_setaffinity interact;
> if I have a process that has its affinity set to one CPU and some
> nasty person comes along and unplugs it what happens to that process-
> does it get scheduled onto another cpu, just not get any time or
> die ?

The affinity of the process is reset to the default and it is migrated
to another cpu, for better or worse.  The kernel assumes the admin
know what he/she is doing.

> 
> In particular I was thinking of the cases where a thread has a
>  functional reason for remaining on one particular CPU (e.g. if you
> had calibrated for some feature of that CPU say its time stamp
> counter skew/speed). Another case would be a set of threads which
> had set their affinity to the same CPU and then made memory
> consistency or locking assumptions that wouldn't be valid
> if they got rescheduled onto different CPUs.

Yeah.  But I don't think this is an issue to be solved in the kernel.
Applications that are this sensitive to cpu hotplugging need to
arrange to be notified before the hotplug occurs, which I think would
be best done with dbus or some other IPC.


Nathan


