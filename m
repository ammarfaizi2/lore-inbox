Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267161AbSKMKl1>; Wed, 13 Nov 2002 05:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbSKMKl1>; Wed, 13 Nov 2002 05:41:27 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:44688 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id <S267161AbSKMKl0>; Wed, 13 Nov 2002 05:41:26 -0500
Date: Wed, 13 Nov 2002 10:48:09 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: Oliver Neukum <oliver@neukum.name>
Cc: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org
Subject: Re: hotplug (was devfs)
Message-ID: <20021113104809.D2386@axis.demon.co.uk>
References: <20021112093259.3d770f6e.spyro@f2s.com> <20021112094949.GE17478@higherplane.net> <6uadkf9kdt.fsf@zork.zork.net> <200211121351.08328.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211121351.08328.oliver@neukum.name>; from oliver@neukum.name on Tue, Nov 12, 2002 at 01:51:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 01:51:08PM +0100, Oliver Neukum wrote:
> > Actually, here's a question: are /sbin/hotplug upcalls serialized in
> > some fashion?  I'd hate to online a thousand devices in my disk array
> > and have the machine forkbomb itself.
> 
> Nope, no serialisation. You don't have any guarantee even that
> addition will be delivered before removal.

And that is why (we finally discovered) we were getting
non-deterministic device numbering of USB nodes.

We have machines with 6 x 4 port USB <-> serial converters attached.
These would get randomly assigned usb device ids and hence random
/dev/ttyUSB nodes.  Not very useful when there is a load of different
things attached to the 24 serial ports!

Sometimes we also found that one of the devices wouldn't get
initialised properly.

We fixed these problems by removing hotplug and loading the relevant
kernel modules in the correct order and voila a perfectly
deterministic order for the /dev/ttyUSBs with all devices initialised.

Plugging in our USB bus with 24 devices on it does indeed produce a
mini-forkbomb effect ;-) (Especially since these Keyspan devices are
initialised twice - once without firmware and once with firmware.)

So - perhaps hotplug ought to be serialised?

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
