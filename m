Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265985AbUEUVNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUEUVNk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 17:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUEUVNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 17:13:40 -0400
Received: from [213.171.41.46] ([213.171.41.46]:6916 "EHLO
	kaamos.homelinux.net") by vger.kernel.org with ESMTP
	id S265985AbUEUVNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 17:13:36 -0400
From: Alexey Kopytov <alexeyk@mysql.com>
Organization: MySQL AB
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Random file I/O regressions in 2.6 [patch+results]
Date: Sat, 22 May 2004 01:13:30 +0400
User-Agent: KMail/1.6.2
Cc: linuxram@us.ibm.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
References: <200405022357.59415.alexeyk@mysql.com> <200405200506.03006.alexeyk@mysql.com> <20040520145902.27647dee.akpm@osdl.org>
In-Reply-To: <20040520145902.27647dee.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405220113.31136.alexeyk@mysql.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 May 2004 01:59, Andrew Morton wrote:
>The patches in Linus's tree improve sysbench significantly here.  It's a
>256MB 2-way with IDE disks, writeback caching enabled:
>
>sysbench --num-threads=16 --test=fileio --file-total-size=2G
> --file-test-mode=rndrw run
>
>2.4.27-pre2, ext2:
>
>	Time spent for test:  61.0240s
>		0.06s user 6.03s system 4% cpu 2:05.95 total
>	Time spent for test:  60.8456s
>		0.11s user 5.49s system 4% cpu 2:04.94 total
>
>2.6.6-bk, AS, ext2:
>
>	Time spent for test:  62.5316s
>		0.05s user 5.27s system 4% cpu 2:01.28 total
>	Time spent for test:  62.7401s
>		0.04s user 5.17s system 4% cpu 2:00.50 total

I ran the tests with a configuration as close to yours as possible. Here are 
the results for mem=256M, 2G total file size (ext3):

2.4.25:
       Time spent for test:  79.4146s
                0.20user 16.08system 3:20.29elapsed 8%CPU
       Time spent for test:  78.9797s
                0.11user 15.84system 3:19.76elapsed 7%CPU 

2.6.6-bk, AS:
       Time spent for test:  81.2208s
                0.13user 17.97system 3:13.30elapsed 9%CPU
       Time spent for test:  82.5538s
                0.14user 18.00system 3:14.88elapsed 9%CPU

This correlates very well your results. But when I returned back to my 
original configuration (mem=640M, 3G total file size), I got the following:

2.4.25:
       Time spent for test:  77.5377s

2.6.6-bk, AS:
       Time spent for test:  83.1929s

It seems like the smaller file size just hides the regression, but I have to 
run some more tests to ensure this.
  

>I don't know why you're still seeing significant discrepancies.
>
>What sort of disk+controller system are you using?  If scsi, what is the
>tag queue depth set to?  Is writeback caching enabled on the disk?

It's IDE disk without TCQ support with writeback caching enabled.

-- 
Alexey Kopytov, Software Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification
