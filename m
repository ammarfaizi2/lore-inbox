Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbUB1A1Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbUB1AUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:20:02 -0500
Received: from palrel12.hp.com ([156.153.255.237]:8685 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263236AbUB1AS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:18:56 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16447.56941.774257.925722@napali.hpl.hp.com>
Date: Fri, 27 Feb 2004 16:18:53 -0800
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: [patch] u64 casts
In-Reply-To: <1077915522.2255.28.camel@cube>
References: <1077915522.2255.28.camel@cube>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 27 Feb 2004 15:58:42 -0500, Albert Cahalan <albert@users.sourceforge.net> said:

  Albert> Casts are considered harmful, because they bypass
  Albert> type checking, but how do you print a u64 value?
  Albert> You cast it to "unsigned long long" like this:

  Albert> printk("%llu\n", (unsigned long long)foo);

  Albert> Well, this is silly and ugly. As x86-64 has shown,
  Albert> even a 64-bit port can use "long long" for 64-bit
  Albert> values. This patch changes all other 64-bit ports.
  Albert> It now becomes possible to avoid adding new casts
  Albert> all over the place; existing ones may be removed
  Albert> if so desired.

Did you verify that none of the kernel header files that are still
being used by glibc contain declarations based on __u64 or __s64?  If
not, your patch breaks user-level code.

	--david
