Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVAXAfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVAXAfJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 19:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVAXAfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 19:35:09 -0500
Received: from host207-193-149-62.serverdedicati.aruba.it ([62.149.193.207]:1487
	"EHLO chernobyl.investici.org") by vger.kernel.org with ESMTP
	id S261389AbVAXAe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 19:34:59 -0500
Message-ID: <41F442B0.80900@ngi.it>
Date: Mon, 24 Jan 2005 01:34:56 +0100
From: Alessandro Sappia <a.sappia@ngi.it>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: chvt issue
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI all
I was reading vt driver
and I saw
         /*
          * To have permissions to do most of the vt ioctls, we either have
          * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
          */
         perm = 0;
         if (current->signal->tty == tty || capable(CAP_SYS_TTY_CONFIG))
                 perm = 1;

(lines 382-388 - drivers/char/vt_ioctl.c)

After reading the comment I thinked I can change vt
from one of my own to another one of mine.

so I opened vc/2 and vc/3 and a pts/0
$ w
  01:26:45 up  1:33,  5 users,  load average: 0,84, 0,66, 0,97
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
alx      vc/2      01:07   18:51   0.00s  0.00s -bash
alx      vc/3      01:25   48.00s  0.00s  0.00s -bash
alx      :0        23:55   ?xdm?   4:21   0.84s gnome-session
alx      pts/0     01:22    0.00s  0.08s  0.00s w

I went to vc/3 and I did
  $ tty
/dev/vc/3
  $ chvt 2
as i expected I changed my tty to 2
after that I tryied to do the same from pts/0
and

  $ tty
/dev/pts/0
  $ chvt 2
chvt: VT_ACTIVATE: Operation not permitted
  $

After that I went in vc/2
and I did
  $ chvt 12
after that i was watching at my syslog writing messages...
I tryed the same from pts/0
and
  $ chvt 12
Couldnt get a file descriptor referring to the console

So, there are some things I couldn't get about virtual terminal ioctls 
and fd...
please note that use chvt having CAP_SYS_TTY_CONFIG (root) works fine.

Is it possible to change terminal from an unprivileged user ?

THanks in advance
for the time you'll spend answering me.

Alessandro
