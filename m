Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTELRii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbTELRih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:38:37 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:60206 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262412AbTELRif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:38:35 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, stern@rowland.harvard.edu,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com
In-Reply-To: <20030512173023.GB28381@kroah.com>
References: <1052336482.2020.8.camel@diemos>
	 <20030507152856.2a71601d.akpm@digeo.com> <1052402187.1995.13.camel@diemos>
	 <20030508122205.7b4b8a02.akpm@digeo.com> <1052503920.2093.5.camel@diemos>
	 <1052512235.2997.8.camel@diemos> <20030509142828.59552d0a.akpm@digeo.com>
	 <1052747862.1996.9.camel@diemos> <20030512162454.GA27939@kroah.com>
	 <1052759300.1995.4.camel@diemos>  <20030512173023.GB28381@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052761769.1995.27.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 May 2003 12:49:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-12 at 12:30, Greg KH wrote:
> > Should the 20ms delay be in the ISR though?
> > I thought it was standard practice to move such
> > lengthy operations outside of the ISR so as not to
> > impact interrupt latency for the system.
> 
> This should only happen when the hardware is suspended, and we are being
> woken up by a device.  So this should be a _very_ rare occurance, and
> when it does happen, the latency isn't that big of a deal (we need it to
> wake up the hardware properly.)

So you feel interrupt latency does not matter when
a machine is waking up? I'm not particularly worried
about that situation, so I won't argue that.

How about some sort of sanity check (as you mentioned
earlier), so this is not shooting off all of the time
during normal operation.

> > There are no USB devices attached to the server.
> > There are no actual USB connectors, and the
> > server's specs do not list USB. There is no
> > option to enable/disable USB in the BIOS.
> 
> Heh, then I would suggest not loading this driver at all.  It sounds
> like you have an internal USB controller that probably does not have
> properly terminated connectors.

Maybe.

But most distributions have the USB driver loaded by
default, so if this new change stays as is, it will silently
cause erratic problems for such machines (with unused
USB controllers on the mainboard).

Then this investigation will be repeated over and over
by end users and anyone trying to support latency
sensitive devices (such as standard serial ports) on Linux.

So either a sanity check to prevent unnecessary
calls to this delay, or recoding the delay so it
does not run in the ISR and kill interrupt latency
would be the correct thing to do.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


