Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270724AbRIFN2t>; Thu, 6 Sep 2001 09:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270712AbRIFN2j>; Thu, 6 Sep 2001 09:28:39 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:19464 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S270748AbRIFN2Y>;
	Thu, 6 Sep 2001 09:28:24 -0400
Message-ID: <20010906173534.A21874@castle.nmd.msu.ru>
Date: Thu, 6 Sep 2001 17:35:34 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Andi Kleen <ak@suse.de>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org, Wietse Venema <wietse@porcupine.org>
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
In-Reply-To: <20010905170037.A6473@emma1.emma.line.org.suse.lists.linux.kernel> <20010905152738.C5912BC06D@spike.porcupine.org.suse.lists.linux.kernel> <20010905182033.D3926@emma1.emma.line.org.suse.lists.linux.kernel> <oupg0a1wi9x.fsf@pigdrop.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <oupg0a1wi9x.fsf@pigdrop.muc.suse.de>; from "Andi Kleen" on Wed, Sep 05, 2001 at 09:26:50PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 05, 2001 at 09:26:50PM +0200, Andi Kleen wrote:
> Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:
> > 
> > I believe this would require fixing for compatibility reasons, in the
> > sense that the address is also compared to figure the interface, but I'm
> > out of time now and cannot try anything before tomorrow, I'd happily
> > test patches sent by then.
> 
> Even if it checked the address it would not be unique because you can have multiple
> interfaces with the same addresses but different netmasks.
> The SIOCGIFNETMASK interface is just broken. If you really wanted it you should use
> rtnetlink instead, which allows multiple answers to a single question.
> Likely postfix doesn't really need it though, the concept of checking for "local"
> address is pretty dubious and likely to be incorrect for many cases.

Andi, it's right to the point.
The only one good reason for an SMTP server to bother about IP addresses at
all is a quick check for mail loops, i.e. a check at the moment of opening
TCP connection to send a message whether your peer is yourself.
Bothering about network masks just doesn't have any valid grounds.

In fact, sending message to yourself this way is not a disaster, mail system
has loop protection by design.  However, sending message to yourself wastes
system resources.

It's not possible to answer the right question (whether you talk to yourself)
inspecting IP addresses.
One may have several mail servers on a single computer, each with its own
configuration file, using different local IP addresses.
In the original example, mail systems on 192.168.0.4 and 192.168.1.1 may be
different.

So, the very right way of doing things is:
 - make admin specify the listening addresses for a mail system in the
   configuration and use them to check for loops;
 - never try to learn anything about networking configuration.

	Andrey
