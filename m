Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283500AbRLIPPO>; Sun, 9 Dec 2001 10:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283506AbRLIPPE>; Sun, 9 Dec 2001 10:15:04 -0500
Received: from tsv.sws.net.au ([203.36.46.2]:53264 "HELO tsv.sws.net.au")
	by vger.kernel.org with SMTP id <S283503AbRLIPOs>;
	Sun, 9 Dec 2001 10:14:48 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: reiserfs-list@namesys.com
Subject: per-char IO tests
Date: Sun, 9 Dec 2001 16:14:30 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011209151431.2172397E@lyta.coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have released a new experimental version of Bonnie++ that includes a 
program to test per-char IO using putc()/getc(), putc()/getc() when linked in 
a non-threaded way (significantly improves performance) 
putc_unlocked()/getc_unlocked(), and write()/read().

Here's the results of testing my Thinkpad T20 with P3-650:

Version  1.93          write   read putcNT getcNT   putc   getc  putcU  getcU
lyta                     142    651   8189   9348   1763   1813  22174  44887
lyta,142,651,8189,9348,1763,1813,22174,44887

Here's the results of testing my Athlon 800 play machine:

Version  1.93          write   read putcNT getcNT   putc   getc  putcU  getcU
test                     146    607   7356   7280   1834   1971  41995  59100
test,146,607,7356,7280,1834,1971,41995,59100

Both machines run ReiserFS.  A quick test indicates that using Ext2 instead 
of ReiserFS triples the  performance of write(fd, buf, 1), but this is 
something I already knew (and had mentioned before on the ReiserFS list).

Also based on previous tests I expect Solaris to outperform Linux with glibc 
on putcNT, getcNT, putc, and getc.  The regular performance of putc() on 
Solaris comes close to putc_unlocked() on Linux with glibc.




I'd like to thank Andrew Morton for forwarding messages from L-K that 
provoked me to write this new test program.

I was tempted to subscribe to L-K to join this discussion, but it seems that 
Linus is saying everything that needs to be said anyway so there's no point. 
;)

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page
