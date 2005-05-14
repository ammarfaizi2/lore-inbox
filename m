Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbVENQcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVENQcq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 12:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVENQbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 12:31:14 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59582 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262800AbVENQab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 12:30:31 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Matt Mackall <mpm@selenic.com>,
       Andy Isaacson <adi@hexapodia.org>, Andi Kleen <ak@muc.de>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <1116084186.20545.47.camel@localhost.localdomain>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
	 <1116024419.20646.41.camel@localhost.localdomain>
	 <1116025212.6380.50.camel@mindpipe>  <20050513232708.GC13846@redhat.com>
	 <1116027488.6380.55.camel@mindpipe>
	 <1116084186.20545.47.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 14 May 2005 12:30:28 -0400
Message-Id: <1116088229.8880.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-14 at 16:23 +0100, Alan Cox wrote:
> On Sad, 2005-05-14 at 00:38, Lee Revell wrote:
> > Well yes but you would still have to recompile those apps.  And take the
> > big performance hit from using gettimeofday vs rdtsc.  Disabling HT by
> > default looks pretty good by comparison.
> 
> You cannot use rdtsc for anything but rough instruction timing. The
> timers for different processors run at different speeds on some SMP
> systems, the timer rates vary as processors change clock rate nowdays.
> Rdtsc may also jump dramatically on a suspend/resume.
> 
> If the app uses rdtsc then generally speaking its terminally broken. The
> only exception is some profiling tools.

That is basically all JACK and mplayer use it for.  They have RT
constraints and the tsc is used to know if we got woken up too late and
should just drop some frames.  The developers are aware of the issues
with rdtsc and have chosen to use it anyway because these apps need
every ounce of CPU and cannot tolerate the overhead of gettimeofday(). 

Lee

