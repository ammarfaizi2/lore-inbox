Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263750AbUE3NmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUE3NmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 09:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUE3NmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 09:42:24 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:57217 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263750AbUE3NmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 09:42:22 -0400
Date: Sun, 30 May 2004 15:42:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org, tuukkat@ee.oulu.fi
Subject: SERIO_USERDEV patch for 2.6
Message-ID: <20040530134246.GA1828@ucw.cz>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de> <20040530124353.GB1496@ucw.cz> <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 03:25:10PM +0200, Sau Dan Lee wrote:
 
>     Vojtech> Your psaux/userspace serio driver is fine, except it
>     Vojtech> cannot coexist with the other drivers.
> 
> That's why I've abandoned it.  It's obsolete.
> 
> Our (Tuukka and I) SERIO_USERDEV  patch does work with kernel drivers,
> and allow  both kernel  and userland drivers  to coexist.   Again, I'm
> disappointed that you still haven't discovered this.

The newest I could find:

linux-2.6.5-userdev.20040507.patch

Known problems:
	- The kernel internal psmouse driver should not be loaded when using
	  user space driver, otherwise the drivers may try to initialize the
	  device into incompatible state.

That's what I call 'cannot coexist with other kernel drivers'.
Coexisting would mean that when someone wants to open the raw device,
the serio layer would disconnect the psmouse driver, and give control to
the raw device instead. I believe that could work.

Anyway, looking at the patch, it's not bad, and it's quite close to what
I was considering to write. I'd like to keep it separate from the
serio.c file, although it's obvious it'll require to be linked to it
statically, because it needs hooks there - it cannot be a regular serio
driver.

> Now, it's time  for you to try our SERIO_USERDEV  patch, plus my crude
> userspace atkbd.c and psmouse drivers.

It's indeed time for me to examine the SERIO_USERDEV patch, and I
should've examined it earlier than now, sorry for that, but I don't need
to test your userspace drivers, as I'm not interested in those.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
