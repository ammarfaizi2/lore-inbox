Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTFFOHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbTFFOHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:07:09 -0400
Received: from zeus.kernel.org ([204.152.189.113]:18578 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261669AbTFFOHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:07:07 -0400
Date: Fri, 6 Jun 2003 16:17:10 +0200
From: Nagy Gabor <linux42@freemail.c3.hu>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.70 module autoloading problem
Message-ID: <20030606141710.GA254@swordfish.capgemini.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I wanted to test 2.5, and so I did with 2.5.67 first, then with 2.5.70

I have installed  the module-init-tools 0.9.11-1 debian package, and now
some of my modules work automatically under 2.5 too, others don't get
autoloaded.

I don't know if this is a bug in the kernel (kmod), or just something has
changed so much without warning, that it breaks other things.

Examples:
swordfish:~# lsmod
Module                  Size  Used by
unix                   21380  2 [unsafe]
swordfish:~# ls -l /dev/input/mice
crw-r--r--    1 root     root      13,  63 May  1 11:07 /dev/input/mice
swordfish:~# X
...
(EE) xf86OpenSerial: Cannot open device /dev/psaux
        No such device.
(EE) Configured Mouse: cannot open input device
(EE) PreInit failed for input device "Configured Mouse"
(EE) xf86OpenSerial: Cannot open device /dev/input/mice
        No such device.
(EE) Generic Mouse: cannot open input device
(EE) PreInit failed for input device "Generic Mouse"
No core pointer

Fatal server error:
failed to initialize core devices

swordfish:~# modprobe char-major-13-63
input: ImPS/2 Generic Wheel Mouse on isa0060/serio2
input: PS/2 Generic Mouse on isa0060/serio4
mice: PS/2 mouse device common for all mice
swordfish:~# lsmod
Module                  Size  Used by
mousedev                7392  0
psmouse                 6404  0
unix                   21380  2 [unsafe]

Now X or gpm can start. I haven't seen any document saying what should I
write in my alias lines, in my /etc/modprobe.d/aliases file (from the
module-init-tools package) there is an alias char-major-13-63 mousedev
line.

With 2.4 and modutils, similar lines worked. How can I tell what alias
does the kernel look for?

Someone told me that I should use char_major_13_63, without explanation,
but it does not work either.

continuing the examples:
swordfish:~# mount /dev/hdb /cdrom -t iso9660
mount: /dev/hdb is not a valid block device
swordfish:~# lsmod
Module                  Size  Used by
isofs                  31136  0
zlib_inflate           21472  1 isofs
...
swordfish:~# modprobe ide-cd
end_request: I/O error, dev hdb, sector 0
hdb: ATAPI 24X CD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
swordfish:~# mount /dev/hdb /cdrom -t iso9660
mount: block device /dev/hdb is write-protected, mounting read-only
swordfish:~# lsmod
Module                  Size  Used by
nls_iso8859_1           4000  1
ide_cd                 34560  1
cdrom                  30336  1 ide_cd
isofs                  31136  1
zlib_inflate           21472  1 isofs
...

I have no alias with ide-cd anywhere. I have tried with block-major-3-64,
but it doesn't work, and I suppose it should not be needed anyway.

Also, the second half of Documentation/modules.txt seems to be pretty
outdated, it talks about kerneld instead of kmod, which I haven't been
using for years now. I think it should include a lead to help me
constructing working alias lines. It only gives 2 very simple lines of
example.

I have searched for documentation/solutions in google, but the searches
turned up only similar problems, not solutions.

Thanks in advance
Gee
