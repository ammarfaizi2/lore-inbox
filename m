Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272493AbTHEPlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 11:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272500AbTHEPlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 11:41:35 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:48598 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S272493AbTHEPld
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 11:41:33 -0400
Date: Tue, 5 Aug 2003 08:41:31 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BK2CVS problem (fixed)
Message-ID: <20030805154131.GA20234@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several people pointed out problems in the BK2CVS trees.  I spent this
morning checking things over and there were indeed some out of date files.
I've fixed those up and put in place validation tools which should ensure
that this does not happen again.

Here's a validation run:

+ rm -rf /tmp/cmp-tmp
+ mkdir -p /tmp/cmp-tmp/cvs
+ cd /tmp/cmp-tmp/cvs
+ cvs -Q -d /tmp/linux-2.4-cvs checkout -P .
+ cd /tmp/linux-2.4
+ bk export -tplain /tmp/cmp-tmp/bk
+ cd /tmp/cmp-tmp
+ diff -r --exclude=CVS --exclude=BitKeeper --exclude=ChangeSet cvs/linux-2.4 bk
+ test -s DIFFS
+ rm -rf /tmp/cmp-tmp
+ mkdir -p /tmp/cmp-tmp/cvs
+ cd /tmp/cmp-tmp/cvs
+ cvs -Q -d /tmp/linux-2.5-cvs checkout -P .
+ cd /tmp/linux-2.5
+ bk export -tplain /tmp/cmp-tmp/bk
+ cd /tmp/cmp-tmp
+ diff -r --exclude=CVS --exclude=BitKeeper --exclude=ChangeSet cvs/linux-2.5 bk
+ test -s DIFFS
+ cd /tmp/linux-2.4-cvs
+ find linux-2.4 -type f -name '*,v'
+ PID=3553
+ sort
+ xargs sum
+ ssh root@kernel 'cd /home/cvs; find linux-2.4 -type f -name '\''*,v'\'' | xargs sum'
+ sort +2
+ wait 3553
+ diff SUMS SUMS.k
+ test -s DIFFS
+ cd /tmp/linux-2.5-cvs
+ find linux-2.5 -type f -name '*,v'
+ sort
+ PID=3594
+ xargs sum
+ ssh root@kernel 'cd /home/cvs; find linux-2.5 -type f -name '\''*,v'\'' | xargs sum'
+ sort +2
+ wait 3594
+ diff SUMS SUMS.k
+ test -s DIFFS

real    13m8.225s
user    0m23.742s
sys     0m18.830s
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
