Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVA0Qhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVA0Qhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVA0Qgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:36:46 -0500
Received: from ns.suse.de ([195.135.220.2]:6820 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262659AbVA0Qfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:35:52 -0500
Date: Thu, 27 Jan 2005 17:36:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/16] New set of input patches
Message-ID: <20050127163605.GA15301@ucw.cz>
References: <200412290217.36282.dtor_core@ameritech.net> <20050113153644.GA18939@ucw.cz> <d120d50005011309526326afef@mail.gmail.com> <20050113192525.GA4680@ucw.cz> <d120d50005011312166fd03c56@mail.gmail.com> <d120d50005012706045b2e84af@mail.gmail.com> <20050127161518.GA14020@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127161518.GA14020@ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 05:15:18PM +0100, Vojtech Pavlik wrote:

> OK. I'll go through them, and apply as appropriate. I still need to wrap
> my mind around the start() and stop() methods and see the necessity. I
> still think a variable in the serio struct, only accessed by the serio.c
> core driver itself (and never by the port driver) that'd cause all
> serio_interrupt() calls to be ignored until set in the asynchronous port
> registration would be well enough.

I've read he start() and stop() code, and I came to the conclusion
again that we don't need them as serio port driver methods. i8042 uses
them to set the exists variable only and uses that variable _solely_ for
the purpose of skipping calls to serio_interrupt(), serio_cleanup() and
serio_unregister().

By instead checking a member of the serio struct in these functions, and
doing nothing if not set, we achieve the same goal, without adding extra
cruft to the interface, making it allowed to call these serio functions
on a non-registered or half-registered serio struct, with the effect
being defined to nothing.

Similarly, it's perfectly allowed to call input_event() on an struct
input_dev that hasn't been registered with the input layer, again with
no effect. It simplifies the driver code a lot.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
