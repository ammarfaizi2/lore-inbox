Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265501AbUEZLnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUEZLnM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265498AbUEZLnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:43:12 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:54196 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265501AbUEZLnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:43:07 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'John Bradford'" <john@grabjohn.com>
Cc: "'William Lee Irwin III'" <wli@holomorphy.com>, <orders@nodivisions.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 04:46:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <40B467DA.4070600@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDBo+F4Ob4sLpWTkWfS+f+LvquIgAD6PSw
Message-Id: <S265501AbUEZLnH/20040526114307Z+464@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> That's true, but it's not a magical property of swap space
>> - extra physical
>> RAM would do more or less the same thing.
>> 

> Well it is a magical property of swap space, because extra RAM
> doesn't allow you to replace unused memory with often used memory.

> The theory holds true no matter how much RAM you have. Swap can
> improve performance. It can be trivially demonstrated.

I bet you have demonstrated this. It strikes me of an observation that could
be made in a lab environment. But your failing to realize that:

1) you will fill physical memory with pages eventually or your not doing
work.

2) pages do not just silently move to the swap device. They move as a result
of a memory shortfall

3) once physical memory is full, file system I/O will only benefit from
reads that incur a minor fault. All other file system operations are bound
by the rate you can reclaim pages from physical memory.

4) non-filesystem backed pages are still effected the same way, nothing has
changed. When you run your next filesystem related operation, those pages
will be faulted into physical memory, and something will be evicted to it's
backing store (remember, memory is full).

--Buddy

