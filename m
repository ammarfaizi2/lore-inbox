Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWCCQ1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWCCQ1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWCCQ1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:27:05 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:9166 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932234AbWCCQ1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:27:04 -0500
Date: Sat, 04 Mar 2006 01:26:58 +0900 (JST)
Message-Id: <20060304.012658.126141376.anemo@mba.ocn.ne.jp>
To: davem@davemloft.net
Cc: akpm@osdl.org, clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, johnstul@us.ibm.com, ak@muc.de
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060302.214556.77789100.davem@davemloft.net>
References: <20060302190408.1e754f12.akpm@osdl.org>
	<20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
	<20060302.214556.77789100.davem@davemloft.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 02 Mar 2006 21:45:56 -0800 (PST), "David S. Miller" <davem@davemloft.net> said:

>> I and Ralf talked a bit about the jiffies issue.  Making an union
>> containing jiffies and jiffies_64 looks good to avoid such an
>> optimization problem, but it would affect so many existing codes.

davem> Maybe use an anonymous union?  That might help...

Do you mean something like this:

union {
  struct {
    unsigned long pad;
    unsigned long jiffies;
  };
  u64 jiffies_64;
};

Unfortunately a toplevel anonymous union looks not allowed...

---
Atsushi Nemoto
