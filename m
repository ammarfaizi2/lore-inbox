Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSINPt1>; Sat, 14 Sep 2002 11:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSINPt1>; Sat, 14 Sep 2002 11:49:27 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:39307 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316842AbSINPt0>; Sat, 14 Sep 2002 11:49:26 -0400
Date: Sat, 14 Sep 2002 11:57:25 -0400
To: linux-kernel@vger.kernel.org
Subject: irman takes 50x longer without O(1) on uniprocessor
Message-ID: <20020914155725.GA12337@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed running irman on uniprocessor with the 
O(1) scheduler takes a lot less time than the mainline
scheduler.  Only 2.4.20-pre5 and 2.4.20-pre6 below don't 
have a version of the O(1) scheduler:

			 seconds to run irman 3 times
2.4.20-pre4-ac1		  1420
2.4.20-pre5-ac1		  1872
2.4.20-pre5		162088
2.4.20-pre5aa1		  2264
2.4.20-pre5aa2		  2274
2.4.20-pre6		111651
2.5.32-viro-mm1		  2209
2.5.33-mm1-poll		  2168
2.5.33-mm1		  1679
2.5.33-mm5		  2374
2.5.33			  2408

There are some differences in context switch, user, and
system times between O(1) haves and have nots.  Oddly, the
user time without O(1) is higher, yet it takes longer to 
complete.  

vmstat 60 on 2.4.20-pre6
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 3  0  0   2012 364212  10468   2264   0   0     0     1  100 27467  18  82   0
 2  0  0   2012 364172  10492   2268   0   0     0     1  100 27488  18  82   0
 2  0  0   2012 364144  10508   2268   0   0     0     1  100 27555  18  82   0

vmstat 60 on 2.4.20-pre5-ac1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 3  0  0   1692 365848   1488   7756   0   0     0     1  100 36821   4  96   0
 2  0  0   1692 365832   1504   7756   0   0     0     1  100 37334   6  94   0
 3  0  0   1692 365816   1520   7756   0   0     0     1  100 37005   5  95   0

Quad xeon doesn't have a huge difference in "real"
time to run irman.

Does anyone know what would cause a 50-100x difference in time 
to execute irman on uniprocessor?  

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

