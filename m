Return-Path: <linux-kernel-owner+w=401wt.eu-S1030190AbXALTr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbXALTr0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 14:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbXALTr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 14:47:26 -0500
Received: from [212.12.190.102] ([212.12.190.102]:33210 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030182AbXALTrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 14:47:25 -0500
X-Greylist: delayed 818 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 14:47:23 EST
From: Al Boldi <a1426z@gawab.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Linux Software RAID 5 Performance Optimizations: 2.6.19.1: (211MB/s read & 195MB/s write)
Date: Fri, 12 Jan 2007 22:49:13 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, xfs@oss.sgi.com
References: <Pine.LNX.4.64.0701111832080.3673@p34.internal.lan> <Pine.LNX.4.64.0701120934260.21164@p34.internal.lan> <Pine.LNX.4.64.0701121236470.3840@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0701121236470.3840@p34.internal.lan>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701122235.30288.a1426z@gawab.com>
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> RAID 5 TWEAKED: 1:06.41 elapsed @ 60% CPU
>
> This should be 1:14 not 1:06(was with a similarly sized file but not the
> same) the 1:14 is the same file as used with the other benchmarks.  and to
> get that I used 256mb read-ahead and 16384 stripe size ++ 128
> max_sectors_kb (same size as my sw raid5 chunk size)

max_sectors_kb is probably your key. On my system I get twice the read 
performance by just reducing max_sectors_kb from default 512 to 192.

Can you do a fresh reboot to shell and then:
$ cat /sys/block/hda/queue/*
$ cat /proc/meminfo
$ echo 3 > /proc/sys/vm/drop_caches
$ dd if=/dev/hda of=/dev/null bs=1M count=10240
$ echo 192 > /sys/block/hda/queue/max_sectors_kb
$ echo 3 > /proc/sys/vm/drop_caches
$ dd if=/dev/hda of=/dev/null bs=1M count=10240


Thanks!

--
Al

