Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTEHXci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTEHXci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:32:38 -0400
Received: from NODE-1.HOSTING-NETWORK.COM ([66.186.193.1]:19218 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id S262156AbTEHXce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:32:34 -0400
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 64.122.104.99
X-Authenticated-Timestamp: 19:50:27(EDT) on May 08, 2003
X-HELO-From: [10.134.0.76]
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 64.122.104.99
Subject: ALSA busted in 2.5.69
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052437191.1205.4.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 16:39:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ALSA isn't working for me in 2.5.69.  It appears to be because
/proc/asound/dev is missing the control devices.

lsmod says I have:

Module                  Size  Used by
snd_cmipci             22168  -
snd_pcm                59968  -
snd_page_alloc          4140  -
snd_opl3_lib            5896  -
snd_timer              13888  -
snd_hwdep               4096  -
snd_mpu401_uart         3144  -
snd_rawmidi            12768  -
snd                    29156  -
soundcore               3296  -

and no errors were reported while loading those modules,
but "ls -l /proc/asound/dev" shows only:
total 0
crw-rw-rw-    1 root     root     116,  33 May  8 16:37 timer

and all the alsa utilities die trying to open other entries under
/dev/snd, which is a symlink to /proc/asound/dev (as set up by the
ALSA script.)

For instance, strace alsamixer shows this at the end:

access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or
directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC0", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC0", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC0", O_RDWR)      = -1 ENOENT (No such file or
directory)
open("/dev/snd/controlC0", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/dev/aloadC0", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/controlC0", O_RDWR)      = -1 ENOENT (No such file or
directory)
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x40017000
write(1, "\n", 1
)                       = 1
write(2, "alsamixer: function snd_ctl_open"..., 79alsamixer: function
snd_ctl_open failed for default: No such file or directory
) = 79
munmap(0x40017000, 4096)                = 0
exit_group(1)                           = ?

Suggestions???


-- 
Torrey Hoffman <thoffman@arnor.net>

