Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVFHFRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVFHFRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 01:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVFHFRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 01:17:23 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:6828 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262100AbVFHFRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 01:17:17 -0400
Date: Wed, 8 Jun 2005 07:17:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Zoltan Boszormenyi <zboszor@freemail.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Mousedev or hiddev problem, was: Re: USB mice do not work on 2.6.12-rc5-git9, -rc5-mm1, -rc5-mm2
Message-ID: <20050608051723.GA1650@ucw.cz>
References: <42A2A0B2.7020003@freemail.hu> <42A2A657.9060803@freemail.hu> <20050605001001.3e441076.akpm@osdl.org> <42A2BC4B.5060605@freemail.hu> <42A2CF27.8000806@freemail.hu> <42A3176F.9030307@freemail.hu> <42A4B328.1010400@freemail.hu> <42A4C85F.2040509@freemail.hu> <20050607053943.GA1778@ucw.cz> <42A67A2B.50600@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42A67A2B.50600@freemail.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 06:55:07AM +0200, Zoltan Boszormenyi wrote:
> Vojtech Pavlik írta:
> >On Tue, Jun 07, 2005 at 12:04:15AM +0200, Zoltan Boszormenyi wrote:
> >
> >>Hi,
> >>
> >>Zoltan Boszormenyi írta:
> >>
> >>>All the -bk7+ kernels I tried produced the same strange bug
> >>>on my system: after gpm started I was able to move the
> >>>pointer on the screen but when X started up, it's pointer froze.
> >>
> >>it turned out that there is nothing wrong with USB on my system.
> >>
> >>But someone broke the /dev/input/mouseX <-> USB mouse interaction
> >>in 2.6.11-bk7 and my two-headed system with two X servers were
> >>manually set up to use the distinct mouse devices so the two heads
> >>do not interfere.
> >>
> >>No wonder gpm works, it reads /dev/input/mice. Starting only
> >>one X and using /dev/input/mice I found no problems. Setting it
> >>back to /dev/input/mouse0, the mouse pointer is dead again.
> >>
> >>Someone deserves a mousebite...
> >
> > 
> >Most likely it's because the keyboards are now identified as having
> >mouse capabilities, too, and changing the numbers. Check
> >/proc/bus/input/devices.
> 
> Thanks for the enlightenment, now I have to use /dev/input/mouse2 and
> mouse3 for the two X servers.
> 
> BTW, where is it documented? Was it this changeset?
> 
> <vojtech@suse.cz>
>         input: Fix keyboard scrollwheel support, add horizontal
>                wheel support, and enable both by default.
> 
>         Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
 
Yes, it was this one, and it'll be disabled again for 2.6.12, since it
causes headaches like yours.

It wasn't documented, because the mouse# numbers were never considered
to be stable (they change if you plug/unplug mice), and thus I didn't
expect anyone using them without having udev make them stable. My wrong.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
