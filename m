Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266211AbUFPHqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266211AbUFPHqD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 03:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266213AbUFPHqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 03:46:03 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:24433 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266211AbUFPHp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 03:45:58 -0400
Message-ID: <40CFFAAF.7070905@yahoo.com.au>
Date: Wed, 16 Jun 2004 17:45:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Guy Van Sanden <n.b@myrealbox.com>
CC: Clint Byrum <cbyrum@spamaps.org>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Heavy iowait on 2.6 kernels
References: <1086942905.10540.69.camel@cronos.home.vsb>	 <1087366549.1190.6.camel@lancelot> <1087369893.11205.36.camel@cronos.home.vsb>
In-Reply-To: <1087369893.11205.36.camel@cronos.home.vsb>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guy Van Sanden wrote:
> My machine is heavily used for all kinds of file serving (mainly nfs),
> but also samba.
> Next to that, it is my home-server, so it runs apache2 (tuned to server
> only few clients), imap (cyrus), postfix, bugzilla (mysql) and distcc
> (used only a few times a week).
> It replaces a FreeBSD system (PII-333) running the same except distcc.
> Under 
> 
> The disk system is just a regular IDE disk (udma5) (60GB) and one
> external drive over USB2 (160 GB).  The external drive is rather slow
> (20-30 MB/sec), so I disabled it during the tests.
> 
> The weird thing is that I see this problem too when only running bonnie.
> A friend of mine tried that too under 2.6.6, his iowait went up to
> 0.15%, mine to 99%.
> 

The CPU can very easily max out the disks of course. If bonnie is
doing IO to files much larger than memory, it wouldn't be surprising
for io-wait to get close to 100%. Possibly your friend was doing all
IO out of cache?

If you definitely have a performance problem, set "Kernel Debugging"
on in the "Kernel Hacking" menu, then set "Magic SysRq key" on. When
your system hits this iowait problem, press Alt+SysRq+T a couple of
times over a few seconds.

Then post the output of `dmesg -s 1000000`.

We'll see what is waiting where.
