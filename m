Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbTBUJDV>; Fri, 21 Feb 2003 04:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbTBUJDV>; Fri, 21 Feb 2003 04:03:21 -0500
Received: from 237.redhat.com ([213.86.99.237]:61167 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267254AbTBUJDT>; Fri, 21 Feb 2003 04:03:19 -0500
Subject: Re: PATCH: clean up the IDE iops, add ones for a dead iface
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302190853180.18995-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302190853180.18995-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045818779.5856.6.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 21 Feb 2003 09:13:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 16:56, Linus Torvalds wrote:
> On 19 Feb 2003, Benjamin Herrenschmidt wrote:
> > Hrm... I tend to agree with Russell here... 0x7f is the "safe" value
> > for IDE. IDE controllers with nothing wired shall have a pull down
> > on D7. The reason is simple: busy loops in the IDE code waiting for
> > BSY to go down.
> 
> But that's a BUG.
> 
> We've seen that before: try unplugging a PCMCIA IDE card unexpectedly. 
> 
> Guess what? It will start returning 0xff. And the machine dies, because 
> the PCMCIA interrupt happened due to the removal event will also be shared 
> by the IDE driver, so the IDE driver will react badly even before anybody 
> has had a chance to tell it that the hardware no longer exists.

Er, actually they make the card detect pins a different length for a
reason -- not just so they look pretty :) 

You are guaranteed a certain amount of time between the card detect
firing to signal removal, and the actual disconnection of the device.

And you can't rely on getting 0xFF; sometimes your box just locks up
hard if you try to access the missing hardware any time after the
'warning period' has expired and the device has actually gone.

Admittedly that's a fairly screwed box -- but I have them and was
expected to make them userproof.

-- 
dwmw2
