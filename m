Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263365AbRFAE3K>; Fri, 1 Jun 2001 00:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263370AbRFAE3B>; Fri, 1 Jun 2001 00:29:01 -0400
Received: from ci176196-a.grnvle1.sc.home.com ([24.4.120.228]:55424 "EHLO
	thrillseeker.net") by vger.kernel.org with ESMTP id <S263366AbRFAE2y>;
	Fri, 1 Jun 2001 00:28:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15127.6599.71158.430051@www.thrillseeker.net>
Date: Fri, 1 Jun 2001 00:27:51 -0400
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
To: alan@lxorguk.ukuu.org.uk, vichu@digitalme.com, riel@conectiva.com.br
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 VM
In-Reply-To: <alan@lxorguk.ukuu.org.uk> Thursday, 31 May 2001 23:57:23 +0100
In-Reply-To: <3B16CC23.1020202@digitalme.com>
	<E155bNb-0008BK-00@the-village.bc.nu>
X-Mailer: VM 6.89 under 21.4 (patch 1) "Copyleft" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > > Actually I have tried 1x,2x,3x.  In 2.4.0 to 2.4.3 I had some issues but 
 > > never a system freeze of any kind.  With 2.4.4 I had more problems, but 
 > > I was ok.  2.4.5 I now have these freezes.  Maybe I should go back to 
 > > 2x, but I still find this behavior crazy.
 > > This still doesn't negate the point of freeing simple caches.
 > 
 > The caches are in part shared. Remember page cache memory and read only
 > application pages are the same thing - so its not that simple. I found 2.4.5
 > pretty bad. 2.4.5-ac seems to be better on the whole but I know its definitely
 > not right yet. Marcelo and Rik are working on that more and more.
 > 
 > Marcelo has a test patch to fix the (documented but annoying) 2x memory
 > swap rule stuff. The balancing problem is harder but being worked on.
 > 
 > If you can give Rik a summary of your config/what apps run/ps data then it
 > may be valuable as he can duplicate your exact setup for testing his
 > vm changes and add it to the test sets.
 > 
 > Alan

As a data point, running 2.4.5-ac1 on a Thinkpad with 512M ram and 1G
swap partition, I used the imagemagick programs to manipulate a couple
of dozen large images that would create intermediate images a little
over 1G in size.

This would totally freeze the system for interactive use.  Left alone,
the system was stable, nothing was killed by the system, and
everything recovered fine, however once the swap started, nothing else
could be initiated or even monitored.  Even the xclock would freeze
solid for several minutes during the program run.  Running the same
thing under 'nice' seemed to make no difference.

Running X, xemacs, etc. in my standard configuraton, top looks at the
moment like (using -ac5 now) during 'idle':

 00:17:13 up 52 min,  6 users,  load average: 2.00, 2.06, 1.98
74 processes: 70 sleeping, 4 running, 0 zombie, 0 stopped
CPU states:   4.0% user,   2.2% system,  93.8% nice,   0.0% idle
Mem:    512728K total,   436120K used,    76608K free,   234380K buffers
Swap:   982792K total,     3540K used,   979252K free,    92332K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  638 weh       20  19  4344 4340   816 R N  47.2  0.8  23:16 fahclient
  614 weh       19  19 15360  15M   644 R N  47.0  2.9  23:49 setiathome
  531 root       5 -10 22948 4760  2040 S <   1.5  0.9   0:11 XFree86
  582 weh        9   0 43080  42M  3400 S     1.5  8.4   0:20 xemacs
  603 weh       11   0  1072 1072   776 R     0.5  0.2   0:19 top
  588 weh        9   0  4472 4472  1876 S     0.3  0.8   0:07 wish
    1 root       8   0   120   80    68 S     0.0  0.0   0:01 init
...

Billy
