Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbTAWM3k>; Thu, 23 Jan 2003 07:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbTAWM3k>; Thu, 23 Jan 2003 07:29:40 -0500
Received: from angband.namesys.com ([212.16.7.85]:3968 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S264706AbTAWM3Y>; Thu, 23 Jan 2003 07:29:24 -0500
Date: Thu, 23 Jan 2003 15:38:32 +0300
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: ext2 FS corruption with 2.5.59.
Message-ID: <20030123153832.A860@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hello!

    While doing my usual quick tests I pass all my reiserfs patches through,
    I accidentally forgot to mount reiserfs partition and all the tests
    were performed on ext2 instead.
    So I found that first of all fsx (freebsd nfs testing tool)
    breaks if there are parallel writers (no matter if they write to this
    same partition or not). i_blocks value becomes negative on truncate
    (and then it is written to disk). fsx log attached.
    Also subsequent fsck found lots of other corruptions.
    (previously fs was checked and no corruptions were found).
    Excerpts from e2fsck output are attached.

    My test consists of running "fsx -c 1234 testfile", "iozone -a",
    "dbench 60", "fsstress -p10 -n1000000 -d ." at the same time on the
    tested FS.
    fsx usually breaks just when dbench is finished.

    Host is dual athlon 1700+, 1G RAM, SMP kernel, Highmem support, no preemt.

    I reproduced this behaviour on vanilla 2.5.59. (and It is easily
    reproducable) 

    "..." symbols in fsck output excerpts mean "lots of these".
angband:~ # /sbin/e2fsck -fn /dev/hda1 | wc -l
e2fsck 1.24a (02-Sep-2001)
    520

Bye,
    Oleg

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=fsck

angband:~ # /sbin/e2fsck -f /dev/hda1
e2fsck 1.24a (02-Sep-2001)
Pass 1: Checking inodes, blocks, and sizes
Inode 186022, i_blocks is 4294967256, should be 40.  Fix<y>?
Pass 2: Checking directory structure
Entry 'l8b' in /mnt/p6/d6 (186106) has an incorrect filetype (was 7, should be 1).
Fix<y>?
Entry 'd7a' in /mnt/p6/d6/de/d17/daf/d11e/d228 (186207) is a link to directory /mnt/p6/d6/d1e/???/d3a (186211).
Clear<y>?
Entry 'd2d5' in /mnt/p6/d6/d1e/???/???/dae/??? (187787) has an incorrect filetype (was 2, should be 1).
Fix<y>?
Entry 'd2d5' in /mnt/p6/d6/d1e/???/???/dae/??? (187787) has an incorrect filetype (was 2, should be 1).
Fix<y>? yes

Entry 'c3e2' in /mnt/p6/d6/d1e/???/???/dae/d120/d29b/d21b (187794) has an incorrect filetype (was 3, should be 1).
Fix<y>? yes

Entry 'd139' in /mnt/p6/d6/de/d127 (187949) is a link to directory /mnt/p6/d6/de/d17/daf/d2fa (188315).
Clear<y>? yes

Entry 'l180' in /mnt/p6/d6/de/d127 (187949) has an incorrect filetype (was 7, should be 1).
Fix<y>?

...
Pass 3: Checking directory connectivity
Unconnected directory inode 204957 (/mnt/p8/d1/d8/dc/d1fd/???)
Connect to /lost+found<y>? yes

Unconnected directory inode 34 (/mnt/p8/d1/d5/???/???/???/???/d33d/d354/d175/???/d6fc/d2e9/???)
Connect to /lost+found<y>? yes
....
'..' in /mnt/p2/de/d1b/d362 (186800) is /mnt/p2/de (186138), should be /mnt/p2/de/d1b (186321).
Fix<y>? yes
...
Inode 186106 ref count is 3, should be 5.  Fix<y>? yes
...
Unattached inode 186169
Connect to /lost+found<y>? yes
....
Unattached zero-length inode 186398.  Clear<y>? yes
...
usual bitmap differences.

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="testfile.fsxlog"

truncating to largest ever: 0x13e76
truncating to largest ever: 0x2e52c
truncating to largest ever: 0x3c2c2
truncating to largest ever: 0x3f15f
truncating to largest ever: 0x3fcb9
truncating to largest ever: 0x3fe96
truncating to largest ever: 0x3ff9d
truncating to largest ever: 0x3ffff
check_size: fstat: Value too large for defined data type
Size error: expected 0x1448 stat 0xffffffffffffffff seek 0x1448
LOG DUMP (55192 total operations):
55193(153 mod 256): READ	0x2b30 thru 0x6bf7	(0x40c8 bytes)
55194(154 mod 256): MAPWRITE 0x17a91 thru 0x25cec	(0xe25c bytes)
55195(155 mod 256): MAPWRITE 0x24f47 thru 0x27b9f	(0x2c59 bytes)
55196(156 mod 256): READ	0x3b3f thru 0x3fa7	(0x469 bytes)
55197(157 mod 256): MAPREAD	0x163b1 thru 0x17534	(0x1184 bytes)
55198(158 mod 256): MAPWRITE 0x158c9 thru 0x1ba61	(0x6199 bytes)
55199(159 mod 256): READ	0x660e thru 0xd8a1	(0x7294 bytes)
55200(160 mod 256): WRITE	0x295ea thru 0x390fd	(0xfb14 bytes) HOLE
55201(161 mod 256): READ	0x27281 thru 0x303dd	(0x915d bytes)
55202(162 mod 256): MAPWRITE 0x2df3 thru 0xc59b	(0x97a9 bytes)
55203(163 mod 256): READ	0x7ad1 thru 0x1253a	(0xaa6a bytes)
55204(164 mod 256): TRUNCATE DOWN	from 0x390fe to 0x1cd3c
55205(165 mod 256): TRUNCATE DOWN	from 0x1cd3c to 0x1c169
55206(166 mod 256): TRUNCATE DOWN	from 0x1c169 to 0xc667
55207(167 mod 256): MAPWRITE 0x3827a thru 0x38a2b	(0x7b2 bytes)
55208(168 mod 256): TRUNCATE DOWN	from 0x38a2c to 0x28e8a
55209(169 mod 256): WRITE	0x2a1a4 thru 0x30cb1	(0x6b0e bytes) HOLE
55210(170 mod 256): MAPWRITE 0x13e39 thru 0x1c9de	(0x8ba6 bytes)
55211(171 mod 256): READ	0x8914 thru 0x9799	(0xe86 bytes)
55212(172 mod 256): WRITE	0x9899 thru 0x17e91	(0xe5f9 bytes)
55213(173 mod 256): MAPWRITE 0x2310c thru 0x272c9	(0x41be bytes)
55214(174 mod 256): READ	0x11ce4 thru 0x1b348	(0x9665 bytes)
55215(175 mod 256): WRITE	0x11359 thru 0x1b4da	(0xa182 bytes)
55216(176 mod 256): MAPREAD	0x3052c thru 0x30cb1	(0x786 bytes)
55217(177 mod 256): TRUNCATE DOWN	from 0x30cb2 to 0x22e43
55218(178 mod 256): MAPREAD	0x1b0c3 thru 0x22e42	(0x7d80 bytes)
55219(179 mod 256): WRITE	0x36aea thru 0x3c1e7	(0x56fe bytes) HOLE
55220(180 mod 256): MAPWRITE 0x2947f thru 0x34d77	(0xb8f9 bytes)
55221(181 mod 256): MAPREAD	0x2a0b4 thru 0x34265	(0xa1b2 bytes)
55222(182 mod 256): WRITE	0x353 thru 0x3cf7	(0x39a5 bytes)
55223(183 mod 256): TRUNCATE UP	from 0x3c1e8 to 0x3d036
55224(184 mod 256): TRUNCATE DOWN	from 0x3d036 to 0xfbab
55225(185 mod 256): READ	0xc92b thru 0xfbaa	(0x3280 bytes)
55226(186 mod 256): MAPREAD	0xd336 thru 0xfbaa	(0x2875 bytes)
55227(187 mod 256): TRUNCATE UP	from 0xfbab to 0x37c78
55228(188 mod 256): MAPREAD	0xd06e thru 0x16600	(0x9593 bytes)
55229(189 mod 256): TRUNCATE DOWN	from 0x37c78 to 0x10a09
55230(190 mod 256): READ	0x7dbf thru 0x10580	(0x87c2 bytes)
55231(191 mod 256): READ	0xf07d thru 0x10a08	(0x198c bytes)
55232(192 mod 256): MAPREAD	0x3e74 thru 0xa847	(0x69d4 bytes)
55233(193 mod 256): MAPWRITE 0x2eff6 thru 0x3ab20	(0xbb2b bytes)
55234(194 mod 256): READ	0x26261 thru 0x2bdd3	(0x5b73 bytes)
55235(195 mod 256): TRUNCATE DOWN	from 0x3ab21 to 0x29955
55236(196 mod 256): MAPWRITE 0x1ea0d thru 0x248ea	(0x5ede bytes)
55237(197 mod 256): MAPWRITE 0x23d62 thru 0x24e1d	(0x10bc bytes)
55238(198 mod 256): MAPREAD	0xfb74 thru 0x133f8	(0x3885 bytes)
55239(199 mod 256): READ	0x213da thru 0x29954	(0x857b bytes)
55240(200 mod 256): MAPREAD	0x1a27f thru 0x1e3e0	(0x4162 bytes)
55241(201 mod 256): READ	0x20bb6 thru 0x28670	(0x7abb bytes)
55242(202 mod 256): READ	0x27921 thru 0x29954	(0x2034 bytes)
55243(203 mod 256): WRITE	0xe35 thru 0x75f4	(0x67c0 bytes)
55244(204 mod 256): MAPREAD	0xfc41 thru 0x17094	(0x7454 bytes)
55245(205 mod 256): MAPREAD	0xa01 thru 0xe5dd	(0xdbdd bytes)
55246(206 mod 256): MAPWRITE 0x39bec thru 0x3ffff	(0x6414 bytes)
55247(207 mod 256): TRUNCATE DOWN	from 0x40000 to 0x1f608
55248(208 mod 256): MAPREAD	0x18739 thru 0x1f607	(0x6ecf bytes)
55249(209 mod 256): TRUNCATE UP	from 0x1f608 to 0x379fd
55250(210 mod 256): TRUNCATE DOWN	from 0x379fd to 0x4029
55251(211 mod 256): MAPREAD	0x85a thru 0x4028	(0x37cf bytes)
55252(212 mod 256): READ	0x39be thru 0x4028	(0x66b bytes)
55253(213 mod 256): WRITE	0x19ecf thru 0x1ac96	(0xdc8 bytes) HOLE
55254(214 mod 256): WRITE	0x7fa8 thru 0x15798	(0xd7f1 bytes)
55255(215 mod 256): READ	0x9314 thru 0x1668e	(0xd37b bytes)
55256(216 mod 256): MAPWRITE 0x67a7 thru 0x12687	(0xbee1 bytes)
55257(217 mod 256): MAPWRITE 0xb301 thru 0x157c7	(0xa4c7 bytes)
55258(218 mod 256): MAPREAD	0x9f4e thru 0xeb84	(0x4c37 bytes)
55259(219 mod 256): READ	0x5dee thru 0xba8a	(0x5c9d bytes)
55260(220 mod 256): READ	0xb57b thru 0x132b0	(0x7d36 bytes)
55261(221 mod 256): WRITE	0xc4b5 thru 0x1421c	(0x7d68 bytes)
55262(222 mod 256): WRITE	0x2d066 thru 0x39f41	(0xcedc bytes) HOLE
55263(223 mod 256): TRUNCATE DOWN	from 0x39f42 to 0x44f2
55264(224 mod 256): TRUNCATE UP	from 0x44f2 to 0x1f964
55265(225 mod 256): READ	0xff94 thru 0x1acf7	(0xad64 bytes)
55266(226 mod 256): WRITE	0x38d80 thru 0x3d3ba	(0x463b bytes) HOLE
55267(227 mod 256): TRUNCATE DOWN	from 0x3d3bb to 0x5018
55268(228 mod 256): WRITE	0x2228 thru 0x58b1	(0x368a bytes) EXTEND
55269(229 mod 256): MAPWRITE 0x19c89 thru 0x21f30	(0x82a8 bytes)
55270(230 mod 256): WRITE	0x1853b thru 0x22a08	(0xa4ce bytes) EXTEND
55271(231 mod 256): MAPREAD	0x64fb thru 0xa908	(0x440e bytes)
55272(232 mod 256): MAPREAD	0x1b7f0 thru 0x1f045	(0x3856 bytes)
55273(233 mod 256): MAPWRITE 0x393d0 thru 0x3ffff	(0x6c30 bytes)
55274(234 mod 256): MAPREAD	0x12cbc thru 0x14978	(0x1cbd bytes)
55275(235 mod 256): READ	0x103bb thru 0x13bb3	(0x37f9 bytes)
55276(236 mod 256): WRITE	0x14f27 thru 0x1e6c0	(0x979a bytes)
55277(237 mod 256): TRUNCATE DOWN	from 0x40000 to 0x31c83
55278(238 mod 256): WRITE	0x28cd3 thru 0x2ec9b	(0x5fc9 bytes)
55279(239 mod 256): MAPREAD	0x924 thru 0xaeb0	(0xa58d bytes)
55280(240 mod 256): WRITE	0x36655 thru 0x3ee38	(0x87e4 bytes) HOLE
55281(241 mod 256): MAPWRITE 0x7a91 thru 0x16c15	(0xf185 bytes)
55282(242 mod 256): WRITE	0x20b61 thru 0x24bde	(0x407e bytes)
55283(243 mod 256): READ	0x51ef thru 0x1174f	(0xc561 bytes)
55284(244 mod 256): READ	0x2908 thru 0x3a7d	(0x1176 bytes)
55285(245 mod 256): READ	0xb360 thru 0xdc8f	(0x2930 bytes)
55286(246 mod 256): MAPWRITE 0x1dabc thru 0x24dd1	(0x7316 bytes)
55287(247 mod 256): MAPREAD	0x219e4 thru 0x2ce1c	(0xb439 bytes)
55288(248 mod 256): MAPWRITE 0x5510 thru 0xfda8	(0xa899 bytes)
55289(249 mod 256): MAPREAD	0x14467 thru 0x167fb	(0x2395 bytes)
55290(250 mod 256): MAPREAD	0x3e5b thru 0x4db1	(0xf57 bytes)
55291(251 mod 256): WRITE	0x1372b thru 0x20bd4	(0xd4aa bytes)
55292(252 mod 256): TRUNCATE DOWN	from 0x3ee39 to 0x15044
55293(253 mod 256): WRITE	0x23989 thru 0x2763b	(0x3cb3 bytes) HOLE
55294(254 mod 256): TRUNCATE UP	from 0x2763c to 0x368c7
55295(255 mod 256): MAPWRITE 0x2653b thru 0x3084f	(0xa315 bytes)
55296(0 mod 256): READ	0x90c thru 0x26d3	(0x1dc8 bytes)
55297(1 mod 256): WRITE	0x20454 thru 0x29ca0	(0x984d bytes)
55298(2 mod 256): WRITE	0x30f36 thru 0x36ce7	(0x5db2 bytes) EXTEND
55299(3 mod 256): WRITE	0x2734c thru 0x33a29	(0xc6de bytes)
55300(4 mod 256): MAPREAD	0x553c thru 0x11ad3	(0xc598 bytes)
55301(5 mod 256): TRUNCATE DOWN	from 0x36ce8 to 0xf05f
55302(6 mod 256): TRUNCATE UP	from 0xf05f to 0x18e2d
55303(7 mod 256): READ	0x12890 thru 0x18e2c	(0x659d bytes)
55304(8 mod 256): MAPREAD	0x5d31 thru 0xa340	(0x4610 bytes)
55305(9 mod 256): WRITE	0x267d0 thru 0x3292e	(0xc15f bytes) HOLE
55306(10 mod 256): MAPWRITE 0x199fc thru 0x1e77c	(0x4d81 bytes)
55307(11 mod 256): WRITE	0x919e thru 0xe2eb	(0x514e bytes)
55308(12 mod 256): MAPREAD	0x1ba thru 0x98b1	(0x96f8 bytes)
55309(13 mod 256): WRITE	0x5329 thru 0xb7dd	(0x64b5 bytes)
55310(14 mod 256): READ	0x1bb8c thru 0x2b306	(0xf77b bytes)
55311(15 mod 256): MAPREAD	0x1cce9 thru 0x26904	(0x9c1c bytes)
55312(16 mod 256): MAPWRITE 0x6349 thru 0xfba6	(0x985e bytes)
55313(17 mod 256): MAPWRITE 0x3d6f5 thru 0x3ffff	(0x290b bytes)
55314(18 mod 256): TRUNCATE DOWN	from 0x40000 to 0x3ca87
55315(19 mod 256): MAPWRITE 0x8499 thru 0xec07	(0x676f bytes)
55316(20 mod 256): MAPREAD	0x12dfa thru 0x15a26	(0x2c2d bytes)
55317(21 mod 256): TRUNCATE DOWN	from 0x3ca87 to 0x2e7e3
55318(22 mod 256): MAPREAD	0x17c78 thru 0x18a77	(0xe00 bytes)
55319(23 mod 256): WRITE	0x5e6e thru 0xa0ab	(0x423e bytes)
55320(24 mod 256): READ	0x2654a thru 0x28c59	(0x2710 bytes)
55321(25 mod 256): TRUNCATE DOWN	from 0x2e7e3 to 0xff7a
55322(26 mod 256): WRITE	0x2a6b9 thru 0x2c5c5	(0x1f0d bytes) HOLE
55323(27 mod 256): READ	0x155fe thru 0x16022	(0xa25 bytes)
55324(28 mod 256): TRUNCATE DOWN	from 0x2c5c6 to 0xae14
55325(29 mod 256): READ	0x3fe0 thru 0x5b6c	(0x1b8d bytes)
55326(30 mod 256): MAPWRITE 0x32a01 thru 0x3968f	(0x6c8f bytes)
55327(31 mod 256): MAPWRITE 0x34cd1 thru 0x3ffff	(0xb32f bytes)
55328(32 mod 256): MAPREAD	0x2bc90 thru 0x2cb9c	(0xf0d bytes)
55329(33 mod 256): MAPREAD	0x37b7 thru 0xb284	(0x7ace bytes)
55330(34 mod 256): WRITE	0x3d62b thru 0x3ffff	(0x29d5 bytes)
55331(35 mod 256): MAPWRITE 0x1d2f1 thru 0x2d0d0	(0xfde0 bytes)
55332(36 mod 256): WRITE	0x33911 thru 0x3ffff	(0xc6ef bytes)
55333(37 mod 256): MAPREAD	0x3bc85 thru 0x3ffff	(0x437b bytes)
55334(38 mod 256): MAPREAD	0x2ffc5 thru 0x3c0b6	(0xc0f2 bytes)
55335(39 mod 256): MAPREAD	0x1dcec thru 0x297a2	(0xbab7 bytes)
55336(40 mod 256): TRUNCATE DOWN	from 0x40000 to 0x2c201
55337(41 mod 256): MAPWRITE 0x37379 thru 0x3f778	(0x8400 bytes)
55338(42 mod 256): MAPREAD	0x19244 thru 0x22dce	(0x9b8b bytes)
55339(43 mod 256): WRITE	0x3fbc4 thru 0x3ffff	(0x43c bytes) HOLE
55340(44 mod 256): MAPWRITE 0x20d36 thru 0x234be	(0x2789 bytes)
55341(45 mod 256): MAPREAD	0x38ba1 thru 0x3ffff	(0x745f bytes)
55342(46 mod 256): MAPREAD	0x25519 thru 0x32f23	(0xda0b bytes)
55343(47 mod 256): WRITE	0x700a thru 0x9bad	(0x2ba4 bytes)
55344(48 mod 256): READ	0x2f10a thru 0x3599b	(0x6892 bytes)
55345(49 mod 256): READ	0x2f1dc thru 0x39e6a	(0xac8f bytes)
55346(50 mod 256): MAPWRITE 0x10cf7 thru 0x1b283	(0xa58d bytes)
55347(51 mod 256): MAPREAD	0x2d435 thru 0x2ddc4	(0x990 bytes)
55348(52 mod 256): READ	0x34650 thru 0x3ffff	(0xb9b0 bytes)
55349(53 mod 256): READ	0x18abd thru 0x26e64	(0xe3a8 bytes)
55350(54 mod 256): WRITE	0x82a8 thru 0x10d6e	(0x8ac7 bytes)
55351(55 mod 256): WRITE	0x3624f thru 0x37a95	(0x1847 bytes)
55352(56 mod 256): WRITE	0x33951 thru 0x3fe18	(0xc4c8 bytes)
55353(57 mod 256): READ	0x3926 thru 0x59df	(0x20ba bytes)
55354(58 mod 256): MAPWRITE 0x16d94 thru 0x1bf1b	(0x5188 bytes)
55355(59 mod 256): READ	0x10a7 thru 0xbc19	(0xab73 bytes)
55356(60 mod 256): WRITE	0x396be thru 0x3dd72	(0x46b5 bytes)
55357(61 mod 256): MAPWRITE 0x1e98d thru 0x2ba55	(0xd0c9 bytes)
55358(62 mod 256): MAPWRITE 0x390e2 thru 0x3ffff	(0x6f1e bytes)
55359(63 mod 256): MAPREAD	0x26496 thru 0x29fce	(0x3b39 bytes)
55360(64 mod 256): WRITE	0x71a4 thru 0x926b	(0x20c8 bytes)
55361(65 mod 256): MAPREAD	0x161b4 thru 0x25022	(0xee6f bytes)
55362(66 mod 256): READ	0x3e9e7 thru 0x3ffff	(0x1619 bytes)
55363(67 mod 256): MAPREAD	0x16f1b thru 0x23c92	(0xcd78 bytes)
55364(68 mod 256): MAPWRITE 0x3ce02 thru 0x3ffff	(0x31fe bytes)
55365(69 mod 256): MAPWRITE 0x11e33 thru 0x11f64	(0x132 bytes)
55366(70 mod 256): MAPREAD	0x1394f thru 0x1597b	(0x202d bytes)
55367(71 mod 256): MAPREAD	0x3c269 thru 0x3ffff	(0x3d97 bytes)
55368(72 mod 256): WRITE	0x3faac thru 0x3ffff	(0x554 bytes)
55369(73 mod 256): READ	0x15fa9 thru 0x21053	(0xb0ab bytes)
55370(74 mod 256): MAPWRITE 0x1c54c thru 0x1d711	(0x11c6 bytes)
55371(75 mod 256): MAPWRITE 0x32d1d thru 0x38b9f	(0x5e83 bytes)
55372(76 mod 256): MAPREAD	0xcd7f thru 0x11b89	(0x4e0b bytes)
55373(77 mod 256): WRITE	0x32132 thru 0x3f00f	(0xcede bytes)
55374(78 mod 256): TRUNCATE DOWN	from 0x40000 to 0x35fd2
55375(79 mod 256): WRITE	0x2c7da thru 0x37a06	(0xb22d bytes) EXTEND
55376(80 mod 256): TRUNCATE DOWN	from 0x37a07 to 0x15f88
55377(81 mod 256): TRUNCATE UP	from 0x15f88 to 0x3880c
55378(82 mod 256): MAPWRITE 0xa2b3 thru 0x16bd2	(0xc920 bytes)
55379(83 mod 256): READ	0x2a3d2 thru 0x2d25d	(0x2e8c bytes)
55380(84 mod 256): TRUNCATE UP	from 0x3880c to 0x3baf4
55381(85 mod 256): MAPWRITE 0x113f7 thru 0x16b40	(0x574a bytes)
55382(86 mod 256): TRUNCATE DOWN	from 0x3baf4 to 0x2da8d
55383(87 mod 256): MAPREAD	0x2009c thru 0x2ad32	(0xac97 bytes)
55384(88 mod 256): MAPREAD	0x157c8 thru 0x17b70	(0x23a9 bytes)
55385(89 mod 256): WRITE	0x18456 thru 0x1cddd	(0x4988 bytes)
55386(90 mod 256): MAPREAD	0xc0fc thru 0x177aa	(0xb6af bytes)
55387(91 mod 256): WRITE	0xca73 thru 0x1b088	(0xe616 bytes)
55388(92 mod 256): MAPWRITE 0x14f02 thru 0x24440	(0xf53f bytes)
55389(93 mod 256): MAPREAD	0x29b52 thru 0x2da8c	(0x3f3b bytes)
55390(94 mod 256): READ	0x82da thru 0x8ac8	(0x7ef bytes)
55391(95 mod 256): MAPREAD	0xe8e0 thru 0xed0e	(0x42f bytes)
55392(96 mod 256): MAPREAD	0x12049 thru 0x1b3e3	(0x939b bytes)
55393(97 mod 256): READ	0x17db9 thru 0x1d5b2	(0x57fa bytes)
55394(98 mod 256): TRUNCATE UP	from 0x2da8d to 0x37261
55395(99 mod 256): WRITE	0x1928d thru 0x204aa	(0x721e bytes)
55396(100 mod 256): MAPREAD	0x100c4 thru 0x12e52	(0x2d8f bytes)
55397(101 mod 256): READ	0x54cb thru 0x12210	(0xcd46 bytes)
55398(102 mod 256): MAPREAD	0x187a0 thru 0x1e38c	(0x5bed bytes)
55399(103 mod 256): MAPREAD	0x1096a thru 0x17b20	(0x71b7 bytes)
55400(104 mod 256): MAPREAD	0xa630 thru 0x12029	(0x79fa bytes)
55401(105 mod 256): TRUNCATE DOWN	from 0x37261 to 0x1cab0
55402(106 mod 256): MAPWRITE 0x4aa6 thru 0x805f	(0x35ba bytes)
55403(107 mod 256): MAPREAD	0x72b1 thru 0x15ecd	(0xec1d bytes)
55404(108 mod 256): TRUNCATE UP	from 0x1cab0 to 0x1d25d
55405(109 mod 256): MAPWRITE 0x26177 thru 0x2ffcb	(0x9e55 bytes)
55406(110 mod 256): READ	0x15b32 thru 0x17295	(0x1764 bytes)
55407(111 mod 256): TRUNCATE DOWN	from 0x2ffcc to 0x3765
55408(112 mod 256): TRUNCATE UP	from 0x3765 to 0x25a14
55409(113 mod 256): WRITE	0x3ae02 thru 0x3ae3d	(0x3c bytes) HOLE
55410(114 mod 256): READ	0x1f345 thru 0x24857	(0x5513 bytes)
55411(115 mod 256): MAPREAD	0x20b7c thru 0x2be92	(0xb317 bytes)
55412(116 mod 256): MAPREAD	0xe070 thru 0x1d9f2	(0xf983 bytes)
55413(117 mod 256): MAPWRITE 0x3bb35 thru 0x3ffff	(0x44cb bytes)
55414(118 mod 256): MAPWRITE 0x24356 thru 0x2f133	(0xadde bytes)
55415(119 mod 256): TRUNCATE DOWN	from 0x40000 to 0x16d41
55416(120 mod 256): READ	0x3057 thru 0xe29c	(0xb246 bytes)
55417(121 mod 256): MAPWRITE 0x370b3 thru 0x3ffff	(0x8f4d bytes)
55418(122 mod 256): READ	0x360d6 thru 0x3ffff	(0x9f2a bytes)
55419(123 mod 256): MAPREAD	0x251e8 thru 0x25e87	(0xca0 bytes)
55420(124 mod 256): READ	0x11baa thru 0x2116a	(0xf5c1 bytes)
55421(125 mod 256): READ	0x3b6b6 thru 0x3dd1a	(0x2665 bytes)
55422(126 mod 256): WRITE	0x15500 thru 0x1bcec	(0x67ed bytes)
55423(127 mod 256): WRITE	0x22be8 thru 0x2832b	(0x5744 bytes)
55424(128 mod 256): MAPREAD	0x17871 thru 0x1f5bb	(0x7d4b bytes)
55425(129 mod 256): READ	0x3c4df thru 0x3e9ea	(0x250c bytes)
55426(130 mod 256): MAPWRITE 0xe4d thru 0x3222	(0x23d6 bytes)
55427(131 mod 256): READ	0x776d thru 0x11dd9	(0xa66d bytes)
55428(132 mod 256): MAPWRITE 0x1d88a thru 0x29be5	(0xc35c bytes)
55429(133 mod 256): MAPWRITE 0x5705 thru 0x8c1f	(0x351b bytes)
55430(134 mod 256): MAPWRITE 0x1746c thru 0x239cf	(0xc564 bytes)
55431(135 mod 256): READ	0x3895c thru 0x3ffff	(0x76a4 bytes)
55432(136 mod 256): MAPWRITE 0x2b4de thru 0x33566	(0x8089 bytes)
55433(137 mod 256): MAPREAD	0x2a021 thru 0x2be7c	(0x1e5c bytes)
55434(138 mod 256): MAPREAD	0x312d8 thru 0x33765	(0x248e bytes)
55435(139 mod 256): READ	0xba5d thru 0x10928	(0x4ecc bytes)
55436(140 mod 256): MAPREAD	0x49da thru 0xbd0c	(0x7333 bytes)
55437(141 mod 256): MAPREAD	0x2a394 thru 0x2aa21	(0x68e bytes)
55438(142 mod 256): TRUNCATE DOWN	from 0x40000 to 0x35edd
55439(143 mod 256): READ	0x3095b thru 0x35edc	(0x5582 bytes)
55440(144 mod 256): TRUNCATE DOWN	from 0x35edd to 0x10fb4
55441(145 mod 256): MAPWRITE 0x3653e thru 0x3ffff	(0x9ac2 bytes)
55442(146 mod 256): MAPWRITE 0x18017 thru 0x1dbea	(0x5bd4 bytes)
55443(147 mod 256): MAPWRITE 0x1b9f thru 0x8f84	(0x73e6 bytes)
55444(148 mod 256): MAPREAD	0x12693 thru 0x1d4a9	(0xae17 bytes)
55445(149 mod 256): WRITE	0xe836 thru 0x179da	(0x91a5 bytes)
55446(150 mod 256): WRITE	0x10c7f thru 0x118ce	(0xc50 bytes)
55447(151 mod 256): MAPWRITE 0x16f15 thru 0x241d3	(0xd2bf bytes)
55448(152 mod 256): TRUNCATE DOWN	from 0x40000 to 0x3b953
55449(153 mod 256): READ	0x388b4 thru 0x3b952	(0x309f bytes)
55450(154 mod 256): TRUNCATE DOWN	from 0x3b953 to 0x311d
55451(155 mod 256): READ	0x1d75 thru 0x311c	(0x13a8 bytes)
55452(156 mod 256): MAPREAD	0x327 thru 0xa44	(0x71e bytes)
55453(157 mod 256): TRUNCATE UP	from 0x311d to 0x3c072
55454(158 mod 256): MAPREAD	0x275f6 thru 0x2ab92	(0x359d bytes)
55455(159 mod 256): READ	0xe18f thru 0x181a3	(0xa015 bytes)
55456(160 mod 256): MAPWRITE 0x1480a thru 0x20e19	(0xc610 bytes)
55457(161 mod 256): MAPWRITE 0x2af91 thru 0x3118c	(0x61fc bytes)
55458(162 mod 256): TRUNCATE DOWN	from 0x3c072 to 0x21cdc
55459(163 mod 256): MAPREAD	0x47d2 thru 0x10a72	(0xc2a1 bytes)
55460(164 mod 256): TRUNCATE DOWN	from 0x21cdc to 0x2056b
55461(165 mod 256): TRUNCATE UP	from 0x2056b to 0x3f107
55462(166 mod 256): WRITE	0x124c6 thru 0x12e90	(0x9cb bytes)
55463(167 mod 256): READ	0x398b4 thru 0x3f106	(0x5853 bytes)
55464(168 mod 256): READ	0x2b179 thru 0x34522	(0x93aa bytes)
55465(169 mod 256): READ	0x36c99 thru 0x3820b	(0x1573 bytes)
55466(170 mod 256): READ	0x2e360 thru 0x39e90	(0xbb31 bytes)
55467(171 mod 256): MAPREAD	0x2023c thru 0x22e35	(0x2bfa bytes)
55468(172 mod 256): WRITE	0x5167 thru 0x67f4	(0x168e bytes)
55469(173 mod 256): MAPREAD	0x3ebf8 thru 0x3f106	(0x50f bytes)
55470(174 mod 256): WRITE	0x7860 thru 0x8167	(0x908 bytes)
55471(175 mod 256): TRUNCATE DOWN	from 0x3f107 to 0x3dcb8
55472(176 mod 256): WRITE	0x33f54 thru 0x3bded	(0x7e9a bytes)
55473(177 mod 256): MAPWRITE 0x9be3 thru 0xc01f	(0x243d bytes)
55474(178 mod 256): MAPWRITE 0x37220 thru 0x3ffff	(0x8de0 bytes)
55475(179 mod 256): READ	0x14aaf thru 0x1d578	(0x8aca bytes)
55476(180 mod 256): MAPREAD	0x3f6bb thru 0x3ffff	(0x945 bytes)
55477(181 mod 256): MAPREAD	0x2782 thru 0x6eba	(0x4739 bytes)
55478(182 mod 256): MAPWRITE 0x31ac4 thru 0x3c016	(0xa553 bytes)
55479(183 mod 256): MAPWRITE 0x112fe thru 0x1e387	(0xd08a bytes)
55480(184 mod 256): MAPREAD	0x341ea thru 0x3eeef	(0xad06 bytes)
55481(185 mod 256): MAPWRITE 0x94a3 thru 0x17504	(0xe062 bytes)
55482(186 mod 256): MAPWRITE 0x30413 thru 0x3496c	(0x455a bytes)
55483(187 mod 256): MAPWRITE 0x6474 thru 0x15a81	(0xf60e bytes)
55484(188 mod 256): TRUNCATE DOWN	from 0x40000 to 0x37ba1
55485(189 mod 256): MAPWRITE 0x2902d thru 0x3559e	(0xc572 bytes)
55486(190 mod 256): TRUNCATE DOWN	from 0x37ba1 to 0x34493
55487(191 mod 256): WRITE	0x187d8 thru 0x1a70a	(0x1f33 bytes)
55488(192 mod 256): WRITE	0x340a8 thru 0x37d81	(0x3cda bytes) EXTEND
55489(193 mod 256): WRITE	0x20b43 thru 0x25a8c	(0x4f4a bytes)
55490(194 mod 256): MAPREAD	0x311dd thru 0x37d81	(0x6ba5 bytes)
55491(195 mod 256): MAPREAD	0x2c0 thru 0x70e3	(0x6e24 bytes)
55492(196 mod 256): WRITE	0x2a3d4 thru 0x2c5fd	(0x222a bytes)
55493(197 mod 256): READ	0x28ad0 thru 0x31903	(0x8e34 bytes)
55494(198 mod 256): WRITE	0xd30d thru 0x11549	(0x423d bytes)
55495(199 mod 256): MAPREAD	0x124b4 thru 0x1c907	(0xa454 bytes)
55496(200 mod 256): TRUNCATE DOWN	from 0x37d82 to 0x8f00
55497(201 mod 256): WRITE	0x20971 thru 0x2c5bd	(0xbc4d bytes) HOLE
55498(202 mod 256): READ	0x1f284 thru 0x269e5	(0x7762 bytes)
55499(203 mod 256): MAPREAD	0x96a0 thru 0x9ed5	(0x836 bytes)
55500(204 mod 256): TRUNCATE DOWN	from 0x2c5be to 0x9f0d
55501(205 mod 256): MAPWRITE 0x14e1b thru 0x15122	(0x308 bytes)
55502(206 mod 256): READ	0x1d12 thru 0x2b87	(0xe76 bytes)
55503(207 mod 256): TRUNCATE UP	from 0x15123 to 0x2e719
55504(208 mod 256): MAPREAD	0x24a1d thru 0x2e718	(0x9cfc bytes)
55505(209 mod 256): WRITE	0x7949 thru 0xd2cd	(0x5985 bytes)
55506(210 mod 256): MAPWRITE 0xabf6 thru 0x18573	(0xd97e bytes)
55507(211 mod 256): MAPWRITE 0x29123 thru 0x33332	(0xa210 bytes)
55508(212 mod 256): TRUNCATE DOWN	from 0x33333 to 0x25911
55509(213 mod 256): READ	0x4835 thru 0xbea3	(0x766f bytes)
55510(214 mod 256): MAPWRITE 0x2977f thru 0x36929	(0xd1ab bytes)
55511(215 mod 256): MAPWRITE 0x3ffa3 thru 0x3ffff	(0x5d bytes)
55512(216 mod 256): MAPREAD	0x279c7 thru 0x29d6e	(0x23a8 bytes)
55513(217 mod 256): MAPREAD	0xe292 thru 0x1bde3	(0xdb52 bytes)
55514(218 mod 256): TRUNCATE DOWN	from 0x40000 to 0x2488d
55515(219 mod 256): TRUNCATE UP	from 0x2488d to 0x317d5
55516(220 mod 256): READ	0x21561 thru 0x2187c	(0x31c bytes)
55517(221 mod 256): MAPWRITE 0x265ae thru 0x2accd	(0x4720 bytes)
55518(222 mod 256): MAPREAD	0xfcce thru 0x173e5	(0x7718 bytes)
55519(223 mod 256): READ	0x11a3 thru 0x815e	(0x6fbc bytes)
55520(224 mod 256): WRITE	0x7177 thru 0xa839	(0x36c3 bytes)
55521(225 mod 256): READ	0x9e0c thru 0x17091	(0xd286 bytes)
55522(226 mod 256): MAPREAD	0x109df thru 0x11519	(0xb3b bytes)
55523(227 mod 256): MAPWRITE 0x64ff thru 0x15a32	(0xf534 bytes)
55524(228 mod 256): READ	0x20849 thru 0x2da2c	(0xd1e4 bytes)
55525(229 mod 256): MAPREAD	0xe1f thru 0xb3c0	(0xa5a2 bytes)
55526(230 mod 256): WRITE	0x22168 thru 0x31b73	(0xfa0c bytes) EXTEND
55527(231 mod 256): MAPREAD	0x2e27e thru 0x31b73	(0x38f6 bytes)
55528(232 mod 256): TRUNCATE DOWN	from 0x31b74 to 0x7ffe
55529(233 mod 256): MAPREAD	0x5ab1 thru 0x7f7f	(0x24cf bytes)
55530(234 mod 256): TRUNCATE UP	from 0x7ffe to 0x2ca15
55531(235 mod 256): READ	0x1682d thru 0x217fe	(0xafd2 bytes)
55532(236 mod 256): READ	0x15d86 thru 0x16967	(0xbe2 bytes)
55533(237 mod 256): MAPWRITE 0x277be thru 0x317c0	(0xa003 bytes)
55534(238 mod 256): MAPREAD	0x24623 thru 0x2c697	(0x8075 bytes)
55535(239 mod 256): READ	0x1c982 thru 0x2ae2f	(0xe4ae bytes)
55536(240 mod 256): TRUNCATE DOWN	from 0x317c1 to 0x160fd
55537(241 mod 256): MAPWRITE 0x33560 thru 0x3ffff	(0xcaa0 bytes)
55538(242 mod 256): READ	0x18586 thru 0x1d59f	(0x501a bytes)
55539(243 mod 256): READ	0x9e88 thru 0x17f57	(0xe0d0 bytes)
55540(244 mod 256): WRITE	0x30c5c thru 0x3f1dc	(0xe581 bytes)
55541(245 mod 256): MAPWRITE 0x21746 thru 0x2296e	(0x1229 bytes)
55542(246 mod 256): TRUNCATE DOWN	from 0x40000 to 0x2c79e
55543(247 mod 256): TRUNCATE DOWN	from 0x2c79e to 0x17b61
55544(248 mod 256): MAPREAD	0xf371 thru 0x17b60	(0x87f0 bytes)
55545(249 mod 256): MAPWRITE 0x2d31d thru 0x2fae6	(0x27ca bytes)
55546(250 mod 256): TRUNCATE UP	from 0x2fae7 to 0x3807c
55547(251 mod 256): READ	0xb569 thru 0xe629	(0x30c1 bytes)
55548(252 mod 256): WRITE	0x3fdb3 thru 0x3ffff	(0x24d bytes) HOLE
55549(253 mod 256): WRITE	0x24881 thru 0x3376a	(0xeeea bytes)
55550(254 mod 256): WRITE	0x3aeb0 thru 0x3ffff	(0x5150 bytes)
55551(255 mod 256): MAPWRITE 0x2b7e6 thru 0x30a85	(0x52a0 bytes)
55552(0 mod 256): READ	0xcbd9 thru 0xcd11	(0x139 bytes)
55553(1 mod 256): READ	0x379e1 thru 0x3ffff	(0x861f bytes)
55554(2 mod 256): READ	0x17c2f thru 0x1a76e	(0x2b40 bytes)
55555(3 mod 256): WRITE	0x1a8de thru 0x2299c	(0x80bf bytes)
55556(4 mod 256): TRUNCATE DOWN	from 0x40000 to 0x297fe
55557(5 mod 256): WRITE	0x3b41d thru 0x3ffff	(0x4be3 bytes) HOLE
55558(6 mod 256): TRUNCATE DOWN	from 0x40000 to 0x14d2a
55559(7 mod 256): READ	0x4817 thru 0x125af	(0xdd99 bytes)
55560(8 mod 256): TRUNCATE UP	from 0x14d2a to 0x3e537
55561(9 mod 256): MAPWRITE 0x169c thru 0x4757	(0x30bc bytes)
55562(10 mod 256): MAPWRITE 0x39435 thru 0x3ffff	(0x6bcb bytes)
55563(11 mod 256): READ	0x13fb0 thru 0x16f41	(0x2f92 bytes)
55564(12 mod 256): READ	0x1d983 thru 0x26397	(0x8a15 bytes)
55565(13 mod 256): MAPWRITE 0x144f1 thru 0x1db1a	(0x962a bytes)
55566(14 mod 256): MAPREAD	0xe70c thru 0x1de3d	(0xf732 bytes)
55567(15 mod 256): MAPWRITE 0x3af9c thru 0x3ffff	(0x5064 bytes)
55568(16 mod 256): WRITE	0x11eb2 thru 0x16db2	(0x4f01 bytes)
55569(17 mod 256): MAPREAD	0x319b8 thru 0x38b67	(0x71b0 bytes)
55570(18 mod 256): WRITE	0x1230b thru 0x12551	(0x247 bytes)
55571(19 mod 256): TRUNCATE DOWN	from 0x40000 to 0x374db
55572(20 mod 256): READ	0x79eb thru 0xdc4e	(0x6264 bytes)
55573(21 mod 256): MAPWRITE 0x3fda9 thru 0x3ffff	(0x257 bytes)
55574(22 mod 256): READ	0x1e416 thru 0x2473d	(0x6328 bytes)
55575(23 mod 256): MAPREAD	0x2fef3 thru 0x3e916	(0xea24 bytes)
55576(24 mod 256): WRITE	0x1a62d thru 0x1e218	(0x3bec bytes)
55577(25 mod 256): READ	0x1d7c3 thru 0x28abe	(0xb2fc bytes)
55578(26 mod 256): MAPREAD	0x2393c thru 0x2a5b9	(0x6c7e bytes)
55579(27 mod 256): MAPWRITE 0x331f0 thru 0x364ee	(0x32ff bytes)
55580(28 mod 256): MAPREAD	0x3fc00 thru 0x3ffff	(0x400 bytes)
55581(29 mod 256): TRUNCATE DOWN	from 0x40000 to 0x1770c
55582(30 mod 256): TRUNCATE UP	from 0x1770c to 0x20c1b
55583(31 mod 256): MAPREAD	0x10646 thru 0x16e8f	(0x684a bytes)
55584(32 mod 256): MAPREAD	0xe547 thru 0x13256	(0x4d10 bytes)
55585(33 mod 256): TRUNCATE DOWN	from 0x20c1b to 0x12532
55586(34 mod 256): WRITE	0x266c7 thru 0x2d68e	(0x6fc8 bytes) HOLE
55587(35 mod 256): WRITE	0x19062 thru 0x1962d	(0x5cc bytes)
55588(36 mod 256): READ	0x13a74 thru 0x1a4f0	(0x6a7d bytes)
55589(37 mod 256): MAPWRITE 0x34349 thru 0x3dbf4	(0x98ac bytes)
55590(38 mod 256): MAPWRITE 0x313d6 thru 0x355f4	(0x421f bytes)
55591(39 mod 256): TRUNCATE DOWN	from 0x3dbf5 to 0x284d2
55592(40 mod 256): MAPREAD	0x1e7cf thru 0x21066	(0x2898 bytes)
55593(41 mod 256): READ	0x5d9c thru 0xda38	(0x7c9d bytes)
55594(42 mod 256): MAPWRITE 0xc24b thru 0x19d29	(0xdadf bytes)
55595(43 mod 256): READ	0x239a3 thru 0x284d1	(0x4b2f bytes)
55596(44 mod 256): TRUNCATE DOWN	from 0x284d2 to 0x10418
55597(45 mod 256): WRITE	0x591f thru 0xdfa9	(0x868b bytes)
55598(46 mod 256): TRUNCATE UP	from 0x10418 to 0x19df0
55599(47 mod 256): WRITE	0x30d5f thru 0x31def	(0x1091 bytes) HOLE
55600(48 mod 256): TRUNCATE UP	from 0x31df0 to 0x33020
55601(49 mod 256): MAPREAD	0x12d41 thru 0x17e78	(0x5138 bytes)
55602(50 mod 256): MAPWRITE 0x33453 thru 0x36cf4	(0x38a2 bytes)
55603(51 mod 256): READ	0x2c565 thru 0x2e8dd	(0x2379 bytes)
55604(52 mod 256): WRITE	0x5960 thru 0x126ac	(0xcd4d bytes)
55605(53 mod 256): READ	0x226bc thru 0x295f9	(0x6f3e bytes)
55606(54 mod 256): MAPREAD	0x25c00 thru 0x318e8	(0xbce9 bytes)
55607(55 mod 256): MAPREAD	0x2d7eb thru 0x317a5	(0x3fbb bytes)
55608(56 mod 256): MAPWRITE 0xb550 thru 0x1820f	(0xccc0 bytes)
55609(57 mod 256): WRITE	0x2e0e8 thru 0x3cea6	(0xedbf bytes) EXTEND
55610(58 mod 256): TRUNCATE DOWN	from 0x3cea7 to 0x3469e
55611(59 mod 256): READ	0x1dcba thru 0x22723	(0x4a6a bytes)
55612(60 mod 256): MAPWRITE 0x18825 thru 0x1d279	(0x4a55 bytes)
55613(61 mod 256): TRUNCATE DOWN	from 0x3469e to 0x2119b
55614(62 mod 256): WRITE	0x2e7db thru 0x33ab0	(0x52d6 bytes) HOLE
55615(63 mod 256): READ	0x318ee thru 0x33ab0	(0x21c3 bytes)
55616(64 mod 256): MAPREAD	0xf207 thru 0x15645	(0x643f bytes)
55617(65 mod 256): MAPREAD	0x2e1ed thru 0x33ab0	(0x58c4 bytes)
55618(66 mod 256): MAPREAD	0x20660 thru 0x2e05a	(0xd9fb bytes)
55619(67 mod 256): READ	0x83d6 thru 0xd534	(0x515f bytes)
55620(68 mod 256): TRUNCATE DOWN	from 0x33ab1 to 0x20bc1
55621(69 mod 256): TRUNCATE UP	from 0x20bc1 to 0x3c076
55622(70 mod 256): MAPREAD	0x3503b thru 0x3c075	(0x703b bytes)
55623(71 mod 256): MAPWRITE 0x3254a thru 0x35d31	(0x37e8 bytes)
55624(72 mod 256): MAPWRITE 0x1688a thru 0x20f65	(0xa6dc bytes)
55625(73 mod 256): WRITE	0x9077 thru 0x173ed	(0xe377 bytes)
55626(74 mod 256): TRUNCATE DOWN	from 0x3c076 to 0x8f9c
55627(75 mod 256): TRUNCATE UP	from 0x8f9c to 0x3cb50
55628(76 mod 256): MAPREAD	0x18c62 thru 0x22889	(0x9c28 bytes)
55629(77 mod 256): READ	0x1fb7 thru 0x2ea8	(0xef2 bytes)
55630(78 mod 256): MAPWRITE 0x6651 thru 0x115ef	(0xaf9f bytes)
55631(79 mod 256): READ	0x3a3f9 thru 0x3a7bf	(0x3c7 bytes)
55632(80 mod 256): TRUNCATE DOWN	from 0x3cb50 to 0x150c1
55633(81 mod 256): TRUNCATE DOWN	from 0x150c1 to 0xa2f4
55634(82 mod 256): WRITE	0x37d50 thru 0x3cbc2	(0x4e73 bytes) HOLE
55635(83 mod 256): MAPWRITE 0x2de3d thru 0x2f442	(0x1606 bytes)
55636(84 mod 256): MAPREAD	0x1dd4d thru 0x23054	(0x5308 bytes)
55637(85 mod 256): MAPREAD	0x28e6a thru 0x2fe82	(0x7019 bytes)
55638(86 mod 256): READ	0x149d5 thru 0x1cd5c	(0x8388 bytes)
55639(87 mod 256): MAPREAD	0x770c thru 0x103b4	(0x8ca9 bytes)
55640(88 mod 256): MAPWRITE 0x25cb0 thru 0x354f8	(0xf849 bytes)
55641(89 mod 256): WRITE	0x15283 thru 0x1907b	(0x3df9 bytes)
55642(90 mod 256): READ	0x31a80 thru 0x3493c	(0x2ebd bytes)
55643(91 mod 256): MAPWRITE 0x982e thru 0x10855	(0x7028 bytes)
55644(92 mod 256): READ	0x1e848 thru 0x20fc6	(0x277f bytes)
55645(93 mod 256): TRUNCATE DOWN	from 0x3cbc3 to 0x1aefa
55646(94 mod 256): WRITE	0x2c017 thru 0x3b207	(0xf1f1 bytes) HOLE
55647(95 mod 256): TRUNCATE DOWN	from 0x3b208 to 0x1daab
55648(96 mod 256): TRUNCATE DOWN	from 0x1daab to 0x17aab
55649(97 mod 256): MAPREAD	0x831a thru 0xcba5	(0x488c bytes)
55650(98 mod 256): MAPREAD	0xff83 thru 0x10e7b	(0xef9 bytes)
55651(99 mod 256): MAPWRITE 0x38aaa thru 0x3ffff	(0x7556 bytes)
55652(100 mod 256): WRITE	0x3e914 thru 0x3ffff	(0x16ec bytes)
55653(101 mod 256): MAPWRITE 0x24139 thru 0x317bc	(0xd684 bytes)
55654(102 mod 256): MAPREAD	0x130dd thru 0x2027e	(0xd1a2 bytes)
55655(103 mod 256): MAPWRITE 0x3563c thru 0x3daf9	(0x84be bytes)
55656(104 mod 256): READ	0x382f6 thru 0x3ffff	(0x7d0a bytes)
55657(105 mod 256): READ	0x3a139 thru 0x3ffff	(0x5ec7 bytes)
55658(106 mod 256): MAPWRITE 0xe185 thru 0xe7e3	(0x65f bytes)
55659(107 mod 256): MAPWRITE 0x8902 thru 0x9b49	(0x1248 bytes)
55660(108 mod 256): MAPWRITE 0x1fb8f thru 0x20415	(0x887 bytes)
55661(109 mod 256): WRITE	0xf1c0 thru 0x10703	(0x1544 bytes)
55662(110 mod 256): TRUNCATE DOWN	from 0x40000 to 0x3bc6b
55663(111 mod 256): MAPREAD	0x13e98 thru 0x1a9eb	(0x6b54 bytes)
55664(112 mod 256): MAPWRITE 0x1d597 thru 0x20a6a	(0x34d4 bytes)
55665(113 mod 256): TRUNCATE DOWN	from 0x3bc6b to 0x2e48
55666(114 mod 256): MAPWRITE 0x20d97 thru 0x2505c	(0x42c6 bytes)
55667(115 mod 256): WRITE	0x15d4d thru 0x18e49	(0x30fd bytes)
55668(116 mod 256): MAPWRITE 0x2c914 thru 0x30989	(0x4076 bytes)
55669(117 mod 256): MAPREAD	0x2fc94 thru 0x30989	(0xcf6 bytes)
55670(118 mod 256): TRUNCATE UP	from 0x3098a to 0x3c82d
55671(119 mod 256): MAPWRITE 0x39d45 thru 0x3dc46	(0x3f02 bytes)
55672(120 mod 256): TRUNCATE DOWN	from 0x3dc47 to 0xa607
55673(121 mod 256): TRUNCATE UP	from 0xa607 to 0xe932
55674(122 mod 256): MAPREAD	0x3f7f thru 0x5e96	(0x1f18 bytes)
55675(123 mod 256): TRUNCATE UP	from 0xe932 to 0x3e6f4
55676(124 mod 256): MAPREAD	0x2c2b4 thru 0x34242	(0x7f8f bytes)
55677(125 mod 256): MAPWRITE 0x2f174 thru 0x36181	(0x700e bytes)
55678(126 mod 256): MAPWRITE 0x37c97 thru 0x3ffff	(0x8369 bytes)
55679(127 mod 256): MAPREAD	0x24501 thru 0x28d61	(0x4861 bytes)
55680(128 mod 256): MAPREAD	0x32336 thru 0x34382	(0x204d bytes)
55681(129 mod 256): MAPREAD	0x37819 thru 0x3ccd2	(0x54ba bytes)
55682(130 mod 256): WRITE	0x1bad1 thru 0x1c8ed	(0xe1d bytes)
55683(131 mod 256): WRITE	0xdd01 thru 0x173ac	(0x96ac bytes)
55684(132 mod 256): MAPWRITE 0x18168 thru 0x19623	(0x14bc bytes)
55685(133 mod 256): WRITE	0xd95b thru 0x189fc	(0xb0a2 bytes)
55686(134 mod 256): WRITE	0xf54d thru 0x141e2	(0x4c96 bytes)
55687(135 mod 256): TRUNCATE DOWN	from 0x40000 to 0x3e29
55688(136 mod 256): MAPREAD	0x3358 thru 0x3e28	(0xad1 bytes)
55689(137 mod 256): WRITE	0x22531 thru 0x24b44	(0x2614 bytes) HOLE
55690(138 mod 256): READ	0xba38 thru 0x16568	(0xab31 bytes)
55691(139 mod 256): MAPREAD	0x212c8 thru 0x24b44	(0x387d bytes)
55692(140 mod 256): MAPWRITE 0x39b0e thru 0x3d09c	(0x358f bytes)
55693(141 mod 256): READ	0x9ef thru 0xcbed	(0xc1ff bytes)
55694(142 mod 256): READ	0x3a50f thru 0x3d09c	(0x2b8e bytes)
55695(143 mod 256): READ	0x2be42 thru 0x3068f	(0x484e bytes)
55696(144 mod 256): MAPREAD	0x13fe5 thru 0x1f46d	(0xb489 bytes)
55697(145 mod 256): MAPWRITE 0x18a3d thru 0x20c69	(0x822d bytes)
55698(146 mod 256): TRUNCATE DOWN	from 0x3d09d to 0x22e40
55699(147 mod 256): MAPWRITE 0x535f thru 0x12910	(0xd5b2 bytes)
55700(148 mod 256): MAPREAD	0x1f0b6 thru 0x22e3f	(0x3d8a bytes)
55701(149 mod 256): READ	0x11a83 thru 0x18752	(0x6cd0 bytes)
55702(150 mod 256): MAPREAD	0xcfc7 thru 0x17dd8	(0xae12 bytes)
55703(151 mod 256): MAPREAD	0xc4f9 thru 0xefc2	(0x2aca bytes)
55704(152 mod 256): WRITE	0x3269e thru 0x3647d	(0x3de0 bytes) HOLE
55705(153 mod 256): MAPWRITE 0x22ca1 thru 0x3062c	(0xd98c bytes)
55706(154 mod 256): MAPREAD	0x2129a thru 0x2348a	(0x21f1 bytes)
55707(155 mod 256): MAPREAD	0x1ad16 thru 0x26de4	(0xc0cf bytes)
55708(156 mod 256): TRUNCATE UP	from 0x3647e to 0x39b51
55709(157 mod 256): WRITE	0x3cbc4 thru 0x3ffff	(0x343c bytes) HOLE
55710(158 mod 256): MAPREAD	0xe240 thru 0x1da54	(0xf815 bytes)
55711(159 mod 256): MAPREAD	0x10728 thru 0x198f6	(0x91cf bytes)
55712(160 mod 256): WRITE	0xc8e1 thru 0x10d2a	(0x444a bytes)
55713(161 mod 256): TRUNCATE DOWN	from 0x40000 to 0x23843
55714(162 mod 256): TRUNCATE DOWN	from 0x23843 to 0xfd64
55715(163 mod 256): READ	0x1db1 thru 0xf243	(0xd493 bytes)
55716(164 mod 256): MAPREAD	0x9d9e thru 0xaffd	(0x1260 bytes)
55717(165 mod 256): WRITE	0x3b142 thru 0x3d609	(0x24c8 bytes) HOLE
55718(166 mod 256): MAPWRITE 0x2cbc1 thru 0x34cae	(0x80ee bytes)
55719(167 mod 256): WRITE	0x8826 thru 0x13b32	(0xb30d bytes)
55720(168 mod 256): TRUNCATE DOWN	from 0x3d60a to 0x1bc88
55721(169 mod 256): READ	0x1418b thru 0x1bc87	(0x7afd bytes)
55722(170 mod 256): TRUNCATE UP	from 0x1bc88 to 0x38704
55723(171 mod 256): WRITE	0x3a4ce thru 0x3ffff	(0x5b32 bytes) HOLE
55724(172 mod 256): MAPWRITE 0x3d215 thru 0x3ffff	(0x2deb bytes)
55725(173 mod 256): MAPWRITE 0x182e thru 0x103bf	(0xeb92 bytes)
55726(174 mod 256): READ	0x7764 thru 0x10583	(0x8e20 bytes)
55727(175 mod 256): MAPREAD	0x2fdac thru 0x3ca6a	(0xccbf bytes)
55728(176 mod 256): MAPREAD	0x2cba8 thru 0x3ada3	(0xe1fc bytes)
55729(177 mod 256): WRITE	0x4ca5 thru 0x9685	(0x49e1 bytes)
55730(178 mod 256): READ	0x1f9ea thru 0x2f189	(0xf7a0 bytes)
55731(179 mod 256): WRITE	0x1db2d thru 0x205cd	(0x2aa1 bytes)
55732(180 mod 256): MAPWRITE 0x3833e thru 0x3ffff	(0x7cc2 bytes)
55733(181 mod 256): WRITE	0x17dcd thru 0x20c86	(0x8eba bytes)
55734(182 mod 256): MAPREAD	0x1f0ad thru 0x2e8eb	(0xf83f bytes)
55735(183 mod 256): MAPWRITE 0x3adcf thru 0x3ef30	(0x4162 bytes)
55736(184 mod 256): MAPREAD	0xf37d thru 0x1dc1f	(0xe8a3 bytes)
55737(185 mod 256): TRUNCATE DOWN	from 0x40000 to 0x22164
55738(186 mod 256): READ	0x160ba thru 0x16776	(0x6bd bytes)
55739(187 mod 256): MAPWRITE 0x1718a thru 0x21200	(0xa077 bytes)
55740(188 mod 256): MAPREAD	0x12c67 thru 0x22163	(0xf4fd bytes)
55741(189 mod 256): MAPWRITE 0x234a6 thru 0x26d04	(0x385f bytes)
55742(190 mod 256): TRUNCATE DOWN	from 0x26d05 to 0x20391
55743(191 mod 256): TRUNCATE DOWN	from 0x20391 to 0x1c7f9
55744(192 mod 256): MAPREAD	0x1bf5b thru 0x1c7f8	(0x89e bytes)
55745(193 mod 256): MAPWRITE 0x6863 thru 0xc65f	(0x5dfd bytes)
55746(194 mod 256): WRITE	0x1705e thru 0x2061d	(0x95c0 bytes) EXTEND
55747(195 mod 256): MAPREAD	0xba06 thru 0xeb92	(0x318d bytes)
55748(196 mod 256): MAPWRITE 0x3730c thru 0x3ffff	(0x8cf4 bytes)
55749(197 mod 256): WRITE	0x13551 thru 0x22988	(0xf438 bytes)
55750(198 mod 256): WRITE	0x1f316 thru 0x201ac	(0xe97 bytes)
55751(199 mod 256): TRUNCATE DOWN	from 0x40000 to 0x3474e
55752(200 mod 256): MAPWRITE 0x20f9f thru 0x28fb9	(0x801b bytes)
55753(201 mod 256): TRUNCATE DOWN	from 0x3474e to 0x19ec5
55754(202 mod 256): TRUNCATE UP	from 0x19ec5 to 0x31313
55755(203 mod 256): TRUNCATE UP	from 0x31313 to 0x3e4bb
55756(204 mod 256): READ	0xb0c9 thru 0x17b0d	(0xca45 bytes)
55757(205 mod 256): MAPREAD	0x2c4f thru 0x5c9e	(0x3050 bytes)
55758(206 mod 256): MAPWRITE 0x220e1 thru 0x2ca12	(0xa932 bytes)
55759(207 mod 256): TRUNCATE DOWN	from 0x3e4bb to 0x12c57
55760(208 mod 256): MAPREAD	0x10ef8 thru 0x11ca7	(0xdb0 bytes)
55761(209 mod 256): READ	0x4560 thru 0x6a78	(0x2519 bytes)
55762(210 mod 256): MAPWRITE 0x28ebd thru 0x33e60	(0xafa4 bytes)
55763(211 mod 256): READ	0x280bb thru 0x2d365	(0x52ab bytes)
55764(212 mod 256): WRITE	0x3fe23 thru 0x3ffff	(0x1dd bytes) HOLE
55765(213 mod 256): MAPREAD	0x7d65 thru 0xc13d	(0x43d9 bytes)
55766(214 mod 256): READ	0xb59c thru 0x1aeef	(0xf954 bytes)
55767(215 mod 256): READ	0x1ee87 thru 0x2eaa2	(0xfc1c bytes)
55768(216 mod 256): TRUNCATE DOWN	from 0x40000 to 0x31a7f
55769(217 mod 256): MAPWRITE 0x1f01c thru 0x26ed8	(0x7ebd bytes)
55770(218 mod 256): TRUNCATE UP	from 0x31a7f to 0x3e9c1
55771(219 mod 256): READ	0xe689 thru 0x177a7	(0x911f bytes)
55772(220 mod 256): MAPREAD	0x5c74 thru 0x9fa8	(0x4335 bytes)
55773(221 mod 256): MAPWRITE 0x31969 thru 0x3a114	(0x87ac bytes)
55774(222 mod 256): MAPWRITE 0x1503c thru 0x214c8	(0xc48d bytes)
55775(223 mod 256): MAPREAD	0x3b5bf thru 0x3e9c0	(0x3402 bytes)
55776(224 mod 256): MAPWRITE 0x8fbc thru 0x18f9b	(0xffe0 bytes)
55777(225 mod 256): READ	0xf583 thru 0x11b1e	(0x259c bytes)
55778(226 mod 256): TRUNCATE DOWN	from 0x3e9c1 to 0x37700
55779(227 mod 256): MAPREAD	0x2991e thru 0x376ff	(0xdde2 bytes)
55780(228 mod 256): MAPREAD	0x4d55 thru 0x1094e	(0xbbfa bytes)
55781(229 mod 256): READ	0x1603e thru 0x1ba12	(0x59d5 bytes)
55782(230 mod 256): TRUNCATE UP	from 0x37700 to 0x3b97e
55783(231 mod 256): MAPWRITE 0x13506 thru 0x1709a	(0x3b95 bytes)
55784(232 mod 256): MAPWRITE 0x3f604 thru 0x3ffff	(0x9fc bytes)
55785(233 mod 256): WRITE	0xf415 thru 0x111f2	(0x1dde bytes)
55786(234 mod 256): MAPWRITE 0x259f5 thru 0x3071b	(0xad27 bytes)
55787(235 mod 256): MAPWRITE 0x304b6 thru 0x37c30	(0x777b bytes)
55788(236 mod 256): MAPREAD	0x22191 thru 0x296a9	(0x7519 bytes)
55789(237 mod 256): MAPWRITE 0x276f7 thru 0x37450	(0xfd5a bytes)
55790(238 mod 256): WRITE	0x2321a thru 0x2f736	(0xc51d bytes)
55791(239 mod 256): READ	0x38368 thru 0x3b182	(0x2e1b bytes)
55792(240 mod 256): MAPWRITE 0x358da thru 0x3c52d	(0x6c54 bytes)
55793(241 mod 256): READ	0x1f7e0 thru 0x2a5ad	(0xadce bytes)
55794(242 mod 256): READ	0x3e35e thru 0x3ffff	(0x1ca2 bytes)
55795(243 mod 256): MAPWRITE 0x3fb43 thru 0x3ffff	(0x4bd bytes)
55796(244 mod 256): READ	0x389d thru 0x10d4c	(0xd4b0 bytes)
55797(245 mod 256): TRUNCATE DOWN	from 0x40000 to 0x1880d
55798(246 mod 256): MAPWRITE 0x328b1 thru 0x3b8ef	(0x903f bytes)
55799(247 mod 256): READ	0x35dc3 thru 0x37f0b	(0x2149 bytes)
55800(248 mod 256): TRUNCATE DOWN	from 0x3b8f0 to 0x28a6c
55801(249 mod 256): READ	0x16e2f thru 0x20626	(0x97f8 bytes)
55802(250 mod 256): MAPWRITE 0x28273 thru 0x35b9d	(0xd92b bytes)
55803(251 mod 256): WRITE	0x180cf thru 0x1e8b6	(0x67e8 bytes)
55804(252 mod 256): WRITE	0x19c74 thru 0x1f1b5	(0x5542 bytes)
55805(253 mod 256): TRUNCATE UP	from 0x35b9e to 0x3806f
55806(254 mod 256): WRITE	0x3714b thru 0x3baa2	(0x4958 bytes) EXTEND
55807(255 mod 256): MAPWRITE 0x16f2a thru 0x186b1	(0x1788 bytes)
55808(0 mod 256): MAPREAD	0x23cdb thru 0x32b36	(0xee5c bytes)
55809(1 mod 256): TRUNCATE DOWN	from 0x3baa3 to 0x33b06
55810(2 mod 256): MAPREAD	0x2cf38 thru 0x33b05	(0x6bce bytes)
55811(3 mod 256): MAPREAD	0x18176 thru 0x229da	(0xa865 bytes)
55812(4 mod 256): READ	0x310fe thru 0x33b05	(0x2a08 bytes)
55813(5 mod 256): MAPREAD	0x20f07 thru 0x2d95d	(0xca57 bytes)
55814(6 mod 256): READ	0x2504a thru 0x2eba1	(0x9b58 bytes)
55815(7 mod 256): WRITE	0x3e154 thru 0x3ffff	(0x1eac bytes) HOLE
55816(8 mod 256): WRITE	0x477c thru 0x133b9	(0xec3e bytes)
55817(9 mod 256): TRUNCATE DOWN	from 0x40000 to 0x35
55818(10 mod 256): READ	0xe thru 0x34	(0x27 bytes)
55819(11 mod 256): TRUNCATE UP	from 0x35 to 0x7b78
55820(12 mod 256): MAPWRITE 0x11d2a thru 0x18580	(0x6857 bytes)
55821(13 mod 256): WRITE	0x1aa50 thru 0x20b0d	(0x60be bytes) HOLE
55822(14 mod 256): TRUNCATE DOWN	from 0x20b0e to 0x3c87
55823(15 mod 256): MAPREAD	0x1af4 thru 0x3c86	(0x2193 bytes)
55824(16 mod 256): MAPREAD	0x2e14 thru 0x3c86	(0xe73 bytes)
55825(17 mod 256): MAPWRITE 0x31c5c thru 0x3cef2	(0xb297 bytes)
55826(18 mod 256): MAPWRITE 0x1262b thru 0x143d8	(0x1dae bytes)
55827(19 mod 256): MAPREAD	0x15801 thru 0x24963	(0xf163 bytes)
55828(20 mod 256): MAPWRITE 0x2d662 thru 0x2e8ad	(0x124c bytes)
55829(21 mod 256): MAPWRITE 0xb8ce thru 0xc78e	(0xec1 bytes)
55830(22 mod 256): WRITE	0x21bcf thru 0x30b5d	(0xef8f bytes)
55831(23 mod 256): READ	0xe052 thru 0x1c016	(0xdfc5 bytes)
55832(24 mod 256): MAPWRITE 0x104c thru 0xfdb9	(0xed6e bytes)
55833(25 mod 256): MAPWRITE 0x24e6b thru 0x2cf85	(0x811b bytes)
55834(26 mod 256): READ	0x31dbe thru 0x3cef2	(0xb135 bytes)
55835(27 mod 256): READ	0x8ee4 thru 0x11e55	(0x8f72 bytes)
55836(28 mod 256): READ	0x1cfd1 thru 0x1ef27	(0x1f57 bytes)
55837(29 mod 256): TRUNCATE DOWN	from 0x3cef3 to 0x1150e
55838(30 mod 256): TRUNCATE UP	from 0x1150e to 0x2cf96
55839(31 mod 256): READ	0x6a2e thru 0xbac6	(0x5099 bytes)
55840(32 mod 256): MAPREAD	0x61f thru 0x5095	(0x4a77 bytes)
55841(33 mod 256): MAPREAD	0x32ec thru 0x6ee5	(0x3bfa bytes)
55842(34 mod 256): WRITE	0x35357 thru 0x3827c	(0x2f26 bytes) HOLE
55843(35 mod 256): MAPREAD	0x11c64 thru 0x1adf1	(0x918e bytes)
55844(36 mod 256): WRITE	0x3f1b6 thru 0x3ffff	(0xe4a bytes) HOLE
55845(37 mod 256): READ	0x2d87f thru 0x2e01b	(0x79d bytes)
55846(38 mod 256): MAPWRITE 0x124e0 thru 0x17d11	(0x5832 bytes)
55847(39 mod 256): TRUNCATE DOWN	from 0x40000 to 0x1eef
55848(40 mod 256): READ	0x128a thru 0x187b	(0x5f2 bytes)
55849(41 mod 256): WRITE	0xf35b thru 0x137fc	(0x44a2 bytes) HOLE
55850(42 mod 256): WRITE	0x22c3d thru 0x319a9	(0xed6d bytes) HOLE
55851(43 mod 256): MAPREAD	0x1ce0 thru 0x89c7	(0x6ce8 bytes)
55852(44 mod 256): READ	0x15664 thru 0x1877d	(0x311a bytes)
55853(45 mod 256): TRUNCATE DOWN	from 0x319aa to 0x163cc
55854(46 mod 256): WRITE	0xc22a thru 0xcc0a	(0x9e1 bytes)
55855(47 mod 256): READ	0x1013c thru 0x13d1b	(0x3be0 bytes)
55856(48 mod 256): MAPWRITE 0x340ec thru 0x3eacc	(0xa9e1 bytes)
55857(49 mod 256): MAPREAD	0x2d06e thru 0x3bf13	(0xeea6 bytes)
55858(50 mod 256): WRITE	0x1e80c thru 0x27203	(0x89f8 bytes)
55859(51 mod 256): MAPREAD	0x9b6d thru 0x14217	(0xa6ab bytes)
55860(52 mod 256): MAPWRITE 0x3d2c1 thru 0x3ffff	(0x2d3f bytes)
55861(53 mod 256): TRUNCATE DOWN	from 0x40000 to 0xa7d7
55862(54 mod 256): TRUNCATE DOWN	from 0xa7d7 to 0x972b
55863(55 mod 256): WRITE	0x1c304 thru 0x1de54	(0x1b51 bytes) HOLE
55864(56 mod 256): TRUNCATE UP	from 0x1de55 to 0x22347
55865(57 mod 256): TRUNCATE UP	from 0x22347 to 0x3acca
55866(58 mod 256): MAPWRITE 0x311f thru 0x749e	(0x4380 bytes)
55867(59 mod 256): TRUNCATE DOWN	from 0x3acca to 0x1381f
55868(60 mod 256): MAPREAD	0x105e7 thru 0x1381e	(0x3238 bytes)
55869(61 mod 256): MAPREAD	0xd6dc thru 0x13437	(0x5d5c bytes)
55870(62 mod 256): MAPREAD	0x2c0b thru 0x2d13	(0x109 bytes)
55871(63 mod 256): MAPREAD	0x3e95 thru 0xed86	(0xaef2 bytes)
55872(64 mod 256): MAPWRITE 0x31b2b thru 0x323f3	(0x8c9 bytes)
55873(65 mod 256): READ	0x1cfd3 thru 0x1f2d9	(0x2307 bytes)
55874(66 mod 256): WRITE	0x32805 thru 0x3df29	(0xb725 bytes) HOLE
55875(67 mod 256): READ	0x3b6e1 thru 0x3df29	(0x2849 bytes)
55876(68 mod 256): MAPREAD	0x14229 thru 0x1f16e	(0xaf46 bytes)
55877(69 mod 256): MAPWRITE 0x19325 thru 0x1e963	(0x563f bytes)
55878(70 mod 256): MAPWRITE 0x111a7 thru 0x143e9	(0x3243 bytes)
55879(71 mod 256): MAPWRITE 0x8ce6 thru 0xcc44	(0x3f5f bytes)
55880(72 mod 256): MAPREAD	0xcf00 thru 0x1a4a5	(0xd5a6 bytes)
55881(73 mod 256): MAPREAD	0x270e6 thru 0x2ffc9	(0x8ee4 bytes)
55882(74 mod 256): READ	0x127e2 thru 0x192ea	(0x6b09 bytes)
55883(75 mod 256): MAPREAD	0xac55 thru 0xcc58	(0x2004 bytes)
55884(76 mod 256): TRUNCATE DOWN	from 0x3df2a to 0x245e
55885(77 mod 256): WRITE	0x1e470 thru 0x2665d	(0x81ee bytes) HOLE
55886(78 mod 256): MAPWRITE 0x393e2 thru 0x3ebbb	(0x57da bytes)
55887(79 mod 256): READ	0x3957d thru 0x3ebbb	(0x563f bytes)
55888(80 mod 256): TRUNCATE DOWN	from 0x3ebbc to 0x32009
55889(81 mod 256): WRITE	0x21859 thru 0x2c7f3	(0xaf9b bytes)
55890(82 mod 256): TRUNCATE DOWN	from 0x32009 to 0x15895
55891(83 mod 256): TRUNCATE UP	from 0x15895 to 0x1f3b6
55892(84 mod 256): MAPREAD	0x204b thru 0xb0ff	(0x90b5 bytes)
55893(85 mod 256): READ	0xd92d thru 0x1d4a6	(0xfb7a bytes)
55894(86 mod 256): WRITE	0x81f0 thru 0x1616b	(0xdf7c bytes)
55895(87 mod 256): READ	0x9401 thru 0x10c5c	(0x785c bytes)
55896(88 mod 256): READ	0x88c3 thru 0xda78	(0x51b6 bytes)
55897(89 mod 256): MAPREAD	0x12622 thru 0x18532	(0x5f11 bytes)
55898(90 mod 256): MAPREAD	0x1818 thru 0x4dde	(0x35c7 bytes)
55899(91 mod 256): READ	0x44dd thru 0xddea	(0x990e bytes)
55900(92 mod 256): WRITE	0x31008 thru 0x32e02	(0x1dfb bytes) HOLE
55901(93 mod 256): READ	0x22002 thru 0x2464b	(0x264a bytes)
55902(94 mod 256): WRITE	0x3fa66 thru 0x3ffff	(0x59a bytes) HOLE
55903(95 mod 256): MAPREAD	0x302cb thru 0x3bfc3	(0xbcf9 bytes)
55904(96 mod 256): MAPREAD	0xf806 thru 0x128f2	(0x30ed bytes)
55905(97 mod 256): MAPWRITE 0x134a thru 0xe628	(0xd2df bytes)
55906(98 mod 256): MAPWRITE 0x18883 thru 0x276c7	(0xee45 bytes)
55907(99 mod 256): READ	0x3d492 thru 0x3ffff	(0x2b6e bytes)
55908(100 mod 256): WRITE	0x8085 thru 0x15eea	(0xde66 bytes)
55909(101 mod 256): MAPWRITE 0x2585d thru 0x2f064	(0x9808 bytes)
55910(102 mod 256): MAPREAD	0x1db4 thru 0x11937	(0xfb84 bytes)
55911(103 mod 256): READ	0x32d4 thru 0x11f71	(0xec9e bytes)
55912(104 mod 256): MAPWRITE 0x3fa85 thru 0x3ffff	(0x57b bytes)
55913(105 mod 256): MAPREAD	0x1d287 thru 0x2898e	(0xb708 bytes)
55914(106 mod 256): TRUNCATE DOWN	from 0x40000 to 0x37c1c
55915(107 mod 256): WRITE	0x8921 thru 0x16597	(0xdc77 bytes)
55916(108 mod 256): MAPREAD	0x2bc7 thru 0x92bb	(0x66f5 bytes)
55917(109 mod 256): MAPWRITE 0xf38a thru 0xf5b4	(0x22b bytes)
55918(110 mod 256): MAPWRITE 0x37ef0 thru 0x3ffff	(0x8110 bytes)
55919(111 mod 256): READ	0x2ca62 thru 0x2dd71	(0x1310 bytes)
55920(112 mod 256): READ	0x3ffe1 thru 0x3ffff	(0x1f bytes)
55921(113 mod 256): WRITE	0x27ee1 thru 0x317ed	(0x990d bytes)
55922(114 mod 256): TRUNCATE DOWN	from 0x40000 to 0x1b09a
55923(115 mod 256): MAPWRITE 0x2ebed thru 0x36578	(0x798c bytes)
55924(116 mod 256): TRUNCATE DOWN	from 0x36579 to 0x2a458
55925(117 mod 256): MAPREAD	0x5f6 thru 0x10457	(0xfe62 bytes)
55926(118 mod 256): READ	0x4bbe thru 0x71f6	(0x2639 bytes)
55927(119 mod 256): TRUNCATE DOWN	from 0x2a458 to 0xac2d
55928(120 mod 256): READ	0x5e86 thru 0xac2c	(0x4da7 bytes)
55929(121 mod 256): WRITE	0x24819 thru 0x263a7	(0x1b8f bytes) HOLE
55930(122 mod 256): MAPREAD	0xe004 thru 0x108e4	(0x28e1 bytes)
55931(123 mod 256): TRUNCATE UP	from 0x263a8 to 0x373b4
55932(124 mod 256): TRUNCATE DOWN	from 0x373b4 to 0x1d40d
55933(125 mod 256): WRITE	0x3a057 thru 0x3f5be	(0x5568 bytes) HOLE
55934(126 mod 256): MAPWRITE 0x3f3 thru 0xad7a	(0xa988 bytes)
55935(127 mod 256): TRUNCATE DOWN	from 0x3f5bf to 0x3962c
55936(128 mod 256): MAPREAD	0x7600 thru 0xc5b0	(0x4fb1 bytes)
55937(129 mod 256): MAPREAD	0xd7ce thru 0x1428b	(0x6abe bytes)
55938(130 mod 256): TRUNCATE DOWN	from 0x3962c to 0x1fc2e
55939(131 mod 256): TRUNCATE UP	from 0x1fc2e to 0x39062
55940(132 mod 256): WRITE	0xdc2 thru 0x533d	(0x457c bytes)
55941(133 mod 256): TRUNCATE DOWN	from 0x39062 to 0x33219
55942(134 mod 256): MAPWRITE 0x14110 thru 0x1e3f1	(0xa2e2 bytes)
55943(135 mod 256): READ	0x25ef2 thru 0x2cee9	(0x6ff8 bytes)
55944(136 mod 256): MAPWRITE 0xd691 thru 0x1a543	(0xceb3 bytes)
55945(137 mod 256): MAPWRITE 0x3f9e4 thru 0x3ffff	(0x61c bytes)
55946(138 mod 256): TRUNCATE DOWN	from 0x40000 to 0x33968
55947(139 mod 256): MAPWRITE 0x1cc23 thru 0x25e9a	(0x9278 bytes)
55948(140 mod 256): MAPWRITE 0x11089 thru 0x1c364	(0xb2dc bytes)
55949(141 mod 256): WRITE	0x353f3 thru 0x390d5	(0x3ce3 bytes) HOLE
55950(142 mod 256): TRUNCATE DOWN	from 0x390d6 to 0xcd68
55951(143 mod 256): READ	0x3e2 thru 0xcd67	(0xc986 bytes)
55952(144 mod 256): MAPWRITE 0x2c529 thru 0x362b6	(0x9d8e bytes)
55953(145 mod 256): WRITE	0x381e5 thru 0x3ffff	(0x7e1b bytes) HOLE
55954(146 mod 256): MAPREAD	0x2a5c5 thru 0x2ea68	(0x44a4 bytes)
55955(147 mod 256): MAPWRITE 0x36936 thru 0x3f419	(0x8ae4 bytes)
55956(148 mod 256): READ	0x1a784 thru 0x24363	(0x9be0 bytes)
55957(149 mod 256): MAPWRITE 0x22925 thru 0x31cd0	(0xf3ac bytes)
55958(150 mod 256): WRITE	0x2df5f thru 0x3c8ba	(0xe95c bytes)
55959(151 mod 256): MAPREAD	0x28dd6 thru 0x376f8	(0xe923 bytes)
55960(152 mod 256): MAPREAD	0x158b4 thru 0x17d88	(0x24d5 bytes)
55961(153 mod 256): MAPREAD	0x16a94 thru 0x1cc14	(0x6181 bytes)
55962(154 mod 256): WRITE	0x144a9 thru 0x15106	(0xc5e bytes)
55963(155 mod 256): WRITE	0x35b44 thru 0x3ffff	(0xa4bc bytes)
55964(156 mod 256): WRITE	0x3ebcc thru 0x3ffff	(0x1434 bytes)
55965(157 mod 256): TRUNCATE DOWN	from 0x40000 to 0x7132
55966(158 mod 256): WRITE	0x1e515 thru 0x28cfc	(0xa7e8 bytes) HOLE
55967(159 mod 256): MAPWRITE 0x3e0f1 thru 0x3ffff	(0x1f0f bytes)
55968(160 mod 256): WRITE	0x2d6c0 thru 0x3144a	(0x3d8b bytes)
55969(161 mod 256): READ	0x3f930 thru 0x3ffff	(0x6d0 bytes)
55970(162 mod 256): TRUNCATE DOWN	from 0x40000 to 0x2428
55971(163 mod 256): MAPREAD	0x1f63 thru 0x2427	(0x4c5 bytes)
55972(164 mod 256): TRUNCATE UP	from 0x2428 to 0x1831e
55973(165 mod 256): TRUNCATE DOWN	from 0x1831e to 0x15526
55974(166 mod 256): MAPWRITE 0x32acc thru 0x3748b	(0x49c0 bytes)
55975(167 mod 256): MAPREAD	0xa644 thru 0x135ad	(0x8f6a bytes)
55976(168 mod 256): TRUNCATE DOWN	from 0x3748c to 0x30ecc
55977(169 mod 256): WRITE	0x36df6 thru 0x3b251	(0x445c bytes) HOLE
55978(170 mod 256): MAPREAD	0x26b2a thru 0x2768f	(0xb66 bytes)
55979(171 mod 256): WRITE	0xf3a4 thru 0x16e9a	(0x7af7 bytes)
55980(172 mod 256): TRUNCATE DOWN	from 0x3b252 to 0x141fa
55981(173 mod 256): MAPWRITE 0x3288a thru 0x3ffff	(0xd776 bytes)
55982(174 mod 256): MAPREAD	0x8466 thru 0x160b4	(0xdc4f bytes)
55983(175 mod 256): MAPWRITE 0x1b740 thru 0x2145f	(0x5d20 bytes)
55984(176 mod 256): TRUNCATE DOWN	from 0x40000 to 0x2e655
55985(177 mod 256): READ	0x1032e thru 0x1d756	(0xd429 bytes)
55986(178 mod 256): READ	0x1b8fe thru 0x274f4	(0xbbf7 bytes)
55987(179 mod 256): TRUNCATE UP	from 0x2e655 to 0x320d1
55988(180 mod 256): MAPREAD	0x2ca26 thru 0x320d0	(0x56ab bytes)
55989(181 mod 256): TRUNCATE DOWN	from 0x320d1 to 0xdd67
55990(182 mod 256): MAPREAD	0x6271 thru 0xdd66	(0x7af6 bytes)
55991(183 mod 256): MAPREAD	0x3056 thru 0xdd66	(0xad11 bytes)
55992(184 mod 256): MAPREAD	0x442b thru 0xdd66	(0x993c bytes)
55993(185 mod 256): WRITE	0x32f8e thru 0x3ffff	(0xd072 bytes) HOLE
55994(186 mod 256): TRUNCATE DOWN	from 0x40000 to 0x2b4c3
55995(187 mod 256): MAPREAD	0x18514 thru 0x214b9	(0x8fa6 bytes)
55996(188 mod 256): MAPREAD	0x235d8 thru 0x2b4c2	(0x7eeb bytes)
55997(189 mod 256): MAPWRITE 0x23f00 thru 0x320b9	(0xe1ba bytes)
55998(190 mod 256): READ	0x30cfb thru 0x312fd	(0x603 bytes)
55999(191 mod 256): MAPWRITE 0x36017 thru 0x3d129	(0x7113 bytes)
56000(192 mod 256): WRITE	0x125aa thru 0x20718	(0xe16f bytes)
55001(217 mod 256): MAPREAD	0x2616d thru 0x2bef1	(0x5d85 bytes)
55002(218 mod 256): READ	0x15014 thru 0x15b66	(0xb53 bytes)
55003(219 mod 256): TRUNCATE DOWN	from 0x3d12a to 0x26371
55004(220 mod 256): MAPWRITE 0x29dee thru 0x34299	(0xa4ac bytes)
55005(221 mod 256): MAPWRITE 0x3ebeb thru 0x3f4fe	(0x914 bytes)
55006(222 mod 256): READ	0x14c0d thru 0x22f1b	(0xe30f bytes)
55007(223 mod 256): WRITE	0x3929 thru 0x1211a	(0xe7f2 bytes)
55008(224 mod 256): TRUNCATE DOWN	from 0x3f4ff to 0x3d3bc
55009(225 mod 256): TRUNCATE DOWN	from 0x3d3bc to 0x26ebb
55010(226 mod 256): WRITE	0x1123e thru 0x12647	(0x140a bytes)
55011(227 mod 256): WRITE	0x35742 thru 0x39b5e	(0x441d bytes) HOLE
55012(228 mod 256): TRUNCATE DOWN	from 0x39b5f to 0x22094
55013(229 mod 256): MAPWRITE 0x252b6 thru 0x30cf8	(0xba43 bytes)
55014(230 mod 256): MAPREAD	0x24d7e thru 0x30b58	(0xbddb bytes)
55015(231 mod 256): WRITE	0x38388 thru 0x3a585	(0x21fe bytes) HOLE
55016(232 mod 256): MAPWRITE 0x222bc thru 0x27397	(0x50dc bytes)
55017(233 mod 256): TRUNCATE DOWN	from 0x3a586 to 0x3595a
55018(234 mod 256): MAPWRITE 0x3309a thru 0x3ffff	(0xcf66 bytes)
55019(235 mod 256): TRUNCATE DOWN	from 0x40000 to 0x2694f
55020(236 mod 256): WRITE	0x572b thru 0x12603	(0xced9 bytes)
55021(237 mod 256): MAPWRITE 0x1708a thru 0x20505	(0x947c bytes)
55022(238 mod 256): READ	0x1ab1a thru 0x255e2	(0xaac9 bytes)
55023(239 mod 256): READ	0x70dd thru 0x153b6	(0xe2da bytes)
55024(240 mod 256): MAPWRITE 0xb12d thru 0x17d74	(0xcc48 bytes)
55025(241 mod 256): MAPREAD	0x5869 thru 0xc17d	(0x6915 bytes)
55026(242 mod 256): WRITE	0x79cd thru 0x13e09	(0xc43d bytes)
55027(243 mod 256): MAPREAD	0x1360 thru 0xa808	(0x94a9 bytes)
55028(244 mod 256): MAPWRITE 0x2d0a8 thru 0x323e9	(0x5342 bytes)
55029(245 mod 256): WRITE	0x1d46d thru 0x25759	(0x82ed bytes)
55030(246 mod 256): READ	0xdadb thru 0xdc7b	(0x1a1 bytes)
55031(247 mod 256): WRITE	0x1bfd9 thru 0x2ad70	(0xed98 bytes)
55032(248 mod 256): MAPWRITE 0x2d738 thru 0x31f7c	(0x4845 bytes)
55033(249 mod 256): READ	0xeb23 thru 0x1cc3a	(0xe118 bytes)
55034(250 mod 256): TRUNCATE DOWN	from 0x323ea to 0x1b2b6
55035(251 mod 256): WRITE	0x2259e thru 0x2bd22	(0x9785 bytes) HOLE
55036(252 mod 256): MAPREAD	0x258b5 thru 0x2bd22	(0x646e bytes)
55037(253 mod 256): READ	0x1c992 thru 0x1ffed	(0x365c bytes)
55038(254 mod 256): TRUNCATE DOWN	from 0x2bd23 to 0x2304a
55039(255 mod 256): MAPREAD	0x12f4e thru 0x1f9aa	(0xca5d bytes)
55040(0 mod 256): MAPWRITE 0x59a thru 0x68d1	(0x6338 bytes)
55041(1 mod 256): READ	0xa005 thru 0xd045	(0x3041 bytes)
55042(2 mod 256): WRITE	0x8ab7 thru 0x8ecc	(0x416 bytes)
55043(3 mod 256): READ	0x191c2 thru 0x1d4dd	(0x431c bytes)
55044(4 mod 256): WRITE	0x192c2 thru 0x1ee47	(0x5b86 bytes)
55045(5 mod 256): READ	0xcef7 thru 0x171dc	(0xa2e6 bytes)
55046(6 mod 256): TRUNCATE DOWN	from 0x2304a to 0x14a99
55047(7 mod 256): MAPWRITE 0x1f0e6 thru 0x2ad33	(0xbc4e bytes)
55048(8 mod 256): TRUNCATE UP	from 0x2ad34 to 0x327d9
55049(9 mod 256): TRUNCATE DOWN	from 0x327d9 to 0x1f099
55050(10 mod 256): READ	0x14af9 thru 0x1997b	(0x4e83 bytes)
55051(11 mod 256): WRITE	0x1225a thru 0x147c2	(0x2569 bytes)
55052(12 mod 256): READ	0x54fa thru 0xafb7	(0x5abe bytes)
55053(13 mod 256): MAPWRITE 0x28499 thru 0x344bf	(0xc027 bytes)
55054(14 mod 256): MAPWRITE 0x1c791 thru 0x23191	(0x6a01 bytes)
55055(15 mod 256): TRUNCATE DOWN	from 0x344c0 to 0x263c3
55056(16 mod 256): MAPREAD	0x23cc6 thru 0x263c2	(0x26fd bytes)
55057(17 mod 256): READ	0x12736 thru 0x136d7	(0xfa2 bytes)
55058(18 mod 256): MAPWRITE 0x7b00 thru 0x12981	(0xae82 bytes)
55059(19 mod 256): READ	0xa22 thru 0x83cc	(0x79ab bytes)
55060(20 mod 256): READ	0x186a9 thru 0x215b9	(0x8f11 bytes)
55061(21 mod 256): MAPWRITE 0xc7e1 thru 0x153d5	(0x8bf5 bytes)
55062(22 mod 256): TRUNCATE UP	from 0x263c3 to 0x2cbe3
55063(23 mod 256): TRUNCATE UP	from 0x2cbe3 to 0x3a67d
55064(24 mod 256): MAPREAD	0x2e13a thru 0x31072	(0x2f39 bytes)
55065(25 mod 256): TRUNCATE UP	from 0x3a67d to 0x3a706
55066(26 mod 256): MAPWRITE 0x23c12 thru 0x2b292	(0x7681 bytes)
55067(27 mod 256): WRITE	0x15b43 thru 0x1b94a	(0x5e08 bytes)
55068(28 mod 256): MAPWRITE 0x32c49 thru 0x38291	(0x5649 bytes)
55069(29 mod 256): READ	0x3a09b thru 0x3a705	(0x66b bytes)
55070(30 mod 256): READ	0x189b7 thru 0x1f779	(0x6dc3 bytes)
55071(31 mod 256): WRITE	0x28ee8 thru 0x35a16	(0xcb2f bytes)
55072(32 mod 256): MAPREAD	0x29817 thru 0x38e40	(0xf62a bytes)
55073(33 mod 256): MAPREAD	0x19f33 thru 0x277eb	(0xd8b9 bytes)
55074(34 mod 256): MAPREAD	0x20369 thru 0x278e7	(0x757f bytes)
55075(35 mod 256): READ	0x343c5 thru 0x3a705	(0x6341 bytes)
55076(36 mod 256): TRUNCATE DOWN	from 0x3a706 to 0x3085d
55077(37 mod 256): TRUNCATE DOWN	from 0x3085d to 0x657e
55078(38 mod 256): WRITE	0x20e17 thru 0x2f0e9	(0xe2d3 bytes) HOLE
55079(39 mod 256): MAPREAD	0x1034d thru 0x1e6a7	(0xe35b bytes)
55080(40 mod 256): WRITE	0x3d4a3 thru 0x3ffff	(0x2b5d bytes) HOLE
55081(41 mod 256): WRITE	0x10c2b thru 0x128bb	(0x1c91 bytes)
55082(42 mod 256): READ	0x19716 thru 0x213d2	(0x7cbd bytes)
55083(43 mod 256): MAPREAD	0x3b43d thru 0x3f127	(0x3ceb bytes)
55084(44 mod 256): WRITE	0x1653c thru 0x21faa	(0xba6f bytes)
55085(45 mod 256): MAPREAD	0x3787f thru 0x3f8ed	(0x806f bytes)
55086(46 mod 256): WRITE	0x19bbf thru 0x1ee3c	(0x527e bytes)
55087(47 mod 256): MAPWRITE 0x116f4 thru 0x1abc1	(0x94ce bytes)
55088(48 mod 256): MAPWRITE 0x2de48 thru 0x372a7	(0x9460 bytes)
55089(49 mod 256): READ	0x2c938 thru 0x32b9b	(0x6264 bytes)
55090(50 mod 256): READ	0x30172 thru 0x349ca	(0x4859 bytes)
55091(51 mod 256): MAPREAD	0x32791 thru 0x3c1c1	(0x9a31 bytes)
55092(52 mod 256): WRITE	0x1d196 thru 0x2623e	(0x90a9 bytes)
55093(53 mod 256): TRUNCATE DOWN	from 0x40000 to 0x34dc0
55094(54 mod 256): MAPREAD	0xc495 thru 0x1b58c	(0xf0f8 bytes)
55095(55 mod 256): WRITE	0x25396 thru 0x30701	(0xb36c bytes)
55096(56 mod 256): MAPWRITE 0x2398 thru 0xc2fb	(0x9f64 bytes)
55097(57 mod 256): WRITE	0x2f667 thru 0x3e8f1	(0xf28b bytes) EXTEND
55098(58 mod 256): READ	0x2fd11 thru 0x3cd21	(0xd011 bytes)
55099(59 mod 256): TRUNCATE DOWN	from 0x3e8f2 to 0x226e1
55100(60 mod 256): MAPREAD	0xd84d thru 0x100ae	(0x2862 bytes)
55101(61 mod 256): TRUNCATE DOWN	from 0x226e1 to 0xd69f
55102(62 mod 256): WRITE	0x9f63 thru 0x1165e	(0x76fc bytes) EXTEND
55103(63 mod 256): WRITE	0x1cb1d thru 0x2202a	(0x550e bytes) HOLE
55104(64 mod 256): TRUNCATE UP	from 0x2202b to 0x3529f
55105(65 mod 256): WRITE	0xa379 thru 0x16a52	(0xc6da bytes)
55106(66 mod 256): MAPREAD	0xc8ac thru 0x108b7	(0x400c bytes)
55107(67 mod 256): WRITE	0x12b26 thru 0x17b0c	(0x4fe7 bytes)
55108(68 mod 256): MAPWRITE 0x19158 thru 0x2293d	(0x97e6 bytes)
55109(69 mod 256): MAPREAD	0x1b2eb thru 0x21449	(0x615f bytes)
55110(70 mod 256): WRITE	0x3ceb1 thru 0x3ffff	(0x314f bytes) HOLE
55111(71 mod 256): READ	0x1081d thru 0x1c552	(0xbd36 bytes)
55112(72 mod 256): MAPWRITE 0x18903 thru 0x270a7	(0xe7a5 bytes)
55113(73 mod 256): MAPWRITE 0x35298 thru 0x391b8	(0x3f21 bytes)
55114(74 mod 256): TRUNCATE DOWN	from 0x40000 to 0x21b95
55115(75 mod 256): TRUNCATE DOWN	from 0x21b95 to 0x1f95a
55116(76 mod 256): MAPREAD	0x1d683 thru 0x1da92	(0x410 bytes)
55117(77 mod 256): READ	0x13a6a thru 0x1dfe1	(0xa578 bytes)
55118(78 mod 256): MAPWRITE 0x19bb0 thru 0x200d1	(0x6522 bytes)
55119(79 mod 256): READ	0x17aee thru 0x198f7	(0x1e0a bytes)
55120(80 mod 256): MAPWRITE 0x5ed4 thru 0x114a2	(0xb5cf bytes)
55121(81 mod 256): MAPWRITE 0x39470 thru 0x3a46e	(0xfff bytes)
55122(82 mod 256): MAPREAD	0x7faf thru 0x996e	(0x19c0 bytes)
55123(83 mod 256): MAPREAD	0x33a36 thru 0x33b43	(0x10e bytes)
55124(84 mod 256): WRITE	0x168f4 thru 0x22c94	(0xc3a1 bytes)
55125(85 mod 256): TRUNCATE DOWN	from 0x3a46f to 0x9991
55126(86 mod 256): TRUNCATE UP	from 0x9991 to 0x21731
55127(87 mod 256): WRITE	0x28d16 thru 0x28dcc	(0xb7 bytes) HOLE
55128(88 mod 256): WRITE	0x33194 thru 0x358d5	(0x2742 bytes) HOLE
55129(89 mod 256): WRITE	0x17588 thru 0x180fe	(0xb77 bytes)
55130(90 mod 256): READ	0x48a1 thru 0x68f5	(0x2055 bytes)
55131(91 mod 256): WRITE	0x58a7 thru 0x104bb	(0xac15 bytes)
55132(92 mod 256): READ	0x15613 thru 0x23420	(0xde0e bytes)
55133(93 mod 256): WRITE	0x1b633 thru 0x22763	(0x7131 bytes)
55134(94 mod 256): MAPWRITE 0x1a6ad thru 0x20d23	(0x6677 bytes)
55135(95 mod 256): TRUNCATE UP	from 0x358d6 to 0x3ba25
55136(96 mod 256): READ	0x11ebd thru 0x1b873	(0x99b7 bytes)
55137(97 mod 256): MAPWRITE 0x27862 thru 0x28475	(0xc14 bytes)
55138(98 mod 256): WRITE	0x109b9 thru 0x1c25c	(0xb8a4 bytes)
55139(99 mod 256): MAPWRITE 0x36946 thru 0x3ffff	(0x96ba bytes)
55140(100 mod 256): WRITE	0x1f45e thru 0x2da0c	(0xe5af bytes)
55141(101 mod 256): WRITE	0x38d1f thru 0x3ce47	(0x4129 bytes)
55142(102 mod 256): MAPWRITE 0x16118 thru 0x246ef	(0xe5d8 bytes)
55143(103 mod 256): WRITE	0x1e560 thru 0x2165d	(0x30fe bytes)
55144(104 mod 256): MAPREAD	0x29b72 thru 0x32e0f	(0x929e bytes)
55145(105 mod 256): WRITE	0x14052 thru 0x14609	(0x5b8 bytes)
55146(106 mod 256): WRITE	0x371a8 thru 0x3ffff	(0x8e58 bytes)
55147(107 mod 256): TRUNCATE DOWN	from 0x40000 to 0x3e5d8
55148(108 mod 256): TRUNCATE DOWN	from 0x3e5d8 to 0x61b7
55149(109 mod 256): MAPWRITE 0x2ac23 thru 0x3aa3f	(0xfe1d bytes)
55150(110 mod 256): READ	0x72cc thru 0xab0e	(0x3843 bytes)
55151(111 mod 256): TRUNCATE DOWN	from 0x3aa40 to 0x3a74e
55152(112 mod 256): TRUNCATE UP	from 0x3a74e to 0x3bd84
55153(113 mod 256): MAPREAD	0x14cbe thru 0x2392d	(0xec70 bytes)
55154(114 mod 256): MAPWRITE 0xe03f thru 0x1a8d2	(0xc894 bytes)
55155(115 mod 256): READ	0x226d9 thru 0x2e458	(0xbd80 bytes)
55156(116 mod 256): READ	0x36a4d thru 0x3bd83	(0x5337 bytes)
55157(117 mod 256): WRITE	0x13e8f thru 0x1fb04	(0xbc76 bytes)
55158(118 mod 256): MAPREAD	0x2ac1c thru 0x3a855	(0xfc3a bytes)
55159(119 mod 256): READ	0x3827c thru 0x3bd83	(0x3b08 bytes)
55160(120 mod 256): MAPWRITE 0x31aa0 thru 0x3c7ca	(0xad2b bytes)
55161(121 mod 256): MAPWRITE 0x1636 thru 0xdad8	(0xc4a3 bytes)
55162(122 mod 256): MAPREAD	0x186ed thru 0x265de	(0xdef2 bytes)
55163(123 mod 256): TRUNCATE DOWN	from 0x3c7cb to 0x2b728
55164(124 mod 256): READ	0x28350 thru 0x2b727	(0x33d8 bytes)
55165(125 mod 256): READ	0x15514 thru 0x22344	(0xce31 bytes)
55166(126 mod 256): MAPWRITE 0xd295 thru 0x196b0	(0xc41c bytes)
55167(127 mod 256): MAPWRITE 0xfc49 thru 0x1209e	(0x2456 bytes)
55168(128 mod 256): WRITE	0x18b61 thru 0x19a92	(0xf32 bytes)
55169(129 mod 256): MAPWRITE 0x25205 thru 0x333eb	(0xe1e7 bytes)
55170(130 mod 256): TRUNCATE DOWN	from 0x333ec to 0x8264
55171(131 mod 256): READ	0x583b thru 0x8263	(0x2a29 bytes)
55172(132 mod 256): WRITE	0xbc7d thru 0x1b73f	(0xfac3 bytes) HOLE
55173(133 mod 256): MAPWRITE 0x8542 thru 0x1592d	(0xd3ec bytes)
55174(134 mod 256): MAPWRITE 0x6175 thru 0xbe3b	(0x5cc7 bytes)
55175(135 mod 256): TRUNCATE DOWN	from 0x1b740 to 0x18351
55176(136 mod 256): TRUNCATE UP	from 0x18351 to 0x398de
55177(137 mod 256): READ	0x9950 thru 0x9fec	(0x69d bytes)
55178(138 mod 256): MAPWRITE 0x1c16c thru 0x22b58	(0x69ed bytes)
55179(139 mod 256): MAPWRITE 0x2110b thru 0x2ab1a	(0x9a10 bytes)
55180(140 mod 256): READ	0x16ebb thru 0x23ba2	(0xcce8 bytes)
55181(141 mod 256): READ	0x2d5c7 thru 0x30971	(0x33ab bytes)
55182(142 mod 256): MAPWRITE 0xccd1 thru 0x16877	(0x9ba7 bytes)
55183(143 mod 256): WRITE	0x2374f thru 0x3033a	(0xcbec bytes)
55184(144 mod 256): MAPREAD	0x23844 thru 0x2b8a4	(0x8061 bytes)
55185(145 mod 256): MAPREAD	0xb7c1 thru 0x19505	(0xdd45 bytes)
55186(146 mod 256): READ	0xfea5 thru 0x1b2e1	(0xb43d bytes)
55187(147 mod 256): READ	0x1a10c thru 0x1a33d	(0x232 bytes)
55188(148 mod 256): READ	0x1cb69 thru 0x22111	(0x55a9 bytes)
55189(149 mod 256): MAPWRITE 0x38aa4 thru 0x3ffff	(0x755c bytes)
55190(150 mod 256): MAPWRITE 0x6e2f thru 0xdba6	(0x6d78 bytes)
55191(151 mod 256): READ	0x15a06 thru 0x212c0	(0xb8bb bytes)
55192(152 mod 256): TRUNCATE DOWN	from 0x40000 to 0x1448
Correct content saved for comparison
(maybe hexdump "testfile" vs "testfile.fsxgood")

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=typescript

Script started on Thu Jan 23 14:54:14 2003
Rescue:/mnt # du -ks testfile*
2147483628	testfile
20	testfile.fsxgood
68	testfile.fsxlog
Rescue:/mnt # exit

Script done on Thu Jan 23 14:54:26 2003

--h31gzZEtNLTqOjlF--
