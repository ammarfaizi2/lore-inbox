Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVKWPti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVKWPti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVKWPti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:49:38 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:65155 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751127AbVKWPtf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:49:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NwnNpMzT8Kih5X2qJD9y2C3fTqi13LsUeYFxoOVMC4vsy3ps30xAKrYULmRz92/yW7o5lbFS6RaqL1H9kq5X0MssPUTbId8Hc8PSOV74fxNllZ6dQ3KYnsLH6OyfIYiUST3mMRPQq0tYd5xGr+E7Se/T9Fl3GjxN+F/Ru4x5pAw=
Message-ID: <9e4733910511230749l67722bd3q736ed10c3e0639a8@mail.gmail.com>
Date: Wed, 23 Nov 2005 10:49:35 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>, Vojtech Pavlik <vojtech@suse.cz>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       rmk+lkml@arm.linux.org.uk
Subject: Re: Christmas list for the kernel
In-Reply-To: <20051123152950.GC15449@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <20051123121726.GA7328@ucw.cz>
	 <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
	 <20051123150349.GA15449@flint.arm.linux.org.uk>
	 <438488A0.8050104@drzeus.cx>
	 <20051123152950.GC15449@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Wed, Nov 23, 2005 at 04:20:00PM +0100, Pierre Ossman wrote:
> > But if no hardware is connected to those devices, then where does the
> > driver route the setserial stuff?
>
> setserial /dev/ttyS2 port 0x200 irq 5 autoconfig
>
> and you might then end up with another serial port detected.  If
> /dev/ttyS2 and above do not exist, you can't do that.  That would
> in turn effectively prevent folk with some serial cards using them
> with Linux without editing and rebuilding their kernel.

If my box has two serial ports and I use setserial to change the port,
I still only have two serial ports.  Shouldn't this behave as a
hotplug remove/add when the port address is changed?

> As for the rest of the "setserial stuff" it gets recorded against
> the port and remembered for when the hardware turns up, which it
> may do if it's your PCMCIA modem card.

This is definitely not in the current spirit of hotplug. The PCMCIA
card should generate a hotplug add event and then the script for the
event can do the setserial equivalent.

You could probably modify setserial to create the scripts and the user
would never know things changed.

--
Jon Smirl
jonsmirl@gmail.com
