Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136131AbREGOM7>; Mon, 7 May 2001 10:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136132AbREGOMt>; Mon, 7 May 2001 10:12:49 -0400
Received: from switch.datavakten.no ([195.159.40.3]:10510 "HELO
	switch.datavakten.no") by vger.kernel.org with SMTP
	id <S136131AbREGOMi>; Mon, 7 May 2001 10:12:38 -0400
From: =?us-ascii?Q?Oyvind_Jagtnes?= <oyvind@datavakten.no>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.4-ac5 aic7xxx causes hang on my machine
Date: Mon, 7 May 2001 15:58:30 +0200
Message-ID: <FPEPKOJDLAJALEILAKEOAEAFCCAA.oyvind@datavakten.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.20.0105070800360.142-200000@bigandy>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It works fine on my dual ppro 200 (not sure what mobo). Here is lcpci:

00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
01)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II]
(rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton
II]
00:09.0 SCSI storage controller: Adaptec AIC-7880U
00:11.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]

It has 2 atlas iv disks attached + 3 ide disks. Boots from ide and running
scsi disks in lvm.

Oyvind Jagtnes

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Andy Carlson
Sent: 7. mai 2001 15:04
To: linux-kernel@vger.kernel.org
Subject: 2.4.4-ac5 aic7xxx causes hang on my machine


I have a dual ppro 200MHZ W6LI motherboard.  I put 2.4.4-ac5 on last
night, and the machine hung at Freeing unused Kernel memory.  I
selectively backed off what I thought were relevant patches.  I got to
aic7xxx, and ac5 without it worked. I attached /proc/scsi/aic7xxx/0.

Andy Carlson                           |\      _,,,---,,_
naclos@swbell.net                ZZZzz /,`.-'`'    -.  ;-;;,_
BJC Health System                     |,4-  ) )-,_. ,\ (  `'-'
St. Louis, Missouri                  '---''(_/--'  `-'\_)
Cat Pics: http://andyc.dyndns.org

On Mon, 7 May 2001, Christoph Rohland wrote:

> Hi,
>
> The appended patch does it's own accounting of shmem pages and adjust
> the page cache size to take these into account. So now again you will
> see shmem pages as used in top/vmstat etc. This confused a lot of
> people.
>
> There is a uncertainty in the calculations since the vm may drop pages
> behind shmem and the number of shmem pages is estimated too high. This
> especially happens on truncate because first the page cache is reduced
> and later the shmem readjusts it's count.
>
> To prevent negative cache sizes the adjustment is only done if
> shmem_nrpages > page_cache_size.
>
> The latter part of the patch (all the init.c files) also exports the
> shmem page number to the shared memory field in meminfo. This means a
> change in semantics of this field but apparently a lot of people
> interpret this field exactly this way and it was not used any more
>
> The patches are on top of my encapsulation patch.
>
> Greetings
> 		Christoph
>

