Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAYQ1L>; Thu, 25 Jan 2001 11:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRAYQ1D>; Thu, 25 Jan 2001 11:27:03 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:37013 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S131387AbRAYQZk>;
	Thu, 25 Jan 2001 11:25:40 -0500
Date: Thu, 25 Jan 2001 08:23:54 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: khttpd-users@zgp.org
cc: linux-kernel@vger.kernel.org
Subject: Benchmark: khttpd vs. boa vs. apache: khttpd 2-3 times faster than
 apache
Message-ID: <Pine.LNX.4.21.0101250816500.4883-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These tests were done with 2 Celeron-433 processors across a 100 mbit
link.

The server was running 2.4.1-pre8 + my patches and boa / apache / khttpd.
The server was running other services while doing the test.

The client was running 2.2.17.

Boa is still very close to khttpd. Apache falls way behind. khttpd and boa
both almost saturate the 100mbit link.

One thing that is still worrysome is that some requests to khttpd still
take 3 seconds to complete. I wonder if the queuing of requests could be
improved on.

christoph@slave2:/home/christoph$ ./zb openrock.net /index.html -k -c 215 -n 20000 -p 8080
 
---
Server:                 Apache/1.3.9
Doucment Length:        8214
Concurency Level:       215
Time taken for tests:   44.533 seconds
Complete requests:      20000
Failed requests:        0
Keep-Alive requests:    19831
Bytes transfered:       171012425
HTML transfered:        164280000
Requests per seconds:   449.11
Transfer rate:          3840.13 kb/s
 
Connnection Times (ms)
           min   avg   max
Connect:     0     5  8991
Total:       3   294 41550
---
 
christoph@slave2:/home/christoph$ ./zb openrock.net /index.html -k -c 215 -n 20000 -p 80
 
---
Server:                 kHTTPd/0.1.6
Doucment Length:        8214
Concurency Level:       215
Time taken for tests:   17.435 seconds
Complete requests:      20000
Failed requests:        0
Keep-Alive requests:    20004
Bytes transfered:       168221828
HTML transfered:        164320658
Requests per seconds:   1147.12
Transfer rate:          9648.51 kb/s
 
Connnection Times (ms)
           min   avg   max
Connect:     0     7  3006
Total:       4    38  3121
---
 
christoph@slave2:/home/christoph$ ./zb openrock.net /index.html -k -c 215 -n 20000 -p 8000
 
---
Server:                 Boa/0.95.0pre
Doucment Length:        8214
Concurency Level:       215
Time taken for tests:   19.514 seconds
Complete requests:      20000
Failed requests:        0
Keep-Alive requests:    20000
Bytes transfered:       168925751
HTML transfered:        164343017
Requests per seconds:   1024.91
Transfer rate:          8656.64 kb/s
 
Connnection Times (ms)
           min   avg   max
Connect:     0    11  3005
Total:      13   208  6163
---


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
