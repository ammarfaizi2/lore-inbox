Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270455AbTGMXj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270454AbTGMXj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:39:56 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:54161 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270451AbTGMXjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:39:52 -0400
Date: Sun, 13 Jul 2003 16:54:24 -0700
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Larry McVoy <lm@bitmover.com>, roland@topspin.com, alan@storlinksemi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
Message-ID: <20030713235424.GB31793@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"David S. Miller" <davem@redhat.com>, Larry McVoy <lm@bitmover.com>,
	roland@topspin.com, alan@storlinksemi.com,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com> <20030713004818.4f1895be.davem@redhat.com> <52u19qwg53.fsf@topspin.com> <20030713160200.571716cf.davem@redhat.com> <20030713233503.GA31793@work.bitmover.com> <20030713164003.21839eb4.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713164003.21839eb4.davem@redhat.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The whole point is to not touch any of this data.
> 
> The idea is to push the pages directly into the page cache
> of the filesystem.

It doesn't work.  Measure the cost of the VM operations before you go
down this path.  Just set up a system call that swaps a page with a
kernel allocated buffer and then see how many of those you can do a 
second.  Maybe Linux is so blindingly fast this makes sense but IRIX
certainly wasn't, the VM overhead hurt like crazy.

Every time I tried to push the page flip idea or offloading or any of
that crap, Andy Bechtolsheim would tell "the CPUs will get faster faster
than you can make that work".  He was right.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
