Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318726AbSHER1q>; Mon, 5 Aug 2002 13:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSHER1q>; Mon, 5 Aug 2002 13:27:46 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:32267 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318726AbSHER1p>;
	Mon, 5 Aug 2002 13:27:45 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208051731.g75HVK871782@saturn.cs.uml.edu>
Subject: Re: BIG files & file systems
To: rddunlap@osdl.org (Randy.Dunlap)
Date: Mon, 5 Aug 2002 13:31:19 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, acahalan@cs.uml.edu (Albert D. Cahalan)
In-Reply-To: <Pine.LNX.4.33L2.0208050719350.6273-100000@dragon.pdx.osdl.net> from "Randy.Dunlap" at Aug 05, 2002 07:21:18 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap writes:
> On Mon, 5 Aug 2002, Randy.Dunlap wrote:

>> Albert, your graph shows that the triple-indirect limit is
>> at 8 EB, right?

No, that's the API limit. We use signed 64-bit byte
offsets in our API. (it's just under 8 EiB, which
is about 9.2 EB)

I do see one flaw on my graph. That horizontal line
at 1 TiB ought to be at 2 TiB apparently. It's for
the kernel limit, perhaps only on 32-bit hardware.
This changes the limit with 4096-byte blocks from
1 TiB to 2 TiB, so the filesystem's 4.4 TB is still
out of reach.

> Yes, but your text (email) explanation puts it at around
> 4.4 TB.  Got it.

If we had quadruple indirection, then we'd hit a 17.6 TB
limit (16 TiB) due to the 32-bit block numbers. With an
8192-byte block size, we'd hit the block number limit
at 35 TB (32 TiB) before hitting the triple-indirection
limit. Of course none of this gets you past the kernel
limit at around 2.2 TB.

I believe we allow 8192-byte blocks on the Alpha.
You might want to look into that. IA-64 maybe too.



