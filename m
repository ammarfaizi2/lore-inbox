Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277689AbRJLNdz>; Fri, 12 Oct 2001 09:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277686AbRJLNdf>; Fri, 12 Oct 2001 09:33:35 -0400
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:41722 "EHLO
	gintaras.vetrunge.lt.eu.org") by vger.kernel.org with ESMTP
	id <S277684AbRJLNd1>; Fri, 12 Oct 2001 09:33:27 -0400
Date: Fri, 12 Oct 2001 15:33:22 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard + PS/2 mouse locks after opening psaux
Message-ID: <20011012153322.A662@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200110112004.f9BK47b0070854@smtpzilla2.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110112004.f9BK47b0070854@smtpzilla2.xs4all.nl>
User-Agent: Mutt/1.3.22i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 10:04:06PM +0200, Koos Vriezen wrote:
> I had the same symptoms, console input froze for several minutes. I tried 
> several things and after disabling CONFIG_X86_UP_APIC in the kernel, it 
> didn't occur anymore (but I'm not sure it's the cause).

CONFIG_X86_UP_APIC is disabled on my system.

Today I tried some experimenting: after repeatedly switching between vt1
and vt7 for some time I got the lockup.  Syslog didn't contain any
interesting messages.  The counters for keyboard and PS/2 mouse in
/proc/interrupts became stuck.  One interesting thing I noticed is that
PS/2 mouse line disappeared for a short time during console switch.
While gpm was running, fuser and lsof indicate that it didn't have
/dev/mouse open -- only XFree86 did.

I've waited for about 30 minutes for any keyboard timeouts to appear,
but didn't see any.  Then I tried chvt 7 with no effect (vt7 was already
the active console).  Then chvt 1 fixed the lockup.  Interrupt counters
went alive again.  This time fuser and lsof showed that /dev/mouse is
opened by gpm only.  It looks like both XFree and gpm close /dev/mouse
when they're not active, and reopen it then they become active.

I'm now compiling 2.4.9 with some printk()s added in open_aux and
release_aux.  If I get any interesting results, I'll post them here.

Marius Gedminas
-- 
When all else fails, read the instructions.
