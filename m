Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUDPBzw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 21:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUDPBzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 21:55:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:28552 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261369AbUDPBzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 21:55:45 -0400
Subject: Re: radeonfb broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040415202523.GA17316@codeblau.de>
References: <20040415202523.GA17316@codeblau.de>
Content-Type: text/plain
Message-Id: <1082080010.5657.234.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 11:46:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> However, running mplayer does not work at all on radeonfb.  mplayer
> inquires about the color depth, I am using 32 bit color depth for this,
> but radeonfb says it's DirectColor instead of TrueColor, so mplayer
> tries to initialize the palette and fails.

It is DirectColor and setting the palette should work. If it doesn't
then we indeed have a bug, but so far, I didn't have any problems
with MacOnLinux which does fbdev and sets the palette properly not
with XFree which does also set the palette. In DirectColor, the
palette is actually a gamma table.

> Also, using fbset to set the mode to 1600x1200 fails.  The mode is
> changed, but the text console resolution stays the same.  Worse, a
> "setfont" changes back to 1024x768.

Yes, that's not a radeonfb problem. The current 2.6 fbcon driver is
completely broken in this regard imho. It tries to adapt the display
mode on stty and setfont, which usually doesn't work properly since it
can't calculate supported modes properly (well... radeonfb sort of can
but it's the only one who can and there are still issues). On the
other hand, it doesn't adapt properly to changes done via fbset.

I have done some workarounds for this but they triggered other bugs
in the fbcon driver at that time, some of them causing memory
corruption, so I didn't commit my changes upstream.

A bunch of this should have been fixed by now, I need to re-sync with
James Simmons and see if I can make that to work now.

> Also, I cannot view images on console with fbi or fbv.
> 
> Felix
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

