Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270328AbTGWOBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270332AbTGWOBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:01:32 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:1111 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S270328AbTGWOB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:01:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: system_lists@nullzone.org, linux-kernel@vger.kernel.org
Subject: Re: Problems with IDE - Ultra-ATA devices on a SiI chipset IDE  controler
Date: Wed, 23 Jul 2003 15:15:04 +0100
User-Agent: KMail/1.4.3
References: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
In-Reply-To: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307231515.04903.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hi there.
>
>     I have a production server with a SiI680 pci device beeing used as a
> IDE controler.
>     Conected to the external IDE controler I have 4 120GB IDE disks just in
> raid5 Linux-software mode.
>
> Well, I have detected some problems that i cannot understand (I am not a
> expert so ... :-( ) ...
> ( I was using a HighPoint some time ago which gave me the same problems. I
> though I had got to fix the problems getting a new IDE controler but its
> coming back and ... i prefer to fix the problem before I lose more
> information (critical one) as i got after these last problems).
>
> I am getting problems in the ide-buses (I guess).
>
> a) I have cheked the 4 HD just doing:
>
> badblocks -b 4096 -o /tmp/hde_badblocks /dev/hde
> badblocks -b 4096 -o /tmp/hdf_badblocks /dev/hdf
> badblocks -b 4096 -o /tmp/hdg_badblocks /dev/hdg
> badblocks -b 4096 -o /tmp/hdh_badblocks /dev/hdh
>
> and all is OK so i think its a problem in the IDE controler or just in the
> driver (I am not sure).
>
> b) the cables are new. I got new cables (certificated) when i got the
> HighPoint out just with the same problems (resets on IDE buses ...).
> The IDE controler is new too.
>
> Please, could any help me a bit?
> Please...
>
> Could be the problem the temperature in the Box?
>
> (My english is terrible .. please sorry me).
>

I have a CMD ATA/133 RAID controller, using the Sil 680 chipset and dont 
experience any of these issues.
I have a Maxtor 160GB drive as master on one channel, and an IBM 40GB as 
master on the other channel, so I'm not using raid in any form.

I'm using both 2.4.21 and 2.4.19 with this hardware...

- From dmesg:

CMD680: IDE controller on PCI bus 02 dev 48
CMD680: chipset revision 1
CMD680: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe8c0-0xe8c7, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe8c8-0xe8cf, BIOS settings: hdg:pio, hdh:pio
...
hde: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=79780/16/63, UDMA(100)
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, 
UDMA(100)

I wonder if the fact that the bios is setting PIO is the clue here, and you 
shouldn't be using dma on them, even though the drives are DMA...? (I get 
confused by the discrepancy between what the controler reports and what the 
drives report, so I'm winging it a bit here)

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/HphoBn4EFUVUIO0RArOkAJ4hvJCdBZ6BtjujEWY3ok4mwsqqbwCfe2oo
EL5ddn5xyk9jbGIf3GSLxaw=
=OCD7
-----END PGP SIGNATURE-----

