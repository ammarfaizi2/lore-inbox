Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbTK1XhQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbTK1XhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 18:37:16 -0500
Received: from chello080109110030.13.15.vie.surfer.at ([80.109.110.30]:35456
	"EHLO boundary.priv") by vger.kernel.org with ESMTP id S263541AbTK1XhM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 18:37:12 -0500
Message-ID: <3FC7DEB3.7030104@spamcop.net>
Date: Sat, 29 Nov 2003 00:48:03 +0100
From: Eduard Hasenleithner <ehasenle@spamcop.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Better performance with pdc20376 compared to SiI 3112
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Although I like the SiI 3112 due it's open specs I found that the
somehow "closed" pdc20376 promise chip performs essentially better
with the new GPL drivers on a non-tweaked 2.6.0-test11 kernel :(
With SiI 3112 I get about 16MB/s, with pdc20376 54MB/s, which is
most likely the maximum harddisk performance of my seagate drive.

So what is the status of the siimage driver? Can I expect it to
improve in further kernel releases?

On a further note I found that no /proc/ide nodes are allocated
for the siimage driver. What can be the reason for this?

Below this section I show output from dd and hdparm in order
to give information about my setup.

=== test with promise pdc20376 ===
boundary:~ # time dd if=/dev/sda of=/dev/null bs=1048576 count=1024
1024+0 records in
1024+0 records out
real    0m18.441s
user    0m0.004s
sys     0m3.428s

=== reboot, test with SiI 3112 ====
boundary:~ # time dd if=/dev/hde of=/dev/null bs=1048576 count=1024
1024+0 records in
1024+0 records out
real    1m2.666s
user    0m0.003s
sys     0m4.009s

=== second try, just to be sure ===
boundary:~ # time dd if=/dev/hde of=/dev/null bs=1048576 count=1024
1024+0 records in
1024+0 records out
real    1m2.648s
user    0m0.006s
sys     0m3.884s

=== output of hdparm ===
boundary:~ # hdparm -I /dev/hde
/dev/hde:

ATA device, with non-removable media
	Model Number:       ST3120026AS
	Serial Number:      3JS1X69W
	Firmware Revision:  3.56
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2
	Supported: 6 5 4 3
Configuration:
	Logical		max	current
	cylinders	16383	65535
	heads		16	1
	sectors/track	63	63
	--
	CHS current addressable sectors:    4128705
	LBA    user addressable sectors:  234441648
	LBA48  user addressable sectors:  234441648
	device size with M = 1024*1024:      114473 MBytes
	device size with M = 1000*1000:      120034 MBytes (120 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard
	R/W multiple sector transfer: Max = 16	Current = ?
	Recommended acoustic management value: 254, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command
	   *	Device Configuration Overlay feature set
	   *	48-bit Address feature set
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test
	   *	SMART error logging
Security:
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

=== ls -R /proc/ide (where is hde?) ===
/proc/ide:
.  ..  drivers  hda  hdc  ide0  ide1  via

/proc/ide/ide0:
.  ..  channel  config  hda  mate  model

/proc/ide/ide0/hda:
.   cache     driver    identify  model     smart_thresholds
..  capacity  geometry  media     settings  smart_values

/proc/ide/ide1:
.  ..  channel  config  hdc  mate  model

/proc/ide/ide1/hdc:
.  ..  capacity  driver  identify  media  model  settings


=== lspci -v (snipped) ===
00:07.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 
SATARaid Controller (rev 02)
	Subsystem: CMD Technology Inc: Unknown device 6112
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
	I/O ports at ec00 [size=8]
	I/O ports at e800 [size=4]
	I/O ports at e400 [size=8]
	I/O ports at e000 [size=4]
	I/O ports at dc00 [size=16]
	Memory at dffffe00 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at dff00000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2

00:0d.0 RAID bus controller: Promise Technology, Inc. PDC20376 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 6620
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 19
	I/O ports at bc00 [size=64]
	I/O ports at b800 [size=16]
	I/O ports at b400 [size=128]
	Memory at dfffe000 (32-bit, non-prefetchable) [size=4K]
	Memory at dffc0000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [60] Power Management version 2

Thanks for any hints!


