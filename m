Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285063AbRLMTmB>; Thu, 13 Dec 2001 14:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285132AbRLMTlr>; Thu, 13 Dec 2001 14:41:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:17792 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S285079AbRLMTlN>; Thu, 13 Dec 2001 14:41:13 -0500
Date: Thu, 13 Dec 2001 14:41:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: Thomas Capricelli <orzel@kde.org>, linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently
In-Reply-To: <080d01c18407$4f741650$5601010a@prefect>
Message-ID: <Pine.LNX.3.95.1011213142534.1037A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Bradley D. LaRonde wrote:

> ----- Original Message -----
> From: "Richard B. Johnson" <root@chaos.analogic.com>
> To: "Bradley D. LaRonde" <brad@ltc.com>
> Cc: "Thomas Capricelli" <orzel@kde.org>; <linux-kernel@vger.kernel.org>
> Sent: Thursday, December 13, 2001 1:34 PM
> Subject: Re: Mounting a in-ROM filesystem efficiently
> 
> 
> > On Thu, 13 Dec 2001, Bradley D. LaRonde wrote:
> > [SNIPPED...]
> >
> > > Sent: Thursday, December 13, 2001 1:02 PM Subject: Re: Mounting a in-ROM
> > > filesystem efficiently
> > >
> > >
> > > > Generally, ROM based stuff is compressed before being written to >
> > > NVRAM. It's uncompressed into a RAM-Disk and the RAM-Disk is mounted.  >
> > > > That way, you can use, say, 2 megabytes of NVRAM to get a 10 to 20 >
> > > megabyte root file-system. This also allows /tmp and /var/log to be >
> > > writable, which is a great help because the development environment >
> > > closely approximates the run-time environment.
> > >
> > > That's perfect if you have plenty of RAM to spare.
> > >
> >
> > Well RAM is a hell of a lot cheaper than NVRAM. If you don't have
> > the required RAM on your box, the hardware engineers screwed up
> > and have to be "educated" preferably with an axe in the parking-lot.
> 
> As I mentioned before, there may be other-than-cost considerations for
> choosing the amount of RAM on a box.  For example, low power consumption on
> portable devices.  For another example, a huge ROM database that doesn't
> need to be in RAM all at once.
> 
> Regards,
> Brad
> 

Then you make a block-device device-driver that extracts and uncompresses
each read from ROM/NVRAM upon demand. It pretends to write. The actual
data-storage device is still paged and it only writes to the caller's
buffer so it doesn't use any RAM for storage.

When writing the compressed NVRAM, one has to use only allocation-unit
sizes, which reduces the amount of compression possible. Basically,
if you have 2000 "blocks", you need to compress 2000 individual blocks
and keep an uncompressed list of each block offset somewhere. This
complication is one of the many reasons why the general solution
is to un-compress everything once into RAM on startup. 

There are many arguments, but I don't think power consumption is
one of them. Whatever they use for RAM on the palm machines allows
the machines to run a week on 4 'aa' -size batteries. Maybe they
grab kinetic energy from keystrokes using flea-generators ^;).

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
 Santa Claus is coming to town...
          He knows if you've been sleeping,
             He knows if you're awake;
          He knows if you've been bad or good,
             So he must be Attorney General Ashcroft.


