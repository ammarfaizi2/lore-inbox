Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUBCJ1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 04:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265945AbUBCJ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 04:27:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26298 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265943AbUBCJ1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 04:27:33 -0500
Date: Tue, 3 Feb 2004 04:26:33 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core 
In-Reply-To: <20040203010224.459E32C252@lists.samba.org>
Message-ID: <Pine.LNX.4.58.0402030418310.22596@devserv.devel.redhat.com>
References: <20040203010224.459E32C252@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Feb 2004, Rusty Russell wrote:

> Wrong migration thread.  The migration thread on CPU 1 has been asked to
> push into CPU 0, which is now going down.

you are right - this one place would have to be aware of CPUs going away.

> Now I've slept on the "do it atomically" idea, I think it's a good one.  
> I've even worked out how to maintain the "last thread on CPU is the idle
> thread", although I'd need to test in code.

good!

> In practice, any app which wants to scale with # CPUs needs to know when
> CPUs are coming up, as well as going down.  Ditto memory, etc. This
> means they need to listen for the hotplug event (DBUS anyone?), or we
> introduce a SIGRECONF (default ignored).  But AFAICT, introducing a new
> signal isn't possible (at least on x86) without breaking glibc.

you can introduce a variable RT signal for this purpose no problem - and
one would want to have a queued signal for this anyway. Ie. by default the
notification is disabled, but a new syscall sets up the process to be
notified of CPU up/down events, on a signal # picked by the app. But this
this indeed is dbus domain ...

	Ingo
