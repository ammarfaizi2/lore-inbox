Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRKDTQd>; Sun, 4 Nov 2001 14:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRKDTQY>; Sun, 4 Nov 2001 14:16:24 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:11406 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S273065AbRKDTQO> convert rfc822-to-8bit; Sun, 4 Nov 2001 14:16:14 -0500
Date: Sun, 4 Nov 2001 17:31:14 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, <linux-kernel@vger.kernel.org>,
        <groudier@club-internet.fr>
Subject: Re: Adaptec vs Symbios performance
In-Reply-To: <20011104193520.1867ae7e.skraw@ithnet.com>
Message-ID: <20011104170859.M2017-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Stephan,

The difference in performance for your CD (slow device) between aic7xxx
and sym53c8xx using equi-capable HBAs (notably Ultra-160) cannot be
believed a single second to be due to a design flaw in the aic7xxx driver.

Instead of trying to prove Justin wrong with his driver, you should look
into your system configuration and/or provide Justin with accurate
information and/or do different testings in order to get some clue about
the real cause.

You may have triggerred a software/hardware bug somewhere, but I am
convinced that it cannot be a driver design bug.

In order to help Justin work on your problem, you should for example
report:

- The device configuration you set up in the controller EEPROM/NVRAM.
- The kernel boot-up messages.
- Your kernel configuration.
- Etc...

You might for example have unintentionnaly configured some devices in the
HBA set-up for disconnection not to be granted. Such configuration MISTAKE
is likely to kill SCSI performances a LOT.

  Gérard.

PS: If you are interested in Justin's ability to design software for SCSI,
then you may want to have a look into all FreeBSD IO-related stuff owned
by Justin.


On Sun, 4 Nov 2001, Stephan von Krawczynski wrote:

> On Sun, 04 Nov 2001 11:10:26 -0700 "Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>
> > >On Sat, 03 Nov 2001 22:47:39 -0700 "Justin T. Gibbs" <gibbs@scsiguy.com>
> wrote
> > Show me where the real problem is, and I'll fix it.  I'll add the bottom
> > half handler too eventually, but I don't see it as a pressing item.  I'm
> > much more interested in why you are seeing the behavior you are and exactly
> > what, quantitatively, that behavior is.
>
> Hm, what more specific can I tell you, than:
>
> Take my box with
>
> Host: scsi1 Channel: 00 Id: 03 Lun: 00
>   Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 1.0A
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 08 Lun: 00
>   Vendor: IBM      Model: DDYS-T36950N     Rev: S96H
>   Type:   Direct-Access                    ANSI SCSI revision: 03
>
> and an aic7xxx driver. Start xcdroast an read a cd image. You get something
> between 2968,4 and 3168,2 kB/s throughput measured from xcdroast.
>
> Now redo this with a Tekram controller (which is sym53c1010) and you get
> throughput of 3611,1 to 3620,2 kB/s.
> No special stuff or background processes or anything else involved. I wonder
> how much simpler a test could be.
> Give me values to compare from _your_ setup.
>
> If you redo this test with nfs-load (copy files from some client to your
> test-box acting as nfs-server) you will end up at 1926 - 2631 kB/s throughput
> with aic, but 3395 - 3605 kB/s with symbios.
>
> If you need more on that picture, then redo the last and start _some_
> application in the background during the test (like mozilla). Time how long it
> takes until the application is up and running.
> If you are really unlucky you have your mail-client open during test and let it
> get mails via pop3 in a MH folder (lots of small files). You have a high chance
> that your mail-client is unusable until xcdroast is finished with cd reading -
> but not with symbios.
>
> ??
>
> Regards,
> Stephan


