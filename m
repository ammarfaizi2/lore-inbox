Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbTIVW6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbTIVW6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:58:20 -0400
Received: from fungus.teststation.com ([212.32.186.211]:11538 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S261768AbTIVW5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:57:06 -0400
Date: Tue, 23 Sep 2003 00:57:04 +0200 (CEST)
From: Urban Widmark <Urban.Widmark@enlight.net>
X-X-Sender: puw@cola.enlightnet.local
To: linux-kernel@vger.kernel.org
Subject: semaphore IPC problem?
Message-ID: <Pine.LNX.4.44.0309222232560.26232-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all

I'm having a problem with IBM DB2 on linux. I found a page where IBM
points fingers to the linux semaphore implementation, but without giving
any details.


"Information about the StaleConnectionException on Linux systems

 The StaleConnectionException SQl1224 is related to the extension shared 
 memory attachment. Linux systems have a semaphore problem causing the DB2 
 SQL1224 error."

http://publib7b.boulder.ibm.com/wasinfo1/en/info/aes/ae/rdat_stalelinux.html


Does that make sense to anyone?
Known semaphore problems/races?


The page has a workaround which is to set it up as a remote database and
connect over 127.0.0.1 instead of shm ipc. Doing that seems to work, but
the setup is annoying. That it works could just be speed related, not sure
if loopback is slower.

The testcase is a number of threads (java) doing repeated select
operations, with commit+close between each and using a connection pool.

I have tested this on 2.4.22 (UP) and 2.6.0-test5. 2.6 can handle a lot
more threads than 2.4 (~70 vs 3-5) before failing, but they both fail in 
the same way.


I know I don't have much info ...

Hints on where to look? (other than IBM support)

/Urban

