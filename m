Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbSIWUGL>; Mon, 23 Sep 2002 16:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSIWUGK>; Mon, 23 Sep 2002 16:06:10 -0400
Received: from taifun.devconsult.de ([212.15.193.29]:52235 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S261299AbSIWUGH>; Mon, 23 Sep 2002 16:06:07 -0400
Date: Mon, 23 Sep 2002 22:11:17 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Karim Yaghmour <karim@opersys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
Message-ID: <20020923221117.A29758@devcon.net>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LTT-Dev <ltt-dev@shafik.org>
References: <Pine.LNX.4.44.0209230929010.2659-100000@localhost.localdomain> <3D8F2F4C.BC5B82C@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8F2F4C.BC5B82C@opersys.com>; from karim@opersys.com on Mon, Sep 23, 2002 at 11:12:12AM -0400
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 11:12:12AM -0400, Karim Yaghmour wrote:
> 
> Sure, for performance measurements it's the admin, but per my earlier
> descriptions:
> - users who want to debug synchronization problems of their own tasks
> shouldn't see the kernel's behavior.
> - users who want to log custom events separate from the kernel events
> don't want to see the kernel's beavhior.

Fairly simple to achieve: provide some sort of userspace trace daemon
from which the users request the trace events they want to see
(communicating through standard IPC channels). The daemon provides a
unified event mask to the kernel (to prevent unnecessary overhead in
the kernel proper) and dispatches the events read from the kernel.
AFAICS LTT doesn't try to achieve realtime event monitoring, so
somewhat delaying the event propagation to the final receiver should
not be a problem (at least as long as it generally stays within a
reasonable timewindow, which should be no problem as long as the
system is not heavily overloaded, in which case in-kernel dispatching
would be nothing better).

Apart from taking complexity out of the kernel it also reduces the
tracing impact in case of event bursts because (provided the
ringbuffer is large enough) the (potentially timeconsuming in case of
many active tracers) dispatching of events is decoupled (in time) from
the event recording.

You will have to record uid/gid/pid/whatever criteria you might think
of with the event, somewhat enlarging (by a few bytes) a single event
record (don't know how much of this data you are currently gathering),
but that is a minor tradeoff IMHO.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
