Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317790AbSGVUcF>; Mon, 22 Jul 2002 16:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317791AbSGVUcF>; Mon, 22 Jul 2002 16:32:05 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:61454 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317790AbSGVUcE>;
	Mon, 22 Jul 2002 16:32:04 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Mon, 22 Jul 2002 22:34:44 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Block devices in pagecache, fsck, and what's going on...
X-mailer: Pegasus Mail v3.50
Message-ID: <BA7A23202E6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I've noticed very bad problem few weeks ago, but I thought that it
is just some bad accident. But today it happened again.

  Say that for some reason kernel will crash (such as missing read_unlock...)
and you have to hard reboot it.

  Now you reboot, and system runs e2fsck, which removes couple of 
/var/run/*.pid entries.

  It was not severe, so initscripts (Debian unstable) remount root read-write,
and continue booting. And now - oops - first cleanup script complains
that it could not remove these *.pid files because of -EIO, and shortly
after that filesystem is remounted read-only because of "Freeing blocks not
in datazone - block = 271450112, count=56; block = 32768, count = 2564"
and it goes downhill very quickly...

  After reboot fsck it says that entries xxx.pid in /var/run has deleted/unused
inode yyy, and if I do not reboot, there is very high chance that it
will die again.

  If I reboot after running e2fsck, everything is fine. Always.
  
  My question is very simple: is this intended behavior of non-coherent
cache between /dev/hda1 and ext2 layer (which also makes dump to crash),
or is it something missing in e2fsck (1.27), or is it Debian bug and
it is now required to reboot machine after any run of e2fsck on /
partition?
                                    Thanks,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz

P.S.: BTW, I find it very strange that in /var/log/* I can have
written: "Can't open file /var/cache/samba/browse.dat.. Error was Read-only
file system" when /var/log/* lives on same filesystem as /var/cache...
and also all remounting-readonly messages are here, written to same
partition which was remounted-read only due to these fatal errors.
                                        
