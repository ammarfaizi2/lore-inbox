Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTKCAQF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 19:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTKCAQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 19:16:05 -0500
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:41738 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S261873AbTKCAQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 19:16:02 -0500
Date: Sun, 2 Nov 2003 18:15:56 -0600 (CST)
From: Derek Foreman <manmower@signalmarketing.com>
X-X-Sender: manmower@uberdeity
To: Andrew Morton <akpm@osdl.org>
cc: ahuisman@cistron.nl, linux-kernel@vger.kernel.org, nuno.silva@vgertech.com
Subject: Re: READAHEAD
In-Reply-To: <20031031012946.3adedc14.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0311021645260.853@uberdeity>
References: <bnrdqi$uho$1@news.cistron.nl> <20031030134407.0c97c86e.akpm@osdl.org>
 <3FA25377.3050207@cistron.nl> <20031031012846.48fa233c.akpm@osdl.org>
 <20031031012946.3adedc14.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003, Andrew Morton wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Please, just use time, cat, dd, etc.
> >
> >  	mount /dev/xxx /mnt/yyy
> >  	dd if=/dev/zero of=/mnt/yyy/x bs=1M count=1024
> >  	umount /dev/xxx
> >  	mount /dev/xxx /mnt/yyy
> >  	time cat /mnt/yyy/x > /dev/null
>
> And you can do the same against /dev/hdaN if you have a scratch
> partition; that would be interesting.

I don't have a scratch partition, but the effect is quite apparent when
reading from /dev/hd*

I have 384 megs of ram, no swap, and echo 0 > /proc/sys/vm/swappiness
kernel is 2.6.0-test9

hdparm -qa 0 /dev/hde ; dd if=/dev/hde of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes transferred in 103.038178 seconds (10420815 bytes/sec)

hdparm -qa 128 /dev/hde ; dd if=/dev/hde of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes transferred in 34.171719 seconds (31421943 bytes/sec)

hdparm -qa 256 /dev/hde ; dd if=/dev/hde of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes transferred in 34.994348 seconds (30683293 bytes/sec)

hdparm -qa 4096 /dev/hde ; dd if=/dev/hde of=/dev/null bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes transferred in 22.268371 seconds (48218247 bytes/sec)

(hdparm -t /dev/hde opens /dev/hde and reads it for a few seconds, so
these numbers are much the same as my hdparm -t scores)

I also get similar results from /dev/md0 in another machine (the only
not-ide device I can test on... but it's still a bunch of ide drives).

note...
For people playing with hdparm, hdparm -a 123 -t /dev/drive doesn't set
the readahead before running the test.
