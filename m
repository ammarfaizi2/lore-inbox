Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbTEYFjS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 01:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTEYFjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 01:39:18 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:59325 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S261279AbTEYFjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 01:39:17 -0400
Subject: Re: [RFC] Fix NMI watchdog documentation
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0305250102130.17353-100000@montezuma.mastecende.com>
References: <3ECFC2D6.2020007@gmx.net>
	 <Pine.LNX.4.50.0305241505470.2267-100000@montezuma.mastecende.com>
	 <Pine.LNX.4.50.0305241509380.2267-100000@montezuma.mastecende.com>
	 <200305250329.h4P3TGoH004620@turing-police.cc.vt.edu>
	 <Pine.LNX.4.50.0305242335090.17353-100000@montezuma.mastecende.com>
	 <200305250448.h4P4mqoH005720@turing-police.cc.vt.edu>
	 <Pine.LNX.4.50.0305250102130.17353-100000@montezuma.mastecende.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053841936.1177.5.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 May 2003 01:52:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-25 at 01:03, Zwane Mwaikambo wrote: 
> On Sun, 25 May 2003 Valdis.Kletnieks@vt.edu wrote:
> 
> > On Sat, 24 May 2003 23:36:26 EDT, Zwane Mwaikambo said:
> > 
> > > > Dell Latitude with broken BIOS detected. Refusing to enable the local APIC.
> > 
> > > It's known broken with that configuration and hence blacklisted.
> > 
> > Yes, I know it's blacklisted.  The question I intended to ask was "Is the
> > entire concept of IOAPIC irretrievably scrozzled on this machine, or is there
> > sufficient minimum functionality to get nmi_watchdog working?"
> 
> You don't have an IOAPIC at all, but the Local APIC has been known to 
> cause problems. So forget about nmi_watchdog.
> 
> 	Zwane

I was reading that code the other day (just out of curiosity, believe it
or not) and I'm wondering how recently that has been tested - most of
the blacklist/oddness workarounds listed in dmi_scan.c are
model-specific, but the APIC entry is any Dell Inspiron or Latitude.  

I'm going to remove the test tomorrow sometime and see what happens -
lots has changed since the Inspiron 8000, including a migration to
p4-mobile, so its worth seeing if the newer Dells are fixed.  If so,
I'll submit a patch to make that more model-specific (probably I'll just
add a whitelist function - no_local_apic_kills_bios or some such; seems
better than listing every dell inspiron individually..)

I'm encouraged by the complete lack of APM or any of the 'enter bios
while running' options present on the older laptops; according to the
comments, even if the APIC kills the bios on entry/exit, it won't matter
since you can't trigger it to begin with..

-- 

Disconnect <lkml@sigkill.net>

