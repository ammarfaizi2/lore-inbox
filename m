Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283458AbRK3B1F>; Thu, 29 Nov 2001 20:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283460AbRK3B0z>; Thu, 29 Nov 2001 20:26:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:57572 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283458AbRK3B0p>;
	Thu, 29 Nov 2001 20:26:45 -0500
Date: Fri, 30 Nov 2001 02:26:37 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org, ziegler@informatik.hu-berlin.de
Subject: Re: IDE controller detection 2.4 +devfs
Message-Id: <20011130022637.290ad791.rene.rebe@gmx.net>
In-Reply-To: <200111300111.fAU1BLR05033@vindaloo.ras.ucalgary.ca>
In-Reply-To: <20011130001138.78ab1242.rene.rebe@gmx.net>
	<200111300017.fAU0Hx704241@vindaloo.ras.ucalgary.ca>
	<20011130012752.0fd5380a.rene.rebe@gmx.net>
	<200111300034.fAU0YB904723@vindaloo.ras.ucalgary.ca>
	<20011130015538.68b09e03.rene.rebe@gmx.net>
	<200111300111.fAU1BLR05033@vindaloo.ras.ucalgary.ca>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001 18:11:21 -0700
Richard Gooch <rgooch@ras.ucalgary.ca> wrote:

> But it is actually predictable, isn't it? Think of it this way: the
> IDE subsystem reserves "slots" (host numbers) for installed hardware.
> If a piece of hardware is disabled in the BIOS, it doesn't mean that
> the slot won't be reserved.

It would be nice if it would be that way - se below.

> > (All info from my very first mail ...)
> > 
> > The other bug is: On a Athlon-600 workstation based on an Irongate
> > board (Asus-K7M) I have to disable the first (primarry) channel of
> > the onbaord IDE controller, because it has problem with the UDMA-66
> > mode. But when I disable this channel, Linux generates a /dev/ide/host1
> > entry - No host0 entry is there. Sure it works - but sucks, too!
> > (Generates a very unstable feeling in me ...)
> 
> The "host0" entry isn't shown, because it is disabled. But to say
> "when I disable this channel, Linux generates a /dev/ide/host1" isn't
> correct, and implies a problem where there isn't. The correct way to
> describe this is:
> "host0" is my primary onboard IDE controller. It might not appear if I
> disable it.
> "host1" is my secondary onboard IDE controller. It has the same name
> whether or not I disable the primary.

No!!!! On the Althon box:
- nothing disabled in BIOS:
/dev/ide/host0/bus0/ - on-board primary channel
/deV/ide/host0/bus1/ - on-board secondary channel

- when I disable the primary channel I get this:
/dev/ide/host1/bus1/ - on-board secondary channel

So as you can see it moves!! From host0 to host1!

> And this is a Feature[tm]. It means that tomorrow when a shiny new
> drive arrives, you can plug it into your primary channel and enable
> the channel in the BIOS. You can then boot without having to fix your
> /etc/fstab, because /dev/ide/host1 is still pointing to the same
> devices.

Yes that is a really cool advantage I now for months (over a year!)!
But here is the next example again:

The K6 server (on-board ALI-Aladin-5 + PCI-Card Promisse controller):

/dev/ide/host0/bus0/ - on-board primary channel
/dev/ide/host0/bus1/ - on-board secondary channel
/dev/ide/host2/bus0/ - Promisse primary channel
/dev/ide/host2/bus1/ - Promisse secondarychannel

So where is host1 ??????

(Maybe I should switch back to Mew as MUA to not let kernel-hackers
see the Sylpheed string in the mail-header :-((()

> The only thing that confuses me is why the secondary onboard channel
> is /dev/ide/host1 rather than /dev/ide/host0/bus1.

Only when disabled in the bios (but PLEASE look at the nice lists above
...)

> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca


k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #127875 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
