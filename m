Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbTDZBjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 21:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbTDZBjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 21:39:53 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:56997 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264584AbTDZBjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 21:39:51 -0400
Date: Fri, 25 Apr 2003 21:58:56 -0400
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.68 and 2.5.68-mm2
Message-ID: <20030426015856.GA2286@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> The autoconf-2.53 make/make check is a fork test.   2.5.68
>> is about 13% faster here.

> I wonder why.  Which fs was it?

That was on ext2.  There isn't much i/o on autoconf "make check".
It's a lot of small perl scripts, m4 and gcc on tiny files.

>> On the AIM7 database test, -mm2 was about 18% faster and

> iirc, AIM7 is dominated by lots of O_SYNC writes.  I'd have expected the
> anticipatory scheduler to do worse.  Odd.  Which fs was it?

That was ext2 too.

> tiobench will create a bunch of processes, each growing a large file, all
> in the same directory.  

> The benchmark is hitting a pathologoical case.  Yeah, it's a problem, but
> it's not as bad as tiobench indicates.

Oracle doing reads/writes to preallocated, contiguous files is more 
important than tiobench.  Oracle datafiles are typically created
sequentially, which wouldn't exercise the pathology.

I pay more attention the OSDL-DBT-3 and "Winmark I" numbers than 
the i/o stuff I run.  (I look at my numbers more, but care about
theirs more).

What about the behavior where CPU utilization goes down as thread
count goes up?  Is she just i/o bound?

Sequential Reads ext2
	       Num                 
Kernel         Thr   Rate   (CPU%)  
----------     ---   -----  ------
2.5.68           8   36.65  18.04%  
2.5.68-mm2       8   23.96  11.15%  

2.5.68         256   34.10  16.88%  
2.5.68-mm2     256   18.84   8.96%  

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

