Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278604AbRJSTAP>; Fri, 19 Oct 2001 15:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278605AbRJSS7z>; Fri, 19 Oct 2001 14:59:55 -0400
Received: from marine.sonic.net ([208.201.224.37]:50300 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S278604AbRJSS7s>;
	Fri, 19 Oct 2001 14:59:48 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Fri, 19 Oct 2001 11:59:37 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: e2fsck, LVM and 4096-char block problems
Message-ID: <20011019115937.A10588@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using Linus' 2.4.10, unpatched.  (Perhaps I need to patch the LVM stuff ;-)

I wanted to extend /usr/src from 19G to 20G.

I umounted /usr/src, lvextend -L +1G /dev/vg01/src, fsck -f /usr/src,
resize2fs /dev/vg01/src

resize2fs tells me to run fsck.  Hmmmm... I just did.

I poke around a bit more and notice the following:

Oct 19 11:45:41 thune kernel: ll_rw_block: device 3a:00: only 4096-char
blocks implemented (1024)

Of course, dumpe2fs says:
Block size:               4096

I tried -f on the resize, and got LOTS of the 4096-char messages.

Some perhaps pertinent information.

thune:~# vgdisplay /dev/vg01
--- Volume group ---
VG Name               vg01
VG Access             read/write
VG Status             available/resizable
VG #                  0
MAX LV                256
Cur LV                9
Open LV               8
MAX LV Size           255.99 GB
Max PV                256
Cur PV                5
Act PV                5
VG Size               150.29 GB
PE Size               4 MB
Total PE              38473
Alloc PE / Size       28746 / 112.29 GB
Free  PE / Size       9727 / 38 GB
VG UUID               xdzl14-LsZ2-IA1c-dGk4-F8EK-xPlt-DV31mQ


thune:~# lvdisplay /dev/vg01/src
--- Logical volume ---
LV Name                /dev/vg01/src
VG Name                vg01
LV Write Access        read/write
LV Status              available
LV #                   1
# open                 0
LV Size                19 GB
Current LE             4864
Allocated LE           4864
Allocation             next free
Read ahead sectors     120
Block device           58:0


Obviously I have the option of creating a new volume and moving things over
to that, but that sort of defeats the purpose of these particular tools.

Recommended course of action?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
