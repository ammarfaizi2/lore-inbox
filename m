Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288256AbSACShV>; Thu, 3 Jan 2002 13:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287355AbSACShM>; Thu, 3 Jan 2002 13:37:12 -0500
Received: from out1.bigplanet.com ([216.169.198.51]:27065 "EHLO
	out1.bigplanet.com") by vger.kernel.org with ESMTP
	id <S288279AbSACSg7>; Thu, 3 Jan 2002 13:36:59 -0500
Date: Sun, 30 Dec 2001 07:39:10 -0500
From: Andy Gaynor <silver@silver.unix-fu.org>
Subject: losetuping files in tmpfs fails?
To: linux-kernel@vger.kernel.org
Message-id: <3C2F0AEE.ACABAAFA@silver.unix-fu.org>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst trying to figure out why my dang stripes won't persist (a separate
but worrisome issue), I wrote a dittie which creates a couple junk files in
/tmp (tmpfs), associates loop devices with them, whoops, losetup craps out.

  /home/root# losetup -d /dev/loop/5 2>/dev/null # Free /dev/loop/5

  /home/root# cd /home/root             # Go home
  /home/root# mount | grep /home        # Filesystem is ...
  /dev/md/8 on /home type reiserfs (rw) #   reiserfs
  /home/root# echo foo > foo            # Create file foo
  /home/root# losetup /dev/loop/5 foo   # Give foo to /dev/loop/5
  /home/root# losetup -d /dev/loop/5    # Free /dev/loop/5
  /home/root# rm foo                    # Remove foo

  /home/root# cd /tmp                   # Go to /tmp
  /tmp# mount | grep tmp                # Filesystem is ...
  tmpfs on /tmp type tmpfs (rw)         #   tmpfs
  /tmp# echo foo > foo                  # Create file foo
  /tmp# losetup /dev/loop/5 foo         # Give foo to /dev/loop/5
  ioctl: LOOP_SET_FD: Invalid argument  #   DISCO!!!                <o >  <o >
  /tmp# rm foo                          # Remove foo

    Version information:

  Distribution: Debian Woody, up-to-date as of a week ago
  Kernel: Linux 2.4.17

    I don't subscribe to linux-kernel@vger.kernel.org.  If you want me to
see a message, please mail it to me.  If my site is down, send to
stupid_email_tricks@mailandnews.com.  And bonk my administrator with a
wiffle bat.

Regards, [Ag]   Andy Gaynor   silver@silver.unix-fu.org
