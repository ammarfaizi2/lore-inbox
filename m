Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTENVPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTENVPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:15:54 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:61320 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261153AbTENVPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:15:52 -0400
Date: Wed, 14 May 2003 14:30:28 -0700
From: Greg KH <greg@kroah.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com
Subject: Re: 2.5.69 Interrupt Latency
Message-ID: <20030514213028.GA4200@kroah.com>
References: <Pine.LNX.4.44L0.0305131117240.3274-100000@ida.rowland.org> <1052840106.2255.24.camel@diemos> <20030513173044.GB10284@kroah.com> <1052830860.1992.2.camel@diemos> <20030513180913.GA10752@kroah.com> <20030513181120.GA10790@kroah.com> <1052946393.2974.7.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052946393.2974.7.camel@diemos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 04:06:33PM -0500, Paul Fulghum wrote:
> On Tue, 2003-05-13 at 13:11, Greg KH wrote:
> 
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

That's basically what the code I sent you did :)

> in the ISR to qualify acting on that status bit.
> Alternatively, USBCMD_EGSM (BIT3) of the USBCMD
> register could be tested to qualify action on
> the state of USBSTS_RD
> 
> I'm going to test this now, but I wanted to
> know what you think.

I think it's correct, but I don't think it will solve your problem.  I
would be very happy to be wrong though.

thanks,

greg k-h
