Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSJaR53>; Thu, 31 Oct 2002 12:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265271AbSJaR4D>; Thu, 31 Oct 2002 12:56:03 -0500
Received: from 208-135-136-018.customer.apci.net ([208.135.136.18]:55304 "EHLO
	blessed") by vger.kernel.org with ESMTP id <S265269AbSJaRzG>;
	Thu, 31 Oct 2002 12:55:06 -0500
Date: Thu, 31 Oct 2002 12:01:16 -0600 (CST)
From: Josh Myer <jbm@joshisanerd.com>
X-X-Sender: jbm@blessed
To: Juan Gomez <juang@us.ibm.com>
cc: jt@hpl.hp.com, <linux-kernel@vger.kernel.org>
Subject: Re: How to get a local IPv4 address from within a kernel module?
In-Reply-To: <OF3A0A864F.BCE2D0BA-ON87256C63.006000B8@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210311152110.20675-100000@blessed>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In general, the only way a "get interface address" function would be
accepted into mainline is if it was Generally Useful.

In order for it to be Generally Useful, you'll want to make it able to
get any address of any interface. Otherwise it's useless cruft for one
specific purpose, which can't be used anywhere else.

I'd suggest a function to get a list of interfaces, and then a function to
get a list of addresses for a given interface. Then you could just grab
the first address of the first interface for your application. Don't
forget to take into account that interfaces can change address, go up and
down, disappear/reappear, and change actual hardware...

And even that isn't Generally Useful. In fact, what the hell it's good for
is left as an exercise for the reader (implementation, too).

Though if "any IPv4 on any interface" will do, just assume 127.0.0.1 on
lo. Anyone that changes that has sins to atone for, and finding kernel
quirks is appropriate penance.

Did we mention that you'd be best to get the address in userspace and pass
it into the module? That's really the best bet...
--
/jbm, but you can call me Josh. Really, you can!
 "What's a metaphor?" "For sheep to graze in"
7958 1C1C 306A CDF8 4468  3EDE 1F93 F49D 5FA1 49C4


On Thu, 31 Oct 2002, Juan Gomez wrote:

>
>
>
>
>
> Jean,
>
> I am aware of all this, however, my application will be happy to get any
> IPv4 assigned to any of the local interfaces as far as you consistently
> get the same on repeated calls.
> I think there should be an interface to query this from within the kernel
> so since I did not find it I am proposing to get one
> or may be there is something hidden which I missed so I decided to ask
> here.
>
> Juan
>
>
>
>
> |---------+---------------------------------->
> |         |           Jean Tourrilhes        |
> |         |           <jt@bougret.hpl.hp.com>|
> |         |           Sent by:               |
> |         |           linux-kernel-owner@vger|
> |         |           .kernel.org            |
> |         |                                  |
> |         |                                  |
> |         |           10/30/02 06:38 PM      |
> |         |           Please respond to jt   |
> |         |                                  |
> |---------+---------------------------------->
>   >------------------------------------------------------------------------------------------------------------------|
>   |                                                                                                                  |
>   |       To:       Linux kernel mailing list <linux-kernel@vger.kernel.org>                                         |
>   |       cc:                                                                                                        |
>   |       Subject:  Re: How to get a local IPv4 address from within a kernel module?                                 |
>   |                                                                                                                  |
>   |                                                                                                                  |
>   >------------------------------------------------------------------------------------------------------------------|
>
>
>
> Juan Gomez wrote :
> >
> > Is there any standard way of doing this? I looked into ipv4 code but I
> did
> > not find a function that would provide a direct, clean way to query the
> > local IPv4 addresses of a given node.
>
>              There is no such thing as the local IPv4 addresses of a given
> node. IP addresses are assigned for each network interfaces, so you
> may have more than one IP address. Note that I have many systems that
> don't have any "eth0" and still have many IP addresses (on wlan0,
> ppp0, bnep0...).
>              On top of that, the DNS may assign an IP address that map to
> your current hostname (which may correspond to one of the addresses
> above). That's purely a user space stuff.
>
>              So, you are basically starting on a wrong assumption, the
> information you are looking for doesn't exist, and I therefore suspect
> that you need to rethink the thing you want to do.
>
>              I suggest you use a user space application to pick the IP
> address most relevant to your setup (i.e. policy decision) and inject
> it in your module.
>
>              Good luck,
>
>              Jean
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

