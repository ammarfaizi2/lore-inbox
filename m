Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265994AbUGEKDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUGEKDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 06:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbUGEKDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 06:03:31 -0400
Received: from zasran.com ([198.144.206.234]:42624 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S265987AbUGEKDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 06:03:11 -0400
Message-ID: <40E9275C.2010707@bigfoot.com>
Date: Mon, 05 Jul 2004 03:03:08 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040702 Debian/1.7-3
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: modprobe -v snd-seq-oss freezes (sb live! kernel 2.6.5)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   alsa used to work on my system, I didn't change anything I think
might be related and suddenly the modprobe -v snd-seq-oss freezes (does 
not return, cannot be interrupted either but the rest of the system 
(including audio and alsa native midi) works OK).

   system:

   debian unstable
   kernel 2.6.5 (with alsa)

   I did not change kernel or modules (I checked and there are no
new/changed files under /lib/modules/2.6.5) yet suddenly (after reboot)
the oss sequencer cannot be loaded. There are no (related) messages in
/var/log/syslog.

   jojda:/home/erik# modprobe -v snd-seq-oss
insmod /lib/modules/2.6.5/kernel/sound/core/seq/snd-seq.ko
insmod /lib/modules/2.6.5/kernel/sound/core/seq/snd-seq-midi-event.ko
insmod /lib/modules/2.6.5/kernel/sound/core/seq/oss/snd-seq-oss.ko

   and the modprobe does not exit, it just sits there. udev creates
devices (see below) but there are not usable, e.g.:

jojda:/var/log# sfxload /data/music/soundfont/creative/8MBGMSFX.SF2
/dev/sequencer: No such device

   udev says (in daemon.log):

Jul  5 01:18:24 jojda udev[2821]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 38 applied, 'midiC0D2' becomes
'snd/%k'
Jul  5 01:18:24 jojda udev[2821]: creating device node '/dev/snd/midiC0D2'
Jul  5 01:18:25 jojda udev[2791]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 36 applied, 'hwC0D2' becomes 'snd/%k'
Jul  5 01:18:25 jojda udev[2791]: creating device node '/dev/snd/hwC0D2'
Jul  5 01:18:25 jojda udev[2798]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 38 applied, 'midiC0D1' becomes
'snd/%k'
Jul  5 01:18:25 jojda udev[2798]: creating device node '/dev/snd/midiC0D1'
Jul  5 01:18:25 jojda udev[2768]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 40 applied, 'seq' becomes 'snd/%k'
Jul  5 01:18:25 jojda udev[2768]: creating device node '/dev/snd/seq'
Jul  5 01:18:25 jojda udev[2775]: creating device node '/dev/sequencer'
Jul  5 01:18:25 jojda udev[2782]: creating device node '/dev/sequencer2'
Jul  5 01:18:25 jojda udev[2805]: creating device node '/dev/amidi'
Jul  5 01:18:25 jojda udev[2812]: creating device node '/dev/admmidi'
Jul  5 01:20:22 jojda ntpd[2392]: kernel time sync enabled 0001

   any ideas on how to troubleshoot this?

   TIA,

	erik

