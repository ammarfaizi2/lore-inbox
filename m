Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUBCHgt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 02:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUBCHgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 02:36:49 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:40064 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265898AbUBCHgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 02:36:48 -0500
Date: Tue, 3 Feb 2004 08:37:06 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "P. Christeas" <p_christ@hol.gr>, acpi-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: FYI: ACPI 'sleep 1' resets atkbd keycodes
Message-ID: <20040203073706.GE337@ucw.cz>
References: <200401251137.21646.p_christ@hol.gr> <20040125115946.GA414@ucw.cz> <200402022338.48010.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402022338.48010.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 11:38:41PM -0500, Dmitry Torokhov wrote:

> I feel a little uneasy about killing the input device if set changes after
> resume. That would cause a new input device created but for user it would
> look like keyboard is lost or am I missing someting?

The console will automatically and immediately grab the new keyboard and
everything will continue to work, even X, because it uses the console
for input.

Later, when X uses the event interface, it'll get a notification that
the keyboard was removed and added again, which will cause it to open
the new one, so all will be OK, too.

> What about the patch below which would reset keyboard to the default keymap
> only if set changes?

I don't think there is a problem with just reconnecting. It's extremely
unlikely that the set can change, too, because everyone uses translated
set 2, and that's the lowest common denominator.

Unless you specified extra arguments on the kernel command line, you
can't get any other set.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
