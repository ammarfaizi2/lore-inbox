Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWFGAdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWFGAdR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWFGAdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:33:17 -0400
Received: from ns1.suse.de ([195.135.220.2]:40127 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751406AbWFGAdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:33:14 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 02:33:06 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, jeremy@goop.org,
       dzickus@redhat.com, shaohua.li@intel.com, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <200606071013.53490.ncunningham@linuxmail.org> <20060606172410.b901950e.akpm@osdl.org>
In-Reply-To: <20060606172410.b901950e.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606070233.07259.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 June 2006 02:24, Andrew Morton wrote:
> On Wed, 7 Jun 2006 10:13:49 +1000
>
> Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> > > the new CPU to get the same state as the old one just because it ends
> > > up with the same logical CPU number?  Perhaps, but what if it doesn't
> > > even have the same capabilities?  (Do we support heterogeneous CPUs
> > > anyway?)
> >
> > Indeed. I'm also not sure that there's necessarily a guarantee that cpus
> > will be hotplugged in the same order. Perhaps those with more knowledge
> > can clarify there.
>
> It all depends on what we mean by "per-cpu state".  If we were to remember
> that "CPU 7 needs 0x1234 in register 44" then that would be wrong.  But
> remembering some high-level functional thing like "CPU 7 needs to run the
> NMI watchdog" is fine.  The CPU bringup code can work out whether that is
> possible, and how to do it.

Actually the nmi watchdog state should be global, not per CPU.  We
want it to either work for the whole system or be completely disabled.

What is per CPU are the performance counter allocations, but these
can be forgotten over CPU unplug/replug.

(ok this means oprofile  might need to be restarted after suspend/resume,
but I guess that's reasonable) 

-Andi
