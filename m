Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbTFCTkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTFCTkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:40:42 -0400
Received: from exchange-1.umflint.edu ([141.216.3.48]:49958 "EHLO
	Exchange-1.umflint.edu") by vger.kernel.org with ESMTP
	id S263743AbTFCTkk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:40:40 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Stalls from low free memory on 2.4.18 too
Date: Tue, 3 Jun 2003 15:51:19 -0400
Message-ID: <37885B2630DF0C4CA95EFB47B30985FB020EC020@exchange-1.umflint.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stalls from low free memory on 2.4.18 too
Thread-Index: AcMqBUcyx2cirhonSWmPKJ+xqpktNwAARu0AAAC4vjA=
From: "Lauro, John" <jlauro@umflint.edu>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 
I did some more tests from a 12GB server that I am trying to make
stable under heavy writes...
 
I tried a few different patches, but nothing helped so far.
 
I also tried going down to 2.4.18.  At first, it appeared to be
working, but...  it just took a little longer to fail...  2.4.18 seems
slower on disk I/O.  It's giving me about a 30% reduction in BI or
BO/sec, but could be caused from other factors.  With 2.4.18 I was
sustaining about 20000 BO/sec compared to over 30000 with 2.4.20
(according to vmstat 1).  However, free memory was rarely going below
5000, and with 2.4.20 it seemed to dip below 4000 sooner.  Then, with
2.4.18 after some time it too decided to get stuck under 4000 free and
after several seconds of vmstat 1 reporting free under 3900 it stop
reponing.  Walking over to the server room, <shift><scroll> shows free
staying around 780-805 (waiting about 30 seconds between tries). 
Tried killing the connections, etc... and finally gave up and
rebooted.
 
 
How can Linux seem to allocate memory for running a program that
malloc() a bunch of memory and then exits (freeing a bunch of pages
for the kernel) work so quickly, but....  consume memory quicker then
it can free it for write operations?
 
Is it possible that once memory gets too tight, that either:
1.      Calls to actually empty buffers and get info on disk are being
blocked somewhere
2.      The routine that frees memory doesn't have enough memory to
run
3.      or some other subsystem is deadlocking because free memory is
too low and it's failing to allocate, and eating up all the CPU so
everything else stalls
 
Would it be possible to somehow throttle write requests halfway
between the freepages min and freepages low???  Is it possible to even
set those values (modify the source?), as they are still documented,
but are not in /proc???
 
One item I have not tried yet is one of the alternate memory
allocation patches that are supposed to work better with HIGHMEM.
 
