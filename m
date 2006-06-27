Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWF0NLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWF0NLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWF0NLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:11:09 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:9702 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932134AbWF0NLI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:11:08 -0400
Message-ID: <44A12D84.5010400@aitel.hist.no>
Date: Tue, 27 Jun 2006 15:07:16 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: New readahead - ups and downs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many have noticed positive sides of the new readahead system.
I too see that, bootup is quicker and starting a big app like firefox is
also noticeable faster.

I made my own little io-intensive test, that shows a case where
performance drops.

I boot the machine, and starts "debsums", a debian utility that
checksums every file managed by debian package management.
As soon as the machine starts swapping, I also start
start a process that applies an mm-patch to the kernel tree, and
times this.

This patching took 1m28s with cold cache, without debsums running.
With the 2.6.15 kernel (old readahead), and debsums running, this
took 2m20s to complete, and 360kB in swap at the worst.

With the new readahead in 2.6.17-mm3 I get 6m22s for patching,
and 22MB in swap at the most.  Runs with mm1 and mm2 were
similiar, 5-6 minutes patching and 22MB swap.

My patching clearly takes more times this way.  I don't know
if debsums improved though, it could be as simple as a fairness
issue.  Memory pressure definitely went up.


Helge Hafting
