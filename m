Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281082AbRKDSiO>; Sun, 4 Nov 2001 13:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281132AbRKDShV>; Sun, 4 Nov 2001 13:37:21 -0500
Received: from ns.ithnet.com ([217.64.64.10]:46094 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S281091AbRKDSf3>;
	Sun, 4 Nov 2001 13:35:29 -0500
Date: Sun, 4 Nov 2001 19:35:20 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, groudier@club-internet.fr
Subject: Re: Adaptec vs Symbios performance
Message-Id: <20011104193520.1867ae7e.skraw@ithnet.com>
In-Reply-To: <200111041810.fA4IAQY68511@aslan.scsiguy.com>
In-Reply-To: <20011104151726.06193c01.skraw@ithnet.com>
	<200111041810.fA4IAQY68511@aslan.scsiguy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Nov 2001 11:10:26 -0700 "Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> >On Sat, 03 Nov 2001 22:47:39 -0700 "Justin T. Gibbs" <gibbs@scsiguy.com>
wrote
> Show me where the real problem is, and I'll fix it.  I'll add the bottom
> half handler too eventually, but I don't see it as a pressing item.  I'm
> much more interested in why you are seeing the behavior you are and exactly
> what, quantitatively, that behavior is.

Hm, what more specific can I tell you, than:

Take my box with

Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 1.0A
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: IBM      Model: DDYS-T36950N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03

and an aic7xxx driver. Start xcdroast an read a cd image. You get something
between 2968,4 and 3168,2 kB/s throughput measured from xcdroast.

Now redo this with a Tekram controller (which is sym53c1010) and you get
throughput of 3611,1 to 3620,2 kB/s.
No special stuff or background processes or anything else involved. I wonder
how much simpler a test could be.
Give me values to compare from _your_ setup.

If you redo this test with nfs-load (copy files from some client to your
test-box acting as nfs-server) you will end up at 1926 - 2631 kB/s throughput
with aic, but 3395 - 3605 kB/s with symbios.

If you need more on that picture, then redo the last and start _some_
application in the background during the test (like mozilla). Time how long it
takes until the application is up and running. 
If you are really unlucky you have your mail-client open during test and let it
get mails via pop3 in a MH folder (lots of small files). You have a high chance
that your mail-client is unusable until xcdroast is finished with cd reading -
but not with symbios.

??

Regards,
Stephan


