Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTEaIub (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 04:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbTEaIub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 04:50:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27318 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264235AbTEaIu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 04:50:29 -0400
Date: Sat, 31 May 2003 02:01:02 -0700 (PDT)
Message-Id: <20030531.020102.26975316.davem@redhat.com>
To: davids@webmaster.com
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAECGDFAA.davids@webmaster.com>
References: <20030531.011210.34750891.davem@redhat.com>
	<MDEHLPKNGKAHNMBLJOLKAECGDFAA.davids@webmaster.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David Schwartz" <davids@webmaster.com>
   Date: Sat, 31 May 2003 01:58:09 -0700

   
   	It's a macro, and the way it inlines, it should be obvious in
   most cases that 'a', 'b', and 'c' can't be in the same place in memory.
   
Not true at all in Willy's test case, which was:

void test(u32 *a, u32 *b, u32 *c)
{
	__jhash_mix(*a, *b, *c);
}

And here you certainly have absolutely NO idea where a, b, and
c might point to.

   	One is to check if the input pointer happens to be aligned on
   a double-word boundary,

The most generic jhash() frankly isn't very interesting for
kernel applications,  %99 of uses there can use the u32 optimized
version.

Even for dcache strings we can't use it because for each character
we have to test it against some terminating value or translate
it somehow.

I wouldn't waste any time at all on this thing.
