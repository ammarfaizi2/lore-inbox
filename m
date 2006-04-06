Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWDFCet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWDFCet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 22:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWDFCet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 22:34:49 -0400
Received: from spooner.celestial.com ([192.136.111.35]:22401 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1751335AbWDFCes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 22:34:48 -0400
Date: Wed, 5 Apr 2006 22:34:45 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Bonnie++ Burps on XFS
Message-ID: <20060406023445.GB5806@kurtwerks.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.17-rc1krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using bonnie++ off and on for a long time. Suddenly, it has
started failing when run against an XFS filesystem situated on a SATA
drive. Here's the output of a run:

$ bench/sbin/bonnie++ -m "Luther 2.6.17-rc1 XFS SATA" \
> -d /archive/bench \
> -s 3008 \
> -n 1024 >> bonnie.out 2>> bonnie.err
Version: 1.03
Writing with putc()...done
Writing intelligently...done
Rewriting...done
Reading with getc()...done
Reading intelligently...done
start 'em...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...Bonnie: drastic I/O error (rmdir):
Directory not empty
Cleaning up test directory after error.

This is on a 2.6.17-rc1 Linux kernel. The interesting thing
is that not even root cannot delete the directory in which
bonnie++ is working:

[~]$ ls -ld /archive/bench/Bonnie.8426/
drwx------  2 kwall users 4096 2006-04-05 09:06 /archive/bench/Bonnie.8426/
[~]$ ls -al /archive/bench/Bonnie.8426/
total 24
drwx------  2 kwall users 4096 2006-04-05 09:06 ./
drwxr-xr-x  4 kwall users   42 2006-04-05 06:24 ../
[~]$ sudo rm -rf /archive/bench/Bonnie.8426
rm: cannot remove directory `/archive/bench/Bonnie.8426': Directory not
empty

As you can see, the directory is empty, but a "rm" fails (as does
"rmdir"). I'm retesting with a 2.6.16 kernel as I type. It isn't
clear if the problems is XFS, some other piece of the kernel, or
bonnie++. Neither dmesg nor syslog shows anything amiss. I suppose 
I could strace the run, but I'm not especially eager to deal with 
a multi-gigabyte output file if there is a more focused method to
isolate the problem.

I've also written to bonnie++'s author.

Thanks for the help.

Best regards,

Kurt
-- 
The full impact of parenthood doesn't hit you until you multiply the
number of your kids by 32 teeth.
