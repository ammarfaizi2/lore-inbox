Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314702AbSFYK5M>; Tue, 25 Jun 2002 06:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSFYK5M>; Tue, 25 Jun 2002 06:57:12 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:49851 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S314702AbSFYK5L>; Tue, 25 Jun 2002 06:57:11 -0400
Date: Tue, 25 Jun 2002 06:58:37 -0400
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
Message-ID: <20020625105837.GA12264@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe Randy Hron (added to Cc) can find some spare time
> to benchmark these sometime before the summit too[1]. 

dbench isn't scaling as well with the -rmap13b patch.
With 128 processes, dbench throughput is less than 1/3
of mainline.

dbench ext2 32 processes   Average     High        Low
2.5.24                      28.24     28.84      27.30 mb/sec
2.5.24-rmap13b              21.64     23.50      19.71

dbench ext2 128 processes  Average     High        Low
2.5.24                      19.32     21.05      18.05
2.5.24-rmap13b               5.34      5.38       5.30

tiobench:
Sequential reads, rmap had about 10% more throughput 
and lower max latency.  
For random reads, throughput was lower and max latency 
was higher with rmap.  

Lmbench:
Most metrics look better with rmap.  Exceptions
are fork/exec latency and mmap latency.  mmap
latency was 18% higher with rmap.

Autoconf build (fork test) was about 5% faster
without rmap.

Details at:
http://home.earthlink.net/~rwhron/kernel/latest.html

-- 
Randy Hron

