Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311166AbSCPW2Z>; Sat, 16 Mar 2002 17:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311175AbSCPW2P>; Sat, 16 Mar 2002 17:28:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55307 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311166AbSCPW2G>; Sat, 16 Mar 2002 17:28:06 -0500
Date: Sat, 16 Mar 2002 14:26:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anders Gustafsson <andersg@0x63.nu>, <arjanv@redhat.com>,
        <linux-kernel@vger.kernel.org>, <mochel@osdl.org>
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <E16mMer-0007Q4-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203161421240.8278-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Mar 2002, Alan Cox wrote:
> > In the general reboot case yes it is a BIOS bug.  In the general Linux
> > booting Linux case there is no BIOS involved.
>
> In that case yes I can see why you want to turn the bus masters off when you
> boot the new kernel

Truning bus masters off is easy enough, and could just be done by some
generic PCI reboot code. But for a linux-linux boot I think you also want
to turn off interrupt generation to make sure some device isn't screaming
on some irq, and that definitely requires explicit help by the driver
itself.

One question that hasn't come up: do we actually want to use the "remove"
function for this, or have a separate shutdown function? Are there reasons
to not use "remove" for shutdown?

		Linus

