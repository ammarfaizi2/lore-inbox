Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270423AbVBEQu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270423AbVBEQu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 11:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbVBEQu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 11:50:28 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:36556 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S270423AbVBEQtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 11:49:45 -0500
Message-ID: <4204F91B.5040302@free.fr>
Date: Sat, 05 Feb 2005 17:49:31 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.5) Gecko/20041217
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc3-mm1 : mount UDF CDRW stuck in D state
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8EC5C87D4E8C42B302B40582"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8EC5C87D4E8C42B302B40582
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This is kernel 2.6.11-rc3-mm1. I can't mount an UDF-formatted cdrw in packet-writing mode. Mount process gets stuck in D state.

Mounting and writing this media in packet-writing mode works fine with kernel 2.6.11-rc2-mm2.

Mounting and reading this media in normal mode (/dev/hdd on /vol/graveur type udf (ro,noexec,nosuid,nodev,noatime)) works fine with kernel 2.6.11-rc3-mm1 or older.

Note I did not try another media, this one seems good to me. The drive is a LITE-ON LTR-48125S.

below are :
- ps status
- sysreq-T output
- output of /proc/driver/pktcdvd/pktcdvd0
- cdrwtool info

----------------------------------------------------------------------------

laurent$ ps aux | grep mount
root      6782  0.0  0.1  1572  436 ?        D    17:34   0:00 /bin/mount -t udf -s -o noatime /dev/pktcdvd/0 /vol/pkt

----------------------------------------------------------------------------

Here is the output of SysRq-T for this process :

 mount         D C7E81B60     0  6782   6781                     (NOTLB)
 c7e81b64 00000082 c0381ee4 c7e81b60 00000000 4c667c40 000f4258 c74c05a0
        c74c06c4 c7e80000 c7e81bd0 c7e81b80 c7e81bb8 c0280b76 00000000 c74c05a0
        c01133a4 00000000 00000000 c021ae65 c1345e30 ffffffff 00000001 c74c05a0
 Call Trace:
  [wait_for_completion+157/266] wait_for_completion+0x9d/0x10a
  [<c0280b76>] wait_for_completion+0x9d/0x10a
  [pg0+364799100/1070007296] pkt_generic_packet+0x108/0x134 [pktcdvd]
  [<d5f7447c>] pkt_generic_packet+0x108/0x134 [pktcdvd]
  [pg0+364804125/1070007296] pkt_get_disc_info+0x3d/0x77 [pktcdvd]
  [<d5f7581d>] pkt_get_disc_info+0x3d/0x77 [pktcdvd]
  [pg0+364804344/1070007296] pkt_get_last_written+0x15/0x93 [pktcdvd]
  [<d5f758f8>] pkt_get_last_written+0x15/0x93 [pktcdvd]
  [pg0+364806861/1070007296] pkt_open_dev+0x38/0x12b [pktcdvd]
  [<d5f762cd>] pkt_open_dev+0x38/0x12b [pktcdvd]
  [pg0+364807294/1070007296] pkt_open+0x61/0xa0 [pktcdvd]
  [<d5f7647e>] pkt_open+0x61/0xa0 [pktcdvd]
  [do_open+151/803] do_open+0x97/0x323
  [<c0151d01>] do_open+0x97/0x323
  [blkdev_get+108/119] blkdev_get+0x6c/0x77
  [<c0151ff9>] blkdev_get+0x6c/0x77
  [open_bdev_excl+55/112] open_bdev_excl+0x37/0x70
  [<c01522ee>] open_bdev_excl+0x37/0x70
  [get_sb_bdev+22/283] get_sb_bdev+0x16/0x11b
  [<c0150e2a>] get_sb_bdev+0x16/0x11b
  [pg0+364950912/1070007296] udf_get_sb+0x10/0x12 [udf]
  [<d5f99580>] udf_get_sb+0x10/0x12 [udf]
  [do_kern_mount+67/186] do_kern_mount+0x43/0xba
  [<c015109a>] do_kern_mount+0x43/0xba
  [do_new_mount+108/153] do_new_mount+0x6c/0x99
  [<c016419d>] do_new_mount+0x6c/0x99
  [do_mount+309/332] do_mount+0x135/0x14c
  [<c0164827>] do_mount+0x135/0x14c
  [sys_mount+106/166] sys_mount+0x6a/0xa6
  [<c0164be8>] sys_mount+0x6a/0xa6
  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
  [<c0102bf9>] sysenter_past_esp+0x52/0x75

----------------------------------------------------------------------------

laurent$ cat /proc/driver/pktcdvd/pktcdvd0
Writer pktcdvd0 mapped to hdd:

Settings:
        packet size:            0kB
        write type:             Packet
        packet type:            Variable
        link loss:              0
        track mode:             0
        block mode:             Unknown

Statistics:
        packets started:        0
        packets ended:          0
        written:                0kB
        read gather:            0kB
        read:                   0kB

Misc:
        reference count:        1
        flags:                  0x0
        read speed:             0kB/s
        write speed:            0kB/s
        start offset:           0
        mode page offset:       0

Queue state:
        bios queued:            0
        bios pending:           0
        current sector:         0x0
        state:                  i:0 ow:0 rw:0 ww:0 rec:0 fin:0

----------------------------------------------------------------------------

[root@antares root]# cdrwtool -i -d /dev/hdd
using device /dev/hdd
1388KB internal buffer
setting write speed to 12x

DISC INFO:
        erasable : Yes
        border = 3
        Disc status = 2
        number of first track = 1
        number of sessions = 1
        number of tracks = 1
        status of last track = 1
        uru = 0
        did_v = 1
        dbc_v = 0
        disc type = 32
        disc_id = 100374
        lead_in = 255:255:255 (1166880)
        lead_out = 255:255:255 (1166880)
        OPC entries = 1

TRACK INFO:

Track 1
        track_number = 1
        session_number = 1
        damage = 0
        copy = 0
        track_mode = 7
        Rt = 1
        blank = 0
        packet = 1
        fp = 1
        data_mode = 2
        lra_v = 0
        nwa_v = 0
        track_start = 0
        next_writable = 0
        last_recorded = 0
        free_blocks = 0
        packet_size = 32
        track_size = 295264 (590528KB)

--
laurent


--------------enig8EC5C87D4E8C42B302B40582
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCBPkkUqUFrirTu6IRAlZ9AJ95e7UwLMr6gFyjFiO+c8Ff95F3fwCghywI
AiHhO93Db4gpNb0whnU2h8U=
=iQ+D
-----END PGP SIGNATURE-----

--------------enig8EC5C87D4E8C42B302B40582--
