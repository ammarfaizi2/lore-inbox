Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbTBUBPk>; Thu, 20 Feb 2003 20:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbTBUBPj>; Thu, 20 Feb 2003 20:15:39 -0500
Received: from 251.017.dsl.syd.iprimus.net.au ([210.50.55.251]:56502 "EHLO
	file1.syd.nuix.com.au") by vger.kernel.org with ESMTP
	id <S267038AbTBUBPg> convert rfc822-to-8bit; Thu, 20 Feb 2003 20:15:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Song Zhao <song.zhao@nuix.com.au>
Reply-To: song.zhao@nuix.com.au
Organization: Nuix
Subject: Re: Supermicro X5DL8-GG (ServerWorks Grandchampion LE chipset) slow
Date: Fri, 21 Feb 2003 12:25:12 -0500
User-Agent: KMail/1.4.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302211225.12636.song.zhao@nuix.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Fri, 21 Feb 2003 12:24:10 -0500
From: Song Zhao <song.zhao@nuix.com.au>
To: Dave Jones <davej@codemonkey.org.uk>

On Thu, 20 Feb 2003 09:57 am, you wrote:
> On Thu, Feb 20, 2003 at 08:34:28PM -0500, Song Zhao wrote:
>  > Dual 2.8GHz Xeon, 3ware Escalade 7850 (7500-8) 12 port IDE RAID
>  > controller, RAID 10, 4x 1GB DDR SDRAM Registered ECC, 2x 80GB WD HDD,
>  > 10x 120GB WD HDD, ServerWorks Grand Champion LE.
>  > I am running RH7.3 with 2.4.20 kernel. The performance of this box is
>  > about half of an almost identical box (Supermicro X5DP8-G2 mobo, E7501
>  > chipset)
>
> You mentioned nothing about what sort of performance you were measuring.
> Disk, network, memory bandwidth etc.., however at a complete guess you
> are hitting this..

I did some disk I/O and CPU benchmarks, including bonnie++, hdparm, nbench,
unixbench, dbench, tiotest. I haven't done any network/memory testing yet.

Here is a rough comparison of E7500, E7501 and the ServerWorks Chipset:

==========================================================================

| Benchmark 				| E7500E7501 	| ServerWorks 	| GrandChampion LE 	|

==========================================================================

| Nbench (integer index) 		| 33.47 		| 38.78 		| 10.61 			|

==========================================================================

| Nbench (floating-point index) 	| 27.03 		| 32.05 		| 20.87 			|

==========================================================================

| Unixbench index			| 329 		| 349.5 		| 141.6 			|

==========================================================================

| Hdparm -t 				| 70.33MB/s 	| 73.73MB/s 	| 46.04MB/s 		|

==========================================================================

| Hdparm -T 				| 512MB/s 		| 673.68MB/s 	| 673.68MB/s 		|

==========================================================================

| Tiobench (write) 			| 41.2MB/s		| 42.09MB/s	| 44.37MB/s		|

==========================================================================

| Tiobench (random write) 		| 7.03MB/s 	| 9.73MB/s 	| 10.87MB/s 		|

==========================================================================

| Tiobench (read) 			| 1520.05MB/s 	| 1528.2MB/s 	| 1267.15MB/s 		|

==========================================================================

| Tiobench (random read) 		| 1391.36MB/s 	| 1471.28MB/s	| 1041.67MB/s 		|

==========================================================================

> mtrr: Serverworks LE detected. Write-combining disabled.

from dmesg:

mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel

ServerWorks CSB5: IDE controller on PCI bus 00 dev 79
ServerWorks CSB5: chipset revision 147
ServerWorks CSB5: not 100% native mode: will probe irqs later

from lspci (please note that I took out 3ware card which I mentioned in my
previous mail):

00:00.0 Host bridge: ServerWorks: Unknown device 0014 (rev 31)
00:00.1 Host bridge: ServerWorks: Unknown device 0014
00:00.2 Host bridge: ServerWorks: Unknown device 0014
00:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:04.0 Ethernet controller: Intel Corp.: Unknown device 100e (rev 02)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.3 Host bridge: ServerWorks: Unknown device 0225
00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
01:03.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5703X Gigabit
Ethernet (rev 02)

> This workaround was for older sewerworks chipsets which were
> buggy. Rumour has it that revisions 6 and above are ok.
> I have a patch pending for 2.5, if it turns out to be stable,
> it should also get merged back to 2.4
>
> 		Dave

-------------------------------------------------------

