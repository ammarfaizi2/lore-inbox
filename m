Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbUCKSZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbUCKSZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:25:51 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:22772 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261629AbUCKSZr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:25:47 -0500
Subject: Re: blk_congestion_wait racy?
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF214BC5A0.606D60A9-ONC1256E53.0034F9B5-C1256E54.006525C2@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 11 Mar 2004 19:24:48 +0100
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 11/03/2004 19:25:04
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> Martin, have you tried adding this printk?

Sorry for the delay. I had to get 2.6.4-mm1 working before doing the
"ouch" test. The new pte_to_pgprot/pgoff_prot_to_pte stuff wasn't easy.
I tested 2.6.4-mm1 with the blk_run_queues move and the ouch printk.
The first interesting observation is that 2.6.4-mm1 behaves MUCH better
then 2.6.4:

2.6.4-mm1 with 1 cpu
# time ./mempig 600
Count (1Meg blocks) = 600
600  of 600
Done.

real    0m2.587s
user    0m0.100s
sys     0m0.730s
#

2.6.4-mm1 with 2 cpus
# time ./mempig 600
Count (1Meg blocks) = 600
600  of 600
Done.

real    0m10.313s
user    0m0.160s
sys     0m0.780s
#

2.6.4 takes > 1min for the test with 2 cpus.

The second observation is that I get only a few "ouch" messages. They
all come from the blk_congestion_wait in try_to_free_pages, as expected.
What I did not expect is that I only got 9 "ouches" for the run with
2 cpus.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


