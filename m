Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316825AbSFQGv6>; Mon, 17 Jun 2002 02:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316824AbSFQGuF>; Mon, 17 Jun 2002 02:50:05 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:9194 "EHLO
	wmailout2.bigpond.com") by vger.kernel.org with ESMTP
	id <S316788AbSFQGsh>; Mon, 17 Jun 2002 02:48:37 -0400
From: harisri <harisri@telstra.com>
To: linux-kernel@vger.kernel.org
Message-ID: <55b2355f4c.55f4c55b23@bigpond.com>
Date: Mon, 17 Jun 2002 16:48:29 +1000
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: "tail /dev/zero" hangs 2.4.19-pre10aa2 but not -pre10 and
 -pre10ac2
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

tail /dev/zero (ran as a normal user) hangs 2.4.19-pre10aa2 but not 
-pre10 and -pre10ac2.

In case of -pre10aa2:

The vmstat output just before it started killing processes, and 
later hang (ie, the vmstat itself hang):
   procs                      memory    swap          io     system         
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  
sy  id
 0  0  0      0  92428   5420  14752   0   0   331   118  146   116  16  
13  71
 0  0  0      0  92276   5568  14752   0   0     0    53  109     6   0   
0 100
 0  0  0      0  91264   5652  14752   0   0     0    23  114    19   1   
0  99
 0  0  0      0  90760   5864  14808   0   0     8    58  113    16   0   
1  99
 2  1  1  40836   1528   1512   5016  78 5789    83  5802  241   250  19  
12  69
 1  0  1 101168   1912   1512   5012  95 7930    95  7935  245   267  10  
13  77
 2  0  2 152560   1500   1512   5012  62 8098    62  8098  243   200  10  
21  70

With greater difficulty I was able to login (it killed the telnet 
session many times, at various stages). 

Some sample messages from dmesg:
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process tail
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)

Multiply the "__alloc_pages" error message by 100 times or so.

And,
VM: killing process smbd

In the same way it killed run-crons, login, in.telnetd, tcpd, inetd and 
X.

Though it killed the root cause - "tail" command, commands like 
ps/top/reboot etc hang, vmstat got killed initially and hung later, su 
got killed, sync works fine. I am unable to switch between virtual 
terminals at the console using ctrl alt F1/F2.

In case of -pre10 and -pre10ac2:
It thrashes initially for about 10 secs (approx) and then everything is 
back to normal. There is a single line of "Out of Memory: killed process   
403 (tail)" (of course the process id of tail is different between 
-pre10 and -pre10ac2). And the system comes back to normal state.


This is a:
Pentium - II @ 333 MHz
128 MB RAM,
150 MB swap,
gcc-2.95.2,
suse 7.1

I am not subscribed to lkml, please cc me if you can, else I will refer 
the web archive at marctheaimsgroup.com

Thanks
Hari
harisri@bigpond.com


