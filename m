Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTEAWQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 18:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTEAWQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 18:16:50 -0400
Received: from ns.suse.de ([213.95.15.193]:20236 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262714AbTEAWQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 18:16:45 -0400
To: Hans-Georg Thien <1682-600@onlinehome.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh a  PS/2 Trackpad
References: <3EB19625.6040904@onlinehome.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 May 2003 00:29:07 +0200
In-Reply-To: <3EB19625.6040904@onlinehome.de.suse.lists.linux.kernel>
Message-ID: <p73znm61eto.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Georg Thien <1682-600@onlinehome.de> writes:

> The short story
> ---------------
> The trackpad on the MacIntosh iBook Notebooks have a feature that
> prevents unintended trackpad input while typing on the keyboard. There
> are no mouse-moves or mouse-taps for a short period of time after each
> keystroke.

Very nice. In fact I wanted something like this for my ibook for a
long time.

But it won't work on an ibook of course because it doesn't use the
pc_keyb driver. Instead it uses the Input layer for the adb device.
In fact in 2.5 there is only the input layer for everything including
PC keyboards. It should be probably moved there too.

One suggestion: don't make it a CONFIG_*. Recompiling a kernel
to change things like that is not good. Make it an ioctl that
can be configured at runtime.

Another one: the disable_trackpad_timer_while_typing variable is not 
really needed. You can manage all state by checking the timer with
timer_pending()

-Andi
