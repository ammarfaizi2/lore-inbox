Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312704AbSEAOUJ>; Wed, 1 May 2002 10:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312772AbSEAOUI>; Wed, 1 May 2002 10:20:08 -0400
Received: from elin.scali.no ([62.70.89.10]:65295 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S312704AbSEAOUH>;
	Wed, 1 May 2002 10:20:07 -0400
Date: Wed, 1 May 2002 16:19:53 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Plan for e100-e1000 in mainline
In-Reply-To: <3CCF796C.5090401@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0205010952390.5918-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2002, Jeff Garzik wrote:

> J.A. Magallon wrote:
>
> >Hi.
> >
> >Well, subject says it all. Which is the status/plans for inclussion
> >of those drivers in mainline kernel ? AFAIR, e1000 had been licensed,
> >but e100 was not clear yet.
> >
>
> e100 has been in 2.5.x for quite a long time.  All license issues have
> similarly been resolved a long time ago.
>
> I expect Intel's Q/A to green light their current driver.  With a few
> patches it should be ready for 2.4.x soon.
>
> You can easily copy drivers/net/e100[0] into a 2.4.x kernel, it likely
> compiles without modification.
>

Has the latency issues with e100 compared to eepro100 been resolved too ?
Last time I checked the e100 driver (version 1.8.38) had terrible high
latency on small messages even in a back-to-back configuration (both
machines using the same driver). As a test I used netperf's TCP_RR
benchmark (TCP roundtrip) :

Message size  | eepro100 latency (usec) | e100 latency (usec)
--------------------------------------------------------------
     16                 108.985                 114.116
     24                 110.940                 116.679
     32                 114.129                 119.608
     48                 118.614                 125.507
     64                 124.341                1093.150
     96                 135.864                1102.190
    128                 147.177                1102.726
    192                 167.343                 838.799
    256                 188.410                 858.572
    384                 230.797                 900.941
    512                 271.281                 941.104
    768                 354.270                1024.753
   1024                 437.307                1108.231
   1536                 612.688                1293.912
   2048                 699.168                1334.828
   3072                 872.554                1670.787
   4096                1032.183                1556.056


As you can see, with a TCP payload of 64 bytes the latency is quite high
with the e100 driver compared to the eepro100 driver. As a side note: it
didn't work well with the bonding module either (neither did the e1000
module).

Another funny thing is that the latency for the gigabit adapter (e1000)
is also higher than fast ethernet (eepro100) with small messages (<256
bytes) :

Message size  | eepro100 latency (usec) | e1000 latency (usec)
--------------------------------------------------------------
     16                 108.985                 177.138
     24                 110.940                 177.370
     32                 114.129                 177.523
     48                 118.614                 178.189
     64                 124.341                 178.769
     96                 135.864                 179.669
    128                 147.177                 180.517
    192                 167.343                 183.339
    256                 188.410                 184.552
    384                 230.797                 188.929
    512                 271.281                 191.787
    768                 354.270                 198.745
   1024                 437.307                 205.793
   1536                 612.688                 240.772
   2048                 699.168                 249.540
   3072                 872.554                 282.348
   4096                1032.183                 299.220

Regards,
 --
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency


