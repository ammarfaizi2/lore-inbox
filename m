Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTENVDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTENVDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:03:05 -0400
Received: from quattro.sventech.com ([205.252.248.110]:28873 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id S262903AbTENVDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:03:03 -0400
Date: Wed, 14 May 2003 17:15:51 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>,
       Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>
Subject: Re: 2.5.69 Interrupt Latency
Message-ID: <20030514171551.E20401@sventech.com>
References: <Pine.LNX.4.44L0.0305131117240.3274-100000@ida.rowland.org> <1052840106.2255.24.camel@diemos> <20030513173044.GB10284@kroah.com> <1052830860.1992.2.camel@diemos> <20030513180913.GA10752@kroah.com> <20030513181120.GA10790@kroah.com> <1052946393.2974.7.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052946393.2974.7.camel@diemos>; from paulkf@microgate.com on Wed, May 14, 2003 at 04:06:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003, Paul Fulghum <paulkf@microgate.com> wrote:
> I was looking over the PIIX3 datasheet and noticed
> that the USBSTS_RD bit is only valid when the
> device is in the suspended state.
> 
> This bit is being acted on regardless of the
> suspend state of the controller in the ISR.
> Could this be why the driver is detecting
> false 'resume' signals and calling wakeup_hc()
> when it shouldn't?
> 
> Maybe the code should be something like:
> 
> if (uhci->is_suspended && (status & USBSTS_RD))
> 	wakeup_hc(uhci);
> 
> in the ISR to qualify acting on that status bit.
> Alternatively, USBCMD_EGSM (BIT3) of the USBCMD
> register could be tested to qualify action on
> the state of USBSTS_RD
> 
> I'm going to test this now, but I wanted to
> know what you think.

Good eye. That may very well be the problem. Looking at the UHCI specs,
it says the same thing, but I never really noticed it before.

JE

