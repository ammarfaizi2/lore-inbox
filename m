Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271924AbTHKGKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 02:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272141AbTHKGKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 02:10:39 -0400
Received: from [66.45.37.187] ([66.45.37.187]:41908 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S271924AbTHKGKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 02:10:34 -0400
Date: Sun, 10 Aug 2003 17:16:11 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic (NFS, 2.4.2[0-1])
Message-ID: <Pine.LNX.4.56.0308101710110.10609@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From /etc/fstab:
p500:/d1/x       /p500/x          nfs         rw,hard,intr,rsize=65536,wsize=65536,nfsvers=3 0 0

A small for loop in bash causes 2.4.20 to panic, and 2.4.21 to have
massive network packet loss.

for i in `seq 1 10`
do
  /usr/bin/time /bin/cp /p500/x/20GB . ; rm -f 20GB; sync; sleep 5
done

I left the box unattended for an hour or two, I return to find the screen
black, and the and caps key and scroll lock key blinking, however the
numlock key was not blinking.

The run before it crashed was:
-rw-r--r--    1 war      wheel        1.4G 2003-08-10 15:25 20GB

I no longer run any binary only modules.

The modules I run are:

war@war:~$ lsmod
Module                  Size  Used by    Not tainted
w83781d                20656   0
i2c-isa                 1160   0 (unused)
i2c-algo-pcf            5404   0 (unused)
i2c-algo-bit            7624   0 (unused)
i2c-dev                 4452   0 (unused)
i2c-proc                7152   0 [w83781d]
i2c-core               13060   0 [w83781d i2c-isa i2c-algo-pcf i2c-algo-bit i2c-dev i2c-proc]
emu10k1                62344   0
ac97_codec             11080   0 [emu10k1]
sound                  58196   0 [emu10k1]
war@war:~$

I will once again run this loop and see if I can get it to produce the
same result or similiar behavior.

I have an Intel i875 based motherboard (Abit IC7-G), P4 2.6GHZ C w/HT
enabled.

So far, the only way it seems to die/messup/etc, is doing large file
transfer operations over NFS.

Also, incase you are wondering, I have used memtest86 several times, and
the ram (2GB) (4x512(333 DDR)) ram passes all tests with no errors.

If anyone has any idea what could be wrong, I'd love to hear them...
