Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRBVUHv>; Thu, 22 Feb 2001 15:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRBVUHc>; Thu, 22 Feb 2001 15:07:32 -0500
Received: from cpta5.dur.ac.uk ([129.234.9.41]:54788 "EHLO cpta5.dur.ac.uk")
	by vger.kernel.org with ESMTP id <S129242AbRBVUHM>;
	Thu, 22 Feb 2001 15:07:12 -0500
Message-ID: <3A957160.903FCF56@durham.ac.uk>
Date: Thu, 22 Feb 2001 20:06:56 +0000
From: David John SUMMERS <D.J.Summers@durham.ac.uk>
Organization: CPT, Dept. of Physics, Durham.
X-Mailer: Mozilla 4.7 [en] (X11; I; OSF1 V4.0 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tytso@mit.edu, andre@linux-ide.org
Subject: pdc202xx corruping file system under 2.4.0 kernel
Content-Type: multipart/mixed;
 boundary="------------6C3843C124DF3FFDD21EAB27"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6C3843C124DF3FFDD21EAB27
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Using the pdc202xx version 0.30 driver for a Promise 20265
chip under the 2.4.0 kernel I'm getting file system
corruptions. Whats odd though is that e2fsck can't correct
the corrupted file systems. Here is the setup :-

Hardware: AMD Athlon
          Asus A7V motherboard
          Via Apollo Chipset
          Promise 20265 IDE controler
          IBM 75GXP hard disk

Under the 2.2.16 kernel I have no problems (this is running
without UDMA). Upgrading to the 2.4.0 kernel, with the
pdc202xx driver, I occasionally get bad blocks showing up on
my root partition. e2fsck (both from E2fsprogs version 1.18
and version 1.10) run with "-c" pick up the bad blocks, but
are unable to fix the problem - and so just adds the blocks
in question to the list of bad blocks. Now for the bizare
part, running

badblocks -w /dev/hda1 1052226

and the bad blocks disappear! I can recreate the ext2 fs
afterwards without any problems. This has happened on two
different machines (both with an identical hardware set up).

Is this a known problem? Are there any work arounds?

Thanks in advance for your help,

David Summers.

P.S. I attach various output files, lspci -v, and dumpe2fs
on the fs when the bad blocks were noted. the kernel module
on boot up says :-

Feb 22 18:51:00 cpt4 kernel: PDC20265: IDE controller on PCI
bus 00 dev 88
Feb 22 18:51:00 cpt4 kernel: PCI: Found IRQ 10 for device
00:11.0
Feb 22 18:51:00 cpt4 kernel: PDC20265: chipset revision 2
Feb 22 18:51:00 cpt4 kernel: PDC20265: not 100%% native
mode: will probe irqs later
Feb 22 18:51:00 cpt4 kernel: PDC20265: (U)DMA Burst Bit
ENABLED Primary PCI Mode Secondary PCI Mode.
Feb 22 18:51:00 cpt4 kernel:     ide0: BM-DMA at
0x7800-0x7807, BIOS settings: hda:DMA, hdb:DMA
Feb 22 18:51:00 cpt4 kernel:     ide1: BM-DMA at
0x7808-0x780f, BIOS settings: hdc:DMA, hdd:DMA


--------------6C3843C124DF3FFDD21EAB27
Content-Type: text/plain; charset=us-ascii;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 8033
	Flags: bus master, medium devsel, latency 0
	Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: df000000-dfcfffff
	Prefetchable memory behind bridge: dff00000-e3ffffff
	Capabilities: <available only to root>

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
	Subsystem: Asustek Computer, Inc.: Unknown device 8033
	Flags: bus master, stepping, medium devsel, latency 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at b800 [size=16]
	Capabilities: <available only to root>

00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at b400 [size=32]
	Capabilities: <available only to root>

00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at b000 [size=32]
	Capabilities: <available only to root>

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Flags: medium devsel
	Capabilities: <available only to root>

00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
	Flags: bus master, medium devsel, latency 32, IRQ 12
	Memory at de800000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 9400 [size=64]
	Memory at de000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: <available only to root>

00:11.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 0d30 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at 9000 [size=8]
	I/O ports at 8800 [size=4]
	I/O ports at 8400 [size=8]
	I/O ports at 8000 [size=4]
	I/O ports at 7800 [size=64]
	Memory at dd800000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 11
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	I/O ports at d800 [size=256]
	Memory at df000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at dffe0000 [disabled] [size=128K]
	Capabilities: <available only to root>


--------------6C3843C124DF3FFDD21EAB27
Content-Type: text/plain; charset=us-ascii;
 name="hda1.bb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hda1.bb.txt"

Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          48328708-e7c4-11d4-9b46-bb9e88b57fde
Filesystem magic number:  0xEF53
Filesystem revision #:    0 (original)
Filesystem features:     (none)
Filesystem state:         not clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              263160
Block count:              1052226
Reserved block count:     52611
Free blocks:              938846
Free inodes:              254355
First block:              1
Block size:               1024
Fragment size:            1024
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         2040
Inode blocks per group:   255
Last mount time:          Wed Jan 31 15:06:09 2001
Last write time:          Wed Jan 31 17:49:11 2001
Mount count:              2
Maximum mount count:      20
Last checked:             Wed Jan 31 14:55:27 2001
Check interval:           15552000 (6 months)
Next check after:         Mon Jul 30 15:55:27 2001
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
Bad blocks: 327695, 327696, 467234, 475152, 475153, 483636

Group 0: (Blocks 1 -- 8192)
  Block bitmap at 7 (+6), Inode bitmap at 8 (+7)
  Inode table at 9 (+8)
  6998 free blocks, 2028 free inodes, 2 directories
  Free blocks: 277-278, 331-336, 340-344, 346-351, 390-398, 541-547, 549-556, 617-641, 745, 747, 845-847, 901-908, 914-921, 926-933, 938-953, 956-963, 965-972, 975-982, 987-994, 998-1013, 1016-1031, 1034-1049, 1057-1064, 1101-1106, 1109, 1111-1118, 1121-1124, 1127-1142, 1145-1152, 1154-1161, 1163-1170, 1200-1207, 1209-1216, 1218-1225, 1227-1234, 1236-1243, 1245-1260, 1265-1272, 1274-1281, 1283-1290, 1292-1299, 1301-1308, 1311-1318, 1320-1327, 1329-1336, 1338-1345, 1347-1354, 1356-1363, 1365-1380, 1382-1389, 1391-1398, 1400-1439, 1441-1448, 1450-1489, 1503-1557, 1565-1620, 1675-1682, 1684-1691, 1693-1708, 1712-1727, 1729-1736, 1739-1746, 1749-1756, 1760-1767, 1769-1776, 1778-1785, 1787-1794, 1796-1803, 1806-1813, 1818-1825, 1827-1842, 1845-1860, 1864-1879, 1882-1897, 1899-1906, 1908-1915, 1917-1924, 1926-1933, 1935-1942, 1944-1983, 2065-2093, 2095-2110, 2113-2166, 2201-8192
  Free inodes: 12-13, 15-2040
Group 1: (Blocks 8193 -- 16384)
  Block bitmap at 8199 (+6), Inode bitmap at 8200 (+7)
  Inode table at 8201 (+8)
  7875 free blocks, 2027 free inodes, 6 directories
  Free blocks: 8456-8457, 8461, 8512-8520, 8522-16384
  Free inodes: 2041, 2043, 2052, 2057-4080
Group 2: (Blocks 16385 -- 24576)
  Block bitmap at 16391 (+6), Inode bitmap at 16392 (+7)
  Inode table at 16393 (+8)
  7901 free blocks, 2035 free inodes, 3 directories
  Free blocks: 16676-24576
  Free inodes: 4086-6120
Group 3: (Blocks 24577 -- 32768)
  Block bitmap at 24583 (+6), Inode bitmap at 24584 (+7)
  Inode table at 24585 (+8)
  7894 free blocks, 2030 free inodes, 2 directories
  Free blocks: 24840-24843, 24879-32768
  Free inodes: 6121-6124, 6135-8160
Group 4: (Blocks 32769 -- 40960)
  Block bitmap at 32775 (+6), Inode bitmap at 32776 (+7)
  Inode table at 32777 (+8)
  7286 free blocks, 1989 free inodes, 5 directories
  Free blocks: 33032-33034, 33042-33051, 33688-40960
  Free inodes: 8212-10200
Group 5: (Blocks 40961 -- 49152)
  Block bitmap at 40967 (+6), Inode bitmap at 40968 (+7)
  Inode table at 40969 (+8)
  2314 free blocks, 1947 free inodes, 4 directories
  Free blocks: 41224-41226, 42649-42658, 46852-49152
  Free inodes: 10203, 10236-10237, 10297-12240
Group 6: (Blocks 49153 -- 57344)
  Block bitmap at 49159 (+6), Inode bitmap at 49160 (+7)
  Inode table at 49161 (+8)
  50 free blocks, 2014 free inodes, 3 directories
  Free blocks: 57295-57344
  Free inodes: 12259, 12265, 12269-14280
Group 7: (Blocks 57345 -- 65536)
  Block bitmap at 57351 (+6), Inode bitmap at 57352 (+7)
  Inode table at 57353 (+8)
  7516 free blocks, 2032 free inodes, 2 directories
  Free blocks: 57616-57985, 57998-58017, 58411-65536
  Free inodes: 14289-16320
Group 8: (Blocks 65537 -- 73728)
  Block bitmap at 65543 (+6), Inode bitmap at 65544 (+7)
  Inode table at 65545 (+8)
  7458 free blocks, 1999 free inodes, 8 directories
  Free blocks: 66271-73728
  Free inodes: 16362-18360
Group 9: (Blocks 73729 -- 81920)
  Block bitmap at 73735 (+6), Inode bitmap at 73736 (+7)
  Inode table at 73737 (+8)
  7896 free blocks, 0 free inodes, 1 directories
  Free blocks: 74025-81920
  Free inodes: 
Group 10: (Blocks 81921 -- 90112)
  Block bitmap at 81927 (+6), Inode bitmap at 81928 (+7)
  Inode table at 81929 (+8)
  7915 free blocks, 1014 free inodes, 1 directories
  Free blocks: 82198-90112
  Free inodes: 21427-22440
Group 11: (Blocks 90113 -- 98304)
  Block bitmap at 90119 (+6), Inode bitmap at 90120 (+7)
  Inode table at 90121 (+8)
  7636 free blocks, 2026 free inodes, 3 directories
  Free blocks: 90380, 90669-90679, 90681-98304
  Free inodes: 22455-24480
Group 12: (Blocks 98305 -- 106496)
  Block bitmap at 98311 (+6), Inode bitmap at 98312 (+7)
  Inode table at 98313 (+8)
  7896 free blocks, 0 free inodes, 1 directories
  Free blocks: 98601-106496
  Free inodes: 
Group 13: (Blocks 106497 -- 114688)
  Block bitmap at 106503 (+6), Inode bitmap at 106504 (+7)
  Inode table at 106505 (+8)
  7925 free blocks, 1775 free inodes, 1 directories
  Free blocks: 106764-114688
  Free inodes: 26786-28560
Group 14: (Blocks 114689 -- 122880)
  Block bitmap at 114695 (+6), Inode bitmap at 114696 (+7)
  Inode table at 114697 (+8)
  7902 free blocks, 2018 free inodes, 5 directories
  Free blocks: 114954-114966, 114968-114969, 114971, 114976-115012, 115032-122880
  Free inodes: 28581, 28583-28590, 28592-30600
Group 15: (Blocks 122881 -- 131072)
  Block bitmap at 122887 (+6), Inode bitmap at 122888 (+7)
  Inode table at 122889 (+8)
  7899 free blocks, 2020 free inodes, 4 directories
  Free blocks: 123144-123145, 123176-131072
  Free inodes: 30601-30602, 30604, 30624-32640
Group 16: (Blocks 131073 -- 139264)
  Block bitmap at 131079 (+6), Inode bitmap at 131080 (+7)
  Inode table at 131081 (+8)
  6490 free blocks, 1904 free inodes, 1 directories
  Free blocks: 131339, 131343, 131383-131386, 132030, 132114, 132117-132118, 132120-132121, 132123-132126, 132243, 132772, 132774, 132776-132777, 132779-132783, 132785-132798, 132804-132806, 132815-132824, 132828-139264
  Free inodes: 32697, 32776, 32778-32779, 32781-34680
Group 17: (Blocks 139265 -- 147456)
  Block bitmap at 139271 (+6), Inode bitmap at 139272 (+7)
  Inode table at 139273 (+8)
  7897 free blocks, 2022 free inodes, 1 directories
  Free blocks: 139546-139582, 139597-147456
  Free inodes: 34698-34704, 34706-36720
Group 18: (Blocks 147457 -- 155648)
  Block bitmap at 147463 (+6), Inode bitmap at 147464 (+7)
  Inode table at 147465 (+8)
  7889 free blocks, 2033 free inodes, 1 directories
  Free blocks: 147722-147727, 147730-147738, 147756-147795, 147815-155648
  Free inodes: 36727-36733, 36735-38760
Group 19: (Blocks 155649 -- 163840)
  Block bitmap at 155655 (+6), Inode bitmap at 155656 (+7)
  Inode table at 155657 (+8)
  7892 free blocks, 2018 free inodes, 4 directories
  Free blocks: 155931-155967, 155986-163840
  Free inodes: 38782-38788, 38790-40800
Group 20: (Blocks 163841 -- 172032)
  Block bitmap at 163847 (+6), Inode bitmap at 163848 (+7)
  Inode table at 163849 (+8)
  7782 free blocks, 2019 free inodes, 3 directories
  Free blocks: 164251-172032
  Free inodes: 40822-42840
Group 21: (Blocks 172033 -- 180224)
  Block bitmap at 172039 (+6), Inode bitmap at 172040 (+7)
  Inode table at 172041 (+8)
  7842 free blocks, 2024 free inodes, 1 directories
  Free blocks: 172383-180224
  Free inodes: 42857-44880
Group 22: (Blocks 180225 -- 188416)
  Block bitmap at 180231 (+6), Inode bitmap at 180232 (+7)
  Inode table at 180233 (+8)
  5464 free blocks, 1877 free inodes, 3 directories
  Free blocks: 182255-182295, 182828-187447, 187466-187531, 187680-188416
  Free inodes: 44967, 44994, 44996, 44998, 45007, 45020-45022, 45024-45025, 45034-45035, 45037-45039, 45042, 45060-46920
Group 23: (Blocks 188417 -- 196608)
  Block bitmap at 188423 (+6), Inode bitmap at 188424 (+7)
  Inode table at 188425 (+8)
  2236 free blocks, 2037 free inodes, 1 directories
  Free blocks: 188691-189904, 191084-191392, 191463-192128, 192343-192389
  Free inodes: 46924-48960
Group 24: (Blocks 196609 -- 204800)
  Block bitmap at 196615 (+6), Inode bitmap at 196616 (+7)
  Inode table at 196617 (+8)
  3721 free blocks, 1994 free inodes, 5 directories
  Free blocks: 201080-204800
  Free inodes: 48964-48969, 49013-51000
Group 25: (Blocks 204801 -- 212992)
  Block bitmap at 204807 (+6), Inode bitmap at 204808 (+7)
  Inode table at 204809 (+8)
  6432 free blocks, 1990 free inodes, 3 directories
  Free blocks: 206561-212992
  Free inodes: 51051-53040
Group 26: (Blocks 212993 -- 221184)
  Block bitmap at 212999 (+6), Inode bitmap at 213000 (+7)
  Inode table at 213001 (+8)
  7898 free blocks, 2031 free inodes, 2 directories
  Free blocks: 213287-221184
  Free inodes: 53050-55080
Group 27: (Blocks 221185 -- 229376)
  Block bitmap at 221191 (+6), Inode bitmap at 221192 (+7)
  Inode table at 221193 (+8)
  7880 free blocks, 2017 free inodes, 5 directories
  Free blocks: 221450, 221496-221514, 221517-229376
  Free inodes: 55087-55088, 55091-55094, 55106, 55111-57120
Group 28: (Blocks 229377 -- 237568)
  Block bitmap at 229383 (+6), Inode bitmap at 229384 (+7)
  Inode table at 229385 (+8)
  7879 free blocks, 2020 free inodes, 5 directories
  Free blocks: 229642, 229691-237568
  Free inodes: 57124, 57126-57127, 57129-57148, 57160, 57165-59160
Group 29: (Blocks 237569 -- 245760)
  Block bitmap at 237575 (+6), Inode bitmap at 237576 (+7)
  Inode table at 237577 (+8)
  7869 free blocks, 2018 free inodes, 6 directories
  Free blocks: 237892-245760
  Free inodes: 59183-61200
Group 30: (Blocks 245761 -- 253952)
  Block bitmap at 245767 (+6), Inode bitmap at 245768 (+7)
  Inode table at 245769 (+8)
  2782 free blocks, 1882 free inodes, 2 directories
  Free blocks: 247445-247451, 250990, 251167-251173, 251186-253952
  Free inodes: 61359-63240
Group 31: (Blocks 253953 -- 262144)
  Block bitmap at 253959 (+6), Inode bitmap at 253960 (+7)
  Inode table at 253961 (+8)
  7894 free blocks, 2033 free inodes, 3 directories
  Free blocks: 254219-254223, 254241-254286, 254302-262144
  Free inodes: 63247-63253, 63255-65280
Group 32: (Blocks 262145 -- 270336)
  Block bitmap at 262151 (+6), Inode bitmap at 262152 (+7)
  Inode table at 262153 (+8)
  7897 free blocks, 2018 free inodes, 1 directories
  Free blocks: 262429-262460, 262472-270336
  Free inodes: 65302-65308, 65310-67320
Group 33: (Blocks 270337 -- 278528)
  Block bitmap at 270343 (+6), Inode bitmap at 270344 (+7)
  Inode table at 270345 (+8)
  7903 free blocks, 2023 free inodes, 2 directories
  Free blocks: 270626-278528
  Free inodes: 67338-69360
Group 34: (Blocks 278529 -- 286720)
  Block bitmap at 278535 (+6), Inode bitmap at 278536 (+7)
  Inode table at 278537 (+8)
  6560 free blocks, 2008 free inodes, 2 directories
  Free blocks: 278811-278820, 278850-278863, 280178-280180, 280186-280196, 280198, 280200-286720
  Free inodes: 69392, 69394-71400
Group 35: (Blocks 286721 -- 294912)
  Block bitmap at 286727 (+6), Inode bitmap at 286728 (+7)
  Inode table at 286729 (+8)
  7900 free blocks, 2020 free inodes, 3 directories
  Free blocks: 287003-287032, 287043-294912
  Free inodes: 71418, 71421-71426, 71428-73440
Group 36: (Blocks 294913 -- 303104)
  Block bitmap at 294919 (+6), Inode bitmap at 294920 (+7)
  Inode table at 294921 (+8)
  7888 free blocks, 2028 free inodes, 2 directories
  Free blocks: 295214-295215, 295219-303104
  Free inodes: 73453-75480
Group 37: (Blocks 303105 -- 311296)
  Block bitmap at 303111 (+6), Inode bitmap at 303112 (+7)
  Inode table at 303113 (+8)
  7714 free blocks, 2023 free inodes, 2 directories
  Free blocks: 303372, 303584-311296
  Free inodes: 75498-77520
Group 38: (Blocks 311297 -- 319488)
  Block bitmap at 311303 (+6), Inode bitmap at 311304 (+7)
  Inode table at 311305 (+8)
  7886 free blocks, 2031 free inodes, 3 directories
  Free blocks: 311578-311630, 311656-319488
  Free inodes: 77529-77535, 77537-79560
Group 39: (Blocks 319489 -- 327680)
  Block bitmap at 319495 (+6), Inode bitmap at 319496 (+7)
  Inode table at 319497 (+8)
  7899 free blocks, 2030 free inodes, 5 directories
  Free blocks: 319782-327680
  Free inodes: 79571-81600
Group 40: (Blocks 327681 -- 335872)
  Block bitmap at 327687 (+6), Inode bitmap at 327688 (+7)
  Inode table at 327697 (+16)
  7901 free blocks, 2030 free inodes, 4 directories
  Free blocks: 327689-327694, 327978-335872
  Free inodes: 81611-83640
Group 41: (Blocks 335873 -- 344064)
  Block bitmap at 335879 (+6), Inode bitmap at 335880 (+7)
  Inode table at 335881 (+8)
  7901 free blocks, 2030 free inodes, 1 directories
  Free blocks: 336164-344064
  Free inodes: 83651-85680
Group 42: (Blocks 344065 -- 352256)
  Block bitmap at 344071 (+6), Inode bitmap at 344072 (+7)
  Inode table at 344073 (+8)
  7902 free blocks, 2027 free inodes, 8 directories
  Free blocks: 344329, 344345-344352, 344356-344361, 344370-352256
  Free inodes: 85682, 85691, 85696-87720
Group 43: (Blocks 352257 -- 360448)
  Block bitmap at 352263 (+6), Inode bitmap at 352264 (+7)
  Inode table at 352265 (+8)
  7875 free blocks, 1989 free inodes, 5 directories
  Free blocks: 352574-360448
  Free inodes: 87772-89760
Group 44: (Blocks 360449 -- 368640)
  Block bitmap at 360455 (+6), Inode bitmap at 360456 (+7)
  Inode table at 360457 (+8)
  7895 free blocks, 2037 free inodes, 1 directories
  Free blocks: 360731-360767, 360783-368640
  Free inodes: 89763-89769, 89771-91800
Group 45: (Blocks 368641 -- 376832)
  Block bitmap at 368647 (+6), Inode bitmap at 368648 (+7)
  Inode table at 368649 (+8)
  7901 free blocks, 2034 free inodes, 2 directories
  Free blocks: 368932-376832
  Free inodes: 91807-93840
Group 46: (Blocks 376833 -- 385024)
  Block bitmap at 376839 (+6), Inode bitmap at 376840 (+7)
  Inode table at 376841 (+8)
  7889 free blocks, 2021 free inodes, 4 directories
  Free blocks: 377136-385024
  Free inodes: 93860-95880
Group 47: (Blocks 385025 -- 393216)
  Block bitmap at 385031 (+6), Inode bitmap at 385032 (+7)
  Inode table at 385033 (+8)
  7604 free blocks, 1984 free inodes, 1 directories
  Free blocks: 385613-393216
  Free inodes: 95937-97920
Group 48: (Blocks 393217 -- 401408)
  Block bitmap at 393223 (+6), Inode bitmap at 393224 (+7)
  Inode table at 393225 (+8)
  7894 free blocks, 2021 free inodes, 6 directories
  Free blocks: 393492-393496, 393514-393524, 393526, 393532-401408
  Free inodes: 97938, 97941-99960
Group 49: (Blocks 401409 -- 409600)
  Block bitmap at 401415 (+6), Inode bitmap at 401416 (+7)
  Inode table at 401417 (+8)
  7626 free blocks, 1978 free inodes, 5 directories
  Free blocks: 401975-409600
  Free inodes: 100023-102000
Group 50: (Blocks 409601 -- 417792)
  Block bitmap at 409607 (+6), Inode bitmap at 409608 (+7)
  Inode table at 409609 (+8)
  7871 free blocks, 2035 free inodes, 2 directories
  Free blocks: 409882-409940, 409981-417792
  Free inodes: 102005-102011, 102013-104040
Group 51: (Blocks 417793 -- 425984)
  Block bitmap at 417799 (+6), Inode bitmap at 417800 (+7)
  Inode table at 417801 (+8)
  7834 free blocks, 2029 free inodes, 2 directories
  Free blocks: 418151-425984
  Free inodes: 104052-106080
Group 52: (Blocks 425985 -- 434176)
  Block bitmap at 425991 (+6), Inode bitmap at 425992 (+7)
  Inode table at 425993 (+8)
  7889 free blocks, 2029 free inodes, 4 directories
  Free blocks: 426277-426292, 426304-434176
  Free inodes: 106091-106097, 106099-108120
Group 53: (Blocks 434177 -- 442368)
  Block bitmap at 434183 (+6), Inode bitmap at 434184 (+7)
  Inode table at 434185 (+8)
  7899 free blocks, 2029 free inodes, 3 directories
  Free blocks: 434456, 434471-442368
  Free inodes: 108128, 108133-110160
Group 54: (Blocks 442369 -- 450560)
  Block bitmap at 442375 (+6), Inode bitmap at 442376 (+7)
  Inode table at 442377 (+8)
  7897 free blocks, 2032 free inodes, 3 directories
  Free blocks: 442633-442635, 442667-450560
  Free inodes: 110169-112200
Group 55: (Blocks 450561 -- 458752)
  Block bitmap at 450567 (+6), Inode bitmap at 450568 (+7)
  Inode table at 450569 (+8)
  7892 free blocks, 2034 free inodes, 1 directories
  Free blocks: 450847-450881, 450896-458752
  Free inodes: 112206-112212, 112214-114240
Group 56: (Blocks 458753 -- 466944)
  Block bitmap at 458759 (+6), Inode bitmap at 458760 (+7)
  Inode table at 458761 (+8)
  7799 free blocks, 1983 free inodes, 1 directories
  Free blocks: 459055-459057, 459123-459126, 459153-466944
  Free inodes: 114298-116280
Group 57: (Blocks 466945 -- 475136)
  Block bitmap at 466951 (+6), Inode bitmap at 466952 (+7)
  Inode table at 466953 (+8)
  7901 free blocks, 1973 free inodes, 9 directories
  Free blocks: 467209, 467223-467231, 467233, 467247-475136
  Free inodes: 116348-118320
Group 58: (Blocks 475137 -- 483328)
  Block bitmap at 475143 (+6), Inode bitmap at 475144 (+7)
  Inode table at 475145 (+8)
  7266 free blocks, 1930 free inodes, 7 directories
  Free blocks: 475736-475742, 476057-476074, 476088-483328
  Free inodes: 118415, 118432-120360
Group 59: (Blocks 483329 -- 491520)
  Block bitmap at 483335 (+6), Inode bitmap at 483336 (+7)
  Inode table at 483337 (+8)
  7878 free blocks, 1974 free inodes, 4 directories
  Free blocks: 483595-483601, 483635, 483651-491520
  Free inodes: 120427-122400
Group 60: (Blocks 491521 -- 499712)
  Block bitmap at 491527 (+6), Inode bitmap at 491528 (+7)
  Inode table at 491529 (+8)
  7881 free blocks, 1974 free inodes, 5 directories
  Free blocks: 491786, 491833-499712
  Free inodes: 122467-124440
Group 61: (Blocks 499713 -- 507904)
  Block bitmap at 499719 (+6), Inode bitmap at 499720 (+7)
  Inode table at 499721 (+8)
  0 free blocks, 1987 free inodes, 2 directories
  Free blocks: 
  Free inodes: 124494-126480
Group 62: (Blocks 507905 -- 516096)
  Block bitmap at 507911 (+6), Inode bitmap at 507912 (+7)
  Inode table at 507913 (+8)
  0 free blocks, 1992 free inodes, 1 directories
  Free blocks: 
  Free inodes: 126529-128520
Group 63: (Blocks 516097 -- 524288)
  Block bitmap at 516103 (+6), Inode bitmap at 516104 (+7)
  Inode table at 516105 (+8)
  4190 free blocks, 1992 free inodes, 1 directories
  Free blocks: 519746-519752, 520106-524288
  Free inodes: 128569-130560
Group 64: (Blocks 524289 -- 532480)
  Block bitmap at 524295 (+6), Inode bitmap at 524296 (+7)
  Inode table at 524297 (+8)
  7886 free blocks, 2027 free inodes, 1 directories
  Free blocks: 524564-524565, 524567-524576, 524579-524632, 524661-532480
  Free inodes: 130573-130582, 130584-132600
Group 65: (Blocks 532481 -- 540672)
  Block bitmap at 532487 (+6), Inode bitmap at 532488 (+7)
  Inode table at 532489 (+8)
  7874 free blocks, 2036 free inodes, 2 directories
  Free blocks: 532762-532824, 532862-540672
  Free inodes: 132604-132610, 132612-134640
Group 66: (Blocks 540673 -- 548864)
  Block bitmap at 540679 (+6), Inode bitmap at 540680 (+7)
  Inode table at 540681 (+8)
  7893 free blocks, 2024 free inodes, 1 directories
  Free blocks: 540972-548864
  Free inodes: 134657-136680
Group 67: (Blocks 548865 -- 557056)
  Block bitmap at 548871 (+6), Inode bitmap at 548872 (+7)
  Inode table at 548873 (+8)
  7872 free blocks, 2031 free inodes, 4 directories
  Free blocks: 549185-557056
  Free inodes: 136690-138720
Group 68: (Blocks 557057 -- 565248)
  Block bitmap at 557063 (+6), Inode bitmap at 557064 (+7)
  Inode table at 557065 (+8)
  7867 free blocks, 1969 free inodes, 4 directories
  Free blocks: 557323, 557333, 557378-557379, 557382-557383, 557386-557397, 557400-565248
  Free inodes: 138790, 138793-140760
Group 69: (Blocks 565249 -- 573440)
  Block bitmap at 565255 (+6), Inode bitmap at 565256 (+7)
  Inode table at 565257 (+8)
  7892 free blocks, 2024 free inodes, 8 directories
  Free blocks: 565517-565518, 565531-565538, 565542, 565551-565570, 565580-573440
  Free inodes: 140769, 140777-140780, 140782-142800
Group 70: (Blocks 573441 -- 581632)
  Block bitmap at 573447 (+6), Inode bitmap at 573448 (+7)
  Inode table at 573449 (+8)
  7901 free blocks, 2029 free inodes, 1 directories
  Free blocks: 573713-573718, 573720-573764, 573783-581632
  Free inodes: 142811-142824, 142826-144840
Group 71: (Blocks 581633 -- 589824)
  Block bitmap at 581639 (+6), Inode bitmap at 581640 (+7)
  Inode table at 581641 (+8)
  7886 free blocks, 2028 free inodes, 8 directories
  Free blocks: 581918-581919, 581921-581961, 581982-589824
  Free inodes: 144851-144852, 144854-144858, 144860-146880
Group 72: (Blocks 589825 -- 598016)
  Block bitmap at 589831 (+6), Inode bitmap at 589832 (+7)
  Inode table at 589833 (+8)
  7872 free blocks, 2031 free inodes, 6 directories
  Free blocks: 590145-598016
  Free inodes: 146890-148920
Group 73: (Blocks 598017 -- 606208)
  Block bitmap at 598023 (+6), Inode bitmap at 598024 (+7)
  Inode table at 598025 (+8)
  7898 free blocks, 2031 free inodes, 4 directories
  Free blocks: 598301-598320, 598331-606208
  Free inodes: 148929-148935, 148937-150960
Group 74: (Blocks 606209 -- 614400)
  Block bitmap at 606215 (+6), Inode bitmap at 606216 (+7)
  Inode table at 606217 (+8)
  7903 free blocks, 2026 free inodes, 7 directories
  Free blocks: 606487-606492, 606496-606520, 606529-614400
  Free inodes: 150972, 150974, 150976-150982, 150984-153000
Group 75: (Blocks 614401 -- 622592)
  Block bitmap at 614407 (+6), Inode bitmap at 614408 (+7)
  Inode table at 614409 (+8)
  7900 free blocks, 2025 free inodes, 4 directories
  Free blocks: 614676-614681, 614690-614718, 614728-622592
  Free inodes: 153015-153021, 153023-155040
Group 76: (Blocks 622593 -- 630784)
  Block bitmap at 622599 (+6), Inode bitmap at 622600 (+7)
  Inode table at 622601 (+8)
  7897 free blocks, 2027 free inodes, 3 directories
  Free blocks: 622868-622879, 622884-622915, 622932-630784
  Free inodes: 155050, 155054-155059, 155061-157080
Group 77: (Blocks 630785 -- 638976)
  Block bitmap at 630791 (+6), Inode bitmap at 630792 (+7)
  Inode table at 630793 (+8)
  7889 free blocks, 2021 free inodes, 6 directories
  Free blocks: 631063-631111, 631137-638976
  Free inodes: 157099-157108, 157110-159120
Group 78: (Blocks 638977 -- 647168)
  Block bitmap at 638983 (+6), Inode bitmap at 638984 (+7)
  Inode table at 638985 (+8)
  7902 free blocks, 2026 free inodes, 6 directories
  Free blocks: 639267-647168
  Free inodes: 159135-161160
Group 79: (Blocks 647169 -- 655360)
  Block bitmap at 647175 (+6), Inode bitmap at 647176 (+7)
  Inode table at 647177 (+8)
  7656 free blocks, 2022 free inodes, 7 directories
  Free blocks: 647705-655360
  Free inodes: 161179-163200
Group 80: (Blocks 655361 -- 663552)
  Block bitmap at 655367 (+6), Inode bitmap at 655368 (+7)
  Inode table at 655369 (+8)
  6627 free blocks, 2037 free inodes, 2 directories
  Free blocks: 656686-657765, 657787-657997, 658217-663552
  Free inodes: 163204-165240
Group 81: (Blocks 663553 -- 671744)
  Block bitmap at 663559 (+6), Inode bitmap at 663560 (+7)
  Inode table at 663561 (+8)
  6612 free blocks, 1981 free inodes, 6 directories
  Free blocks: 665133-671744
  Free inodes: 165300-167280
Group 82: (Blocks 671745 -- 679936)
  Block bitmap at 671751 (+6), Inode bitmap at 671752 (+7)
  Inode table at 671753 (+8)
  7894 free blocks, 2035 free inodes, 2 directories
  Free blocks: 672028-672064, 672080-679936
  Free inodes: 167285-167294, 167296-169320
Group 83: (Blocks 679937 -- 688128)
  Block bitmap at 679943 (+6), Inode bitmap at 679944 (+7)
  Inode table at 679945 (+8)
  7833 free blocks, 2011 free inodes, 3 directories
  Free blocks: 680296-688128
  Free inodes: 169350-171360
Group 84: (Blocks 688129 -- 696320)
  Block bitmap at 688135 (+6), Inode bitmap at 688136 (+7)
  Inode table at 688137 (+8)
  7896 free blocks, 2025 free inodes, 8 directories
  Free blocks: 688398, 688401-688407, 688411-688436, 688444-688457, 688473-696320
  Free inodes: 171373-171380, 171382-171383, 171385-171387, 171389-173400
Group 85: (Blocks 696321 -- 704512)
  Block bitmap at 696327 (+6), Inode bitmap at 696328 (+7)
  Inode table at 696329 (+8)
  7903 free blocks, 2029 free inodes, 3 directories
  Free blocks: 696599-696630, 696642-704512
  Free inodes: 173411-173421, 173423-175440
Group 86: (Blocks 704513 -- 712704)
  Block bitmap at 704519 (+6), Inode bitmap at 704520 (+7)
  Inode table at 704521 (+8)
  7902 free blocks, 2028 free inodes, 3 directories
  Free blocks: 704795-704801, 704809-705104, 705106-712704
  Free inodes: 175452, 175454-177480
Group 87: (Blocks 712705 -- 720896)
  Block bitmap at 712711 (+6), Inode bitmap at 712712 (+7)
  Inode table at 712713 (+8)
  3348 free blocks, 1846 free inodes, 2 directories
  Free blocks: 717549-720896
  Free inodes: 177675-179520
Group 88: (Blocks 720897 -- 729088)
  Block bitmap at 720903 (+6), Inode bitmap at 720904 (+7)
  Inode table at 720905 (+8)
  5715 free blocks, 1933 free inodes, 7 directories
  Free blocks: 723374-729088
  Free inodes: 179628-181560
Group 89: (Blocks 729089 -- 737280)
  Block bitmap at 729095 (+6), Inode bitmap at 729096 (+7)
  Inode table at 729097 (+8)
  7902 free blocks, 2007 free inodes, 11 directories
  Free blocks: 729377-729468, 729471-737280
  Free inodes: 181594-183600
Group 90: (Blocks 737281 -- 745472)
  Block bitmap at 737287 (+6), Inode bitmap at 737288 (+7)
  Inode table at 737289 (+8)
  7211 free blocks, 1999 free inodes, 5 directories
  Free blocks: 737546, 737548, 738262-738268, 738271-745472
  Free inodes: 183642-185640
Group 91: (Blocks 745473 -- 753664)
  Block bitmap at 745479 (+6), Inode bitmap at 745480 (+7)
  Inode table at 745481 (+8)
  7865 free blocks, 2028 free inodes, 2 directories
  Free blocks: 745800-753664
  Free inodes: 185653-187680
Group 92: (Blocks 753665 -- 761856)
  Block bitmap at 753671 (+6), Inode bitmap at 753672 (+7)
  Inode table at 753673 (+8)
  6362 free blocks, 1981 free inodes, 6 directories
  Free blocks: 755495-761856
  Free inodes: 187740-189720
Group 93: (Blocks 761857 -- 770048)
  Block bitmap at 761863 (+6), Inode bitmap at 761864 (+7)
  Inode table at 761865 (+8)
  7897 free blocks, 2023 free inodes, 8 directories
  Free blocks: 762140-762170, 762183-770048
  Free inodes: 189737-189743, 189745-191760
Group 94: (Blocks 770049 -- 778240)
  Block bitmap at 770055 (+6), Inode bitmap at 770056 (+7)
  Inode table at 770057 (+8)
  7867 free blocks, 2025 free inodes, 7 directories
  Free blocks: 770374-778240
  Free inodes: 191776-193800
Group 95: (Blocks 778241 -- 786432)
  Block bitmap at 778247 (+6), Inode bitmap at 778248 (+7)
  Inode table at 778249 (+8)
  7860 free blocks, 2031 free inodes, 4 directories
  Free blocks: 778573-786432
  Free inodes: 193810-195840
Group 96: (Blocks 786433 -- 794624)
  Block bitmap at 786439 (+6), Inode bitmap at 786440 (+7)
  Inode table at 786441 (+8)
  7866 free blocks, 2028 free inodes, 2 directories
  Free blocks: 786759-794624
  Free inodes: 195853-197880
Group 97: (Blocks 794625 -- 802816)
  Block bitmap at 794631 (+6), Inode bitmap at 794632 (+7)
  Inode table at 794633 (+8)
  7666 free blocks, 2010 free inodes, 7 directories
  Free blocks: 794892, 794896-794899, 794901-794903, 794906-794919, 795107-795113, 795131-795137, 795172-795178, 795190-795192, 795197-802816
  Free inodes: 197895-197896, 197903, 197914-199920
Group 98: (Blocks 802817 -- 811008)
  Block bitmap at 802823 (+6), Inode bitmap at 802824 (+7)
  Inode table at 802825 (+8)
  7871 free blocks, 2025 free inodes, 1 directories
  Free blocks: 803138-811008
  Free inodes: 199936-201960
Group 99: (Blocks 811009 -- 819200)
  Block bitmap at 811015 (+6), Inode bitmap at 811016 (+7)
  Inode table at 811017 (+8)
  7896 free blocks, 2024 free inodes, 3 directories
  Free blocks: 811305-819200
  Free inodes: 201977-204000
Group 100: (Blocks 819201 -- 827392)
  Block bitmap at 819207 (+6), Inode bitmap at 819208 (+7)
  Inode table at 819209 (+8)
  7897 free blocks, 2008 free inodes, 1 directories
  Free blocks: 819465, 819487, 819494, 819499-827392
  Free inodes: 204033-206040
Group 101: (Blocks 827393 -- 835584)
  Block bitmap at 827399 (+6), Inode bitmap at 827400 (+7)
  Inode table at 827401 (+8)
  7877 free blocks, 2031 free inodes, 2 directories
  Free blocks: 827659-827671, 827721-835584
  Free inodes: 206050-208080
Group 102: (Blocks 835585 -- 843776)
  Block bitmap at 835591 (+6), Inode bitmap at 835592 (+7)
  Inode table at 835593 (+8)
  7828 free blocks, 2024 free inodes, 2 directories
  Free blocks: 835949-843776
  Free inodes: 208097-210120
Group 103: (Blocks 843777 -- 851968)
  Block bitmap at 843783 (+6), Inode bitmap at 843784 (+7)
  Inode table at 843785 (+8)
  7902 free blocks, 2017 free inodes, 9 directories
  Free blocks: 844053, 844068-851968
  Free inodes: 210143, 210145-212160
Group 104: (Blocks 851969 -- 860160)
  Block bitmap at 851975 (+6), Inode bitmap at 851976 (+7)
  Inode table at 851977 (+8)
  7759 free blocks, 2019 free inodes, 5 directories
  Free blocks: 852236, 852403-860160
  Free inodes: 212182-214200
Group 105: (Blocks 860161 -- 868352)
  Block bitmap at 860167 (+6), Inode bitmap at 860168 (+7)
  Inode table at 860169 (+8)
  7894 free blocks, 2029 free inodes, 1 directories
  Free blocks: 860443-860455, 860460-860491, 860504-868352
  Free inodes: 214211-214217, 214219-216240
Group 106: (Blocks 868353 -- 876544)
  Block bitmap at 868359 (+6), Inode bitmap at 868360 (+7)
  Inode table at 868361 (+8)
  7899 free blocks, 2027 free inodes, 3 directories
  Free blocks: 868635-868667, 868679-876544
  Free inodes: 216253-216259, 216261-218280
Group 107: (Blocks 876545 -- 884736)
  Block bitmap at 876551 (+6), Inode bitmap at 876552 (+7)
  Inode table at 876553 (+8)
  7791 free blocks, 2034 free inodes, 1 directories
  Free blocks: 876946-884736
  Free inodes: 218287-220320
Group 108: (Blocks 884737 -- 892928)
  Block bitmap at 884743 (+6), Inode bitmap at 884744 (+7)
  Inode table at 884745 (+8)
  7769 free blocks, 2016 free inodes, 1 directories
  Free blocks: 885160-892928
  Free inodes: 220345-222360
Group 109: (Blocks 892929 -- 901120)
  Block bitmap at 892935 (+6), Inode bitmap at 892936 (+7)
  Inode table at 892937 (+8)
  5122 free blocks, 1992 free inodes, 2 directories
  Free blocks: 894041-894043, 894059-894071, 894096-894102, 894112-894118, 894138-894143, 894279-894285, 894341-894344, 894372-894376, 894397-894403, 894562-894563, 894573-894579, 896059-896075, 896084-901120
  Free inodes: 222391, 222410-224400
Group 110: (Blocks 901121 -- 909312)
  Block bitmap at 901127 (+6), Inode bitmap at 901128 (+7)
  Inode table at 901129 (+8)
  7893 free blocks, 2004 free inodes, 1 directories
  Free blocks: 901420-909312
  Free inodes: 224437-226440
Group 111: (Blocks 909313 -- 917504)
  Block bitmap at 909319 (+6), Inode bitmap at 909320 (+7)
  Inode table at 909321 (+8)
  7885 free blocks, 2024 free inodes, 7 directories
  Free blocks: 909581-909582, 909610-909621, 909634-917504
  Free inodes: 226457-228480
Group 112: (Blocks 917505 -- 925696)
  Block bitmap at 917511 (+6), Inode bitmap at 917512 (+7)
  Inode table at 917513 (+8)
  7656 free blocks, 2013 free inodes, 6 directories
  Free blocks: 917772, 918042-925696
  Free inodes: 228508-230520
Group 113: (Blocks 925697 -- 933888)
  Block bitmap at 925703 (+6), Inode bitmap at 925704 (+7)
  Inode table at 925705 (+8)
  7886 free blocks, 2027 free inodes, 4 directories
  Free blocks: 925982-926019, 926041-933888
  Free inodes: 230533-230539, 230541-232560
Group 114: (Blocks 933889 -- 942080)
  Block bitmap at 933895 (+6), Inode bitmap at 933896 (+7)
  Inode table at 933897 (+8)
  7884 free blocks, 2020 free inodes, 1 directories
  Free blocks: 934197-942080
  Free inodes: 232581-234600
Group 115: (Blocks 942081 -- 950272)
  Block bitmap at 942087 (+6), Inode bitmap at 942088 (+7)
  Inode table at 942089 (+8)
  7904 free blocks, 1994 free inodes, 2 directories
  Free blocks: 942369-950272
  Free inodes: 234647-236640
Group 116: (Blocks 950273 -- 958464)
  Block bitmap at 950279 (+6), Inode bitmap at 950280 (+7)
  Inode table at 950281 (+8)
  7563 free blocks, 2024 free inodes, 2 directories
  Free blocks: 950902-958464
  Free inodes: 236657-238680
Group 117: (Blocks 958465 -- 966656)
  Block bitmap at 958471 (+6), Inode bitmap at 958472 (+7)
  Inode table at 958473 (+8)
  7898 free blocks, 2032 free inodes, 1 directories
  Free blocks: 958759-966656
  Free inodes: 238689-240720
Group 118: (Blocks 966657 -- 974848)
  Block bitmap at 966663 (+6), Inode bitmap at 966664 (+7)
  Inode table at 966665 (+8)
  7901 free blocks, 2014 free inodes, 1 directories
  Free blocks: 966948-974848
  Free inodes: 240747-242760
Group 119: (Blocks 974849 -- 983040)
  Block bitmap at 974855 (+6), Inode bitmap at 974856 (+7)
  Inode table at 974857 (+8)
  7845 free blocks, 2034 free inodes, 1 directories
  Free blocks: 975196-983040
  Free inodes: 242767-244800
Group 120: (Blocks 983041 -- 991232)
  Block bitmap at 983047 (+6), Inode bitmap at 983048 (+7)
  Inode table at 983049 (+8)
  7885 free blocks, 2032 free inodes, 1 directories
  Free blocks: 983348-991232
  Free inodes: 244809-246840
Group 121: (Blocks 991233 -- 999424)
  Block bitmap at 991239 (+6), Inode bitmap at 991240 (+7)
  Inode table at 991241 (+8)
  7895 free blocks, 2029 free inodes, 1 directories
  Free blocks: 991518-991552, 991565-999424
  Free inodes: 246851-246857, 246859-248880
Group 122: (Blocks 999425 -- 1007616)
  Block bitmap at 999431 (+6), Inode bitmap at 999432 (+7)
  Inode table at 999433 (+8)
  7904 free blocks, 2029 free inodes, 2 directories
  Free blocks: 999713-1007616
  Free inodes: 248892-250920
Group 123: (Blocks 1007617 -- 1015808)
  Block bitmap at 1007623 (+6), Inode bitmap at 1007624 (+7)
  Inode table at 1007625 (+8)
  7868 free blocks, 2035 free inodes, 2 directories
  Free blocks: 1007941-1015808
  Free inodes: 250926-252960
Group 124: (Blocks 1015809 -- 1024000)
  Block bitmap at 1015815 (+6), Inode bitmap at 1015816 (+7)
  Inode table at 1015817 (+8)
  7897 free blocks, 2022 free inodes, 3 directories
  Free blocks: 1016087-1016098, 1016100-1016101, 1016103-1016104, 1016106-1016134, 1016149-1024000
  Free inodes: 252978-252984, 252986-255000
Group 125: (Blocks 1024001 -- 1032192)
  Block bitmap at 1024007 (+6), Inode bitmap at 1024008 (+7)
  Inode table at 1024009 (+8)
  7736 free blocks, 2033 free inodes, 1 directories
  Free blocks: 1024457-1032192
  Free inodes: 255008-257040
Group 126: (Blocks 1032193 -- 1040384)
  Block bitmap at 1032199 (+6), Inode bitmap at 1032200 (+7)
  Inode table at 1032201 (+8)
  7902 free blocks, 2035 free inodes, 1 directories
  Free blocks: 1032483-1040384
  Free inodes: 257046-259080
Group 127: (Blocks 1040385 -- 1048576)
  Block bitmap at 1040391 (+6), Inode bitmap at 1040392 (+7)
  Inode table at 1040393 (+8)
  7899 free blocks, 2036 free inodes, 2 directories
  Free blocks: 1040666-1040695, 1040708-1048576
  Free inodes: 259084-259090, 259092-261120
Group 128: (Blocks 1048577 -- 1052225)
  Block bitmap at 1048583 (+6), Inode bitmap at 1048584 (+7)
  Inode table at 1048585 (+8)
  3386 free blocks, 2040 free inodes, 0 directories
  Free blocks: 1048840-1052225
  Free inodes: 261121-263160

--------------6C3843C124DF3FFDD21EAB27--

