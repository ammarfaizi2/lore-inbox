Return-Path: <linux-kernel-owner+w=401wt.eu-S1161106AbXAEOVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbXAEOVp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 09:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbXAEOVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 09:21:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:35968 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161106AbXAEOVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 09:21:44 -0500
In-Reply-To: <1167952757.20260.6.camel@voyager.dsnet>
References: <1167909014.20853.8.camel@localhost.localdomain> <20070104144825.68fec948.akpm@osdl.org>  <1167951548.12012.55.camel@praia> <1167952757.20260.6.camel@voyager.dsnet>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6bae980b60fd869e7067f3df2f5e2f6a@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: v4l-dvb-maintainer@linuxtv.org, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Andrew Morton <akpm@osdl.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix __ucmpdi2 in v4l2_norm_to_name()
Date: Fri, 5 Jan 2007 15:20:16 +0100
To: Stelian Pop <stelian@popies.net>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> The largest value we use here is 0x02000000.  Perhaps v4l2_std_id 
>>> shouldn't
>>> be 64-bit?
>> Too late to change it to 32 bits. It is at V4L2 userspace API since
>> kernel 2.6.0. We can, however use this approach as a workaround, with
>> the proper documentation.
>
> Maybe with a BUG_ON(id > UINT_MAX) ?

If the code code is like

	u64 user_id;
	u32 kernel_id = user_id;

(or different types, just showing the difference in word
lengths here) it's easiest and safest to do

	BUG_ON(kernel_id != user_id);

i.e. cast back up to 64-bit, see if it's identical to the
original.  You won't have to worry about sign extensions or
similar that way, the BUG_ON() condition expresses the actual
requirement directly.


Segher

