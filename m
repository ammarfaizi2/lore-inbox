Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129129AbQJZShP>; Thu, 26 Oct 2000 14:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbQJZShF>; Thu, 26 Oct 2000 14:37:05 -0400
Received: from brutus.conectiva.com.br ([200.250.58.146]:29941 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129129AbQJZShD>; Thu, 26 Oct 2000 14:37:03 -0400
Date: Thu, 26 Oct 2000 16:36:37 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: mauelshagen@sistina.com
cc: linux-kernel@vger.kernel.org
Subject: LVM snapshotting broken?
Message-ID: <Pine.LNX.4.21.0010261632440.15696-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heinz,

it looks like the LVM snapshotting in 2.4 doesn't allow you
to create snapshots from anything else than the _first_ LV
in the VG...

I have run both the following command lines (after lvremoving
snap1, of course) and both of them give as a result that the
LV /dev/test_vg/swap ends up being the snapshotted filesystem ;(

# lvcreate -s -L100 -nsnap1 /dev/test_vg/test
# lvcreate -s -L100 -nsnap1 /dev/test_vg/swap

# cat /proc/lvm
LVM driver version 0.8final  (15/02/2000)

	<snip VG/PV info>

    LVs: [AWDL  ] swap            122880 /30       1x open
         [AWDL  ] test            204800 /50       1x open
         [ARDL  ] snap1           122880 /30       close

It looks like somewhere in either the utilities or the
kernel, the argument of which LV to snapshot gets mangled...
Oh, I'm using version 0.8final of the LVM utities.

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
