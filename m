Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbTGEUSE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 16:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266478AbTGEUSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 16:18:04 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30355 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266474AbTGEUSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 16:18:01 -0400
Date: Sat, 5 Jul 2003 13:33:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: anticipatory scheduler merged
Message-Id: <20030705133334.4cc7e11b.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus has merged the anticipator scheduler.  A few things to note on this:

- For some workloads it is around 10% slower than deadline.  Most notably
  database workloads which seek all over the disk performing reads and
  synchronous writes.

  Sorry, we just weren't able to get the last little bit back.

  But for other workloads (reading lots of filesystem objects when
  there's a lot of writeout around, when there's a streaming read, etc) it
  is up to 1000% faster.  I believe it is a better all-round IO scheduler.

  Unless Nick pulls a big rabbit out of his hat, database people will
  need to boot their kernels with `elevator=deadline' to get the last bit
  of performance back.

- These changes have been well tested, but it is five months work and
  over 100 patches.  There's probably a bug or two.  If you suspect that
  something has gone wrong at the block layer (lots of tasks stuck in D
  state) then please retest with `elevator=deadline'.

Thanks.
