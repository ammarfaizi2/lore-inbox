Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbTHWC5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 22:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTHWC5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 22:57:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:12693 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263061AbTHWC5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 22:57:33 -0400
Message-ID: <32826.4.4.25.4.1061607448.squirrel@www.osdl.org>
Date: Fri, 22 Aug 2003 19:57:28 -0700 (PDT)
Subject: Re: [RFC] [PATCH] linux-2.4.22-rc2_proc-interrupts-fix_A0.patch
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <johnstul@us.ibm.com>
In-Reply-To: <1061603986.21563.106.camel@cog.beaverton.ibm.com>
References: <1061603986.21563.106.camel@cog.beaverton.ibm.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>,
       <jamesclv@us.ibm.com>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All,
> 	Recently I've been seeing memory corruption issues related to
> /proc/interrupts on a 16way (32x w/ HT) x440. Basically get_irq_list() does
> not do any bounds checking on the page it is given, and can easily overrun
> the buffer when the cpu and interrupt count is high enough.
>
> This patch backports the 2.5 seq_file implementation of /proc/interrupts for
> CONFIG_X86 (hopefully leaving other arches alone).

The right thing to do IMO is to backport the missing 2.6 seq_file functions,
similar to what you did, but put them where they belong, in
fs/seq_file.c.  And not only for X86.  I.e., without the
ifdef/endif lines.

Such a patch has been sent to Marcelo at least 2 times, 1 from me
and 1 from someone else.  It is needed and I hope that he hears us.

> Obviously this is probably a little late in the game for 2.4.22, but I'd
> like to get any feedback at all to help expedite its acceptance into
> 2.4.23-prex.

Need to add the seq_single() function prototypes to include/linux/seq_file.h
too.

~Randy



