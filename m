Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135523AbRALGVO>; Fri, 12 Jan 2001 01:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135521AbRALGVE>; Fri, 12 Jan 2001 01:21:04 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:61322 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S132941AbRALGU6>;
	Fri, 12 Jan 2001 01:20:58 -0500
Date: Thu, 11 Jan 2001 22:20:56 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: khttpd-users@zgp.org
cc: linux-kernel@vger.kernel.org
Subject: khttpd beaten by boa
In-Reply-To: <Pine.LNX.4.21.0101071655090.1110-100000@home.lameter.com>
Message-ID: <Pine.LNX.4.21.0101112214040.22231-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got into a bragging game whose webserver is the fastest with Jim Nelson
one of the authors of the boa webserver. We finally settled on the Zeus
test to decide the battle.

First boa won hands down because it supports persistant connections. Boa
on port 6000. Khttpd on port 80:
 
clameter@melchi:~$ ./zb localhost /index.html -k -c 215 -n 20000 -p 6000
 
---
Server:                 Boa/0.94.8.3
Doucment Length:        1666
Concurency Level:       215
Time taken for tests:   33.865 seconds
Complete requests:      20000
Failed requests:        0
Keep-Alive requests:    20001
Bytes transfered:       37882109
HTML transfered:        33321666
Requests per seconds:   590.58
Transfer rate:          1118.62 kb/s
 
Connnection Times (ms)
           min   avg   max
Connect:     0     2   346
Total:     258   360   485
---

clameter@melchi:~$ ./zb localhost /index.html -k -c 215 -n 20000
 
---
Server:                 kHTTPd/0.1.6
Doucment Length:        1666
Concurency Level:       215
Time taken for tests:   101.735 seconds
Complete requests:      20000
Failed requests:        0
Keep-Alive requests:    0
Bytes transfered:       37096378
HTML transfered:        33643204
Requests per seconds:   196.59
Transfer rate:          364.64 kb/s
 
Connnection Times (ms)
           min   avg   max
Connect:    36   438  1084
Total:     394  1070  2009
---


Then we decided to switch persistant connection off... But boa still wins.

clameter@melchi:~$ ./zb localhost /index.html -c 215 -n 20000 -p 6000
 
---
Server:                 Boa/0.94.8.3
Doucment Length:        1666
Concurency Level:       215
Time taken for tests:   88.040 seconds
Complete requests:      20000
Failed requests:        0
Bytes transfered:       37352000
HTML transfered:        33528250
Requests per seconds:   227.17
Transfer rate:          424.26 kb/s
 
Connnection Times (ms)
           min   avg   max
Connect:     1   305  3417
Total:     458   932  4232
---

This shows the following problems with khttpd:

1. Connect times are on average longer than boa. Why???

2. Transfers also take longer,


What is wrong here? I would expect transferates of a 3-4 megabytes over a
localhost interface. The file is certainly in some kind of cache.
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
