Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284535AbRLEWCB>; Wed, 5 Dec 2001 17:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284536AbRLEWAO>; Wed, 5 Dec 2001 17:00:14 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:15092
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S284760AbRLEV7Z>; Wed, 5 Dec 2001 16:59:25 -0500
Date: Wed, 5 Dec 2001 13:59:17 -0800
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 freezes during IDE RAID5 resync
Message-ID: <20011205215917.GD9050@mikef-linux.matchmail.com>
Mail-Followup-To: Rene Rebe <rene.rebe@gmx.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011205195308.53c6170c.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011205195308.53c6170c.rene.rebe@gmx.net>
User-Agent: Mutt/1.3.24i
From: Mike Fedyk <mfedyk@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 07:53:08PM +0100, Rene Rebe wrote:
> Hi all!
> 
> Due to a f**ked power shortage (no UPS yet) our server had to reboot:
> Hardware:
> 
> model name      : AMD-K6(tm) 3D processor
> stepping        : 0
> cpu MHz         : 350.814
> 
> RAM: 128 MB
>

SMP 2x366 Celeron, 256MB ram, Debian sid-Unstable (2.4.16)

lspci:
00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
00:08.0 SCSI storage controller: Adaptec AIC-7881U (rev 01)
00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
00:0b.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G100 [Productiva] AGP (rev 01)

/proc/isapnp:
Card 1 'CTL0044:Creative SB32 PnP' PnP version 1.0 Product version 1.0

> There where 1 (for /) and 3 software RAID 5 IBM-DTLA-305040 each as master
> on a single channel connected all using ReiserFS.
>

Just /home in ext3 (data=journal) on /dev/md0

Personalities : [raid1] 
read_ahead 1024 sectors
md0 : active raid1 hda3[0] sda3[1]
      3927808 blocks [2/2] [UU]
      
unused devices: <none>


hda: FUJITSU MPB3043ATU
sda: Vendor: IBM      Model: DCAS-34330W      Rev: S65A

> The system freezed (no oops - simply freeze) reproduceable during a ReiseFS
> check of the / partiotion. (So it doens't even come to the /home md0 one).
>
> I even booted a recsue disc mounted the / (so the transaction-log is clean),
> and rebooted. Then it freezes at an ramdon point during the init.d scripts.
>

Didn't crash (hang, no oops, interrupts off -- no sysrq, no capslock/numlock
response) during the init scripts, but did while X was running during a
raid1 reconstruction.

> I fixed it by removing one IBM disc from the on-board IDE chip's
> second channel and adding it to the promisse as slave. Now it works?
>
> The server ran stable for 17 days using a 2.4.14 kernel and using the
> 2.4.16 since it got out ... I do not know what might be wrong, IDE code,

2.4.14+ext3 was also reliable for me.

Common items in our setups are IDE and RAID.

I can run some tests if anyone comes up with something.

mf
