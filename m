Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUEFVTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUEFVTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUEFVTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:19:45 -0400
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:3716
	"HELO fargo") by vger.kernel.org with SMTP id S261239AbUEFVTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:19:35 -0400
Date: Thu, 6 May 2004 23:19:34 +0200
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: linux-kernel@vger.kernel.org
Subject: events kthread gone crazy
Message-ID: <20040506211934.GA1452@fargo>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all ;),

I'm running kernel 2.6.5. I had running aMule and decided to preview
a file, using xine. Then, suddenly, xine opened but hanged and the
machine started to feel unresponsive and sluggish. I guessed that
the xine process was in D state, so i did a 'ps' and found this mess:

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:04 init           
    2 ?        RWN    0:00 [ksoftirqd/0]
    3 ?        SW<    0:01 [events/0]
    4 ?        SW<    0:00  \_ [kblockd/0]
    7 ?        SW     0:00  \_ [pdflush]
    8 ?        SW     0:01  \_ [pdflush]
   10 ?        SW<    0:00  \_ [aio/0]
11566 ?        SW<    0:00  \_ [events/0]
11567 ?        S<     0:00  |   \_ /sbin/modprobe -q -- sound_service_0_3
11568 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11569 ?        SW<    0:00  \_ [events/0]
11570 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11571 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11572 ?        SW<    0:00  \_ [events/0]
11573 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11574 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11575 ?        SW<    0:00  \_ [events/0]
11576 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11577 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11578 ?        SW<    0:00  \_ [events/0]
11579 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11580 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11581 ?        SW<    0:00  \_ [events/0]
11582 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11583 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11584 ?        SW<    0:00  \_ [events/0]
11585 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11586 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11587 ?        SW<    0:00  \_ [events/0]
11588 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11589 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11590 ?        SW<    0:00  \_ [events/0]
11591 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11592 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11593 ?        SW<    0:00  \_ [events/0]
11594 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11595 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11596 ?        SW<    0:00  \_ [events/0]
11597 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11598 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11599 ?        SW<    0:00  \_ [events/0]
11600 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11601 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11602 ?        SW<    0:00  \_ [events/0]
11603 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11604 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11605 ?        SW<    0:00  \_ [events/0]
11606 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11607 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11608 ?        SW<    0:00  \_ [events/0]
11609 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11610 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11611 ?        SW<    0:00  \_ [events/0]
11612 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11613 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11614 ?        SW<    0:00  \_ [events/0]
11615 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11616 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11617 ?        SW<    0:00  \_ [events/0]
11618 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11619 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11620 ?        SW<    0:00  \_ [events/0]
11621 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11622 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11623 ?        SW<    0:00  \_ [events/0]
11624 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11625 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11626 ?        SW<    0:00  \_ [events/0]
11627 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11628 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11629 ?        SW<    0:00  \_ [events/0]
11630 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11631 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11632 ?        SW<    0:00  \_ [events/0]
11633 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11634 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11635 ?        SW<    0:00  \_ [events/0]
11636 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11637 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11638 ?        SW<    0:00  \_ [events/0]
11639 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11640 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11641 ?        SW<    0:00  \_ [events/0]
11642 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11643 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11644 ?        SW<    0:00  \_ [events/0]
11645 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11646 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11647 ?        SW<    0:00  \_ [events/0]
11648 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11649 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11650 ?        SW<    0:00  \_ [events/0]
11651 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11652 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11653 ?        SW<    0:00  \_ [events/0]
11654 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11655 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11656 ?        SW<    0:00  \_ [events/0]
11657 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11658 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11659 ?        SW<    0:00  \_ [events/0]
11660 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11661 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11662 ?        SW<    0:00  \_ [events/0]
11663 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11664 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11665 ?        SW<    0:00  \_ [events/0]
11666 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11667 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11668 ?        SW<    0:00  \_ [events/0]
11669 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11670 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11671 ?        SW<    0:00  \_ [events/0]
11672 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11673 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11674 ?        SW<    0:00  \_ [events/0]
11675 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11676 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11677 ?        SW<    0:00  \_ [events/0]
11678 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11679 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11680 ?        SW<    0:00  \_ [events/0]
11681 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11682 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11683 ?        SW<    0:00  \_ [events/0]
11684 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11685 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11686 ?        SW<    0:00  \_ [events/0]
11687 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11688 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11689 ?        SW<    0:00  \_ [events/0]
11690 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11691 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11692 ?        SW<    0:00  \_ [events/0]
11693 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11694 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11695 ?        SW<    0:00  \_ [events/0]
11696 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11697 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11698 ?        SW<    0:00  \_ [events/0]
11699 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11700 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
11701 ?        SW<    0:00  \_ [events/0]
11702 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_0
11703 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
18729 ?        SW<    0:00  \_ [events/0]
18730 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116
18731 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
31027 ?        SW<    0:00  \_ [events/0]
31028 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116
31029 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
31745 ?        SW<    0:00  \_ [events/0]
31746 ?        S<     0:00  |   \_ /sbin/modprobe -q -- char_major_116_96
31747 ?        D<     0:00  |       \_ /usr/sbin/alsactl restore
31748 ?        SW<    0:00  \_ [events/0]
31749 ?        S<     0:00      \_ /sbin/modprobe -q -- char_major_116_0
31750 ?        R<     0:00          \_ /usr/sbin/alsactl restore
    5 ?        SW     0:00 [khubd]
    6 ?        SW     0:00 [kapmd]
    9 ?        SW     0:00 [kswapd0]
   11 ?        SW     0:00 [kseriod]
   12 ?        SW     0:10 [kjournald]
   54 ?        S      0:01 proftpd: (accepting connections)
   57 ?        SN     0:00 qmail-send
   62 ?        SN     0:00  \_ splogger qmail
   63 ?        SN     0:00  \_ qmail-lspawn ./Mailbox
   64 ?        SN     0:00  \_ qmail-rspawn
   65 ?        SN     0:00  \_ qmail-clean
   67 ?        S      0:00 fcron -b -d
   73 ?        S      0:00 sshd
   80 ?        SN     0:00 tcpserver -u huma -g users -l 0 0 25 /var/qmail/bin/qmail-smtpd
   85 tty3     S      0:00 into           
   86 tty4     S      0:00 into           
   87 tty5     S      0:00 into           
   88 tty6     S      0:00 -zsh
  193 tty6     RN   671:47  \_ ./setiathome -verbose
   89 tty7     S      0:00 into           
   90 tty8     S      0:00 into           
   91 tty9     S      0:00 into           
   92 ?        S      0:00 slog           
   93 ?        S      0:00 klog           
   97 tty1     S      0:00 -zsh
31751 tty1     R      0:00  \_ ps axf
  103 tty12    S      0:02 fetchmail -a -d 360 --logfile /dev/tty12
11556 tty2     S      0:00 into           
11560 tty1     D      0:01 xine /home/huma/.aMule/Temp/006.part


I don't think is related to, but these are the lines that i have
in modprobe.conf:

# This is for ALSA
alias char-major-116 snd
alias sb snd-card-0
alias snd-card-0 snd-ens1371

alias snd-card-1 off
alias snd-card-2 off
alias snd-card-3 off
alias sound-slot-1 off
alias sound-service-1-0 off

# And this for OSS emulation
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

# Preserve mixer settings
install snd /usr/sbin/alsactl restore
remove snd /usr/sbin/alsactl store


Any ideas about the cause of this problem?

Thanks,

-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
