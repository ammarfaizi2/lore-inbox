Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268066AbTBRW5d>; Tue, 18 Feb 2003 17:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268083AbTBRW5c>; Tue, 18 Feb 2003 17:57:32 -0500
Received: from AMarseille-201-1-6-77.abo.wanadoo.fr ([80.11.137.77]:44583 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S268066AbTBRW5b>;
	Tue, 18 Feb 2003 17:57:31 -0500
Subject: Re: [ACPI] Re: Fixes to suspend-to-RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@transmeta.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0302181535520.1035-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0302181535520.1035-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045609701.7399.5.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Feb 2003 00:08:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 22:41, Patrick Mochel wrote:

> I propose that we don't even call SUSPEND_DISABLE. Based on recent
> conversations, it appears that we can and should do the entire device
> suspend sequence in two passes - SUSPEND_SAVE_STATE with interrupts
> enabled, and SUSPEND_POWER_DOWN with interrupts disabled.

Right... though I still care about my early pet SUSPEND_NOTIFY for
the few things that need to care about allocations issues (that is
that need to know they can no longer rely on GFP_KERNEL & friends
not blocking until wakeup).

Regarding failure, what I did with success on pmac (I had occasional
failure to suspend from the OHCI controller or video drivers during
tests, though those seem to be quite rare in real life) is to call
back the wakeup calls for devices that got the matching suspend
call.

I beleive it's as safe to just call all wakeup calls in order
instead though, and it makes things simpler (as the individual
drivers should really know in what state they really are).

Ben.

