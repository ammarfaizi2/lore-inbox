Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264673AbUE0RYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264673AbUE0RYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUE0RYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:24:11 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:3309 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264706AbUE0RXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:23:48 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'John Bradford'" <john@grabjohn.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Thu, 27 May 2004 10:27:01 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <40B57E9D.8020606@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDrLj5Txp/vOOeQNuPZmniDuQ7pgAEIMSw
Message-Id: <S264706AbUE0RXs/20040527172348Z+508@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I can picture it but I don't know how the kernel is going to handle
>it. All I am doing is speaking from what I have seen.

>http://marc.theaimsgroup.com/?l=linux-kernel&m=107817776322044&w=2

>This post for example, has profiles of a 32 CPU system with 16 FC
>controllers and over 1000 disks, doing some database workload. Does
>this qualify as big iron?

>In the bottom profile, you see the disks being kept busy with 50%
>idle time. The top 6 functions are all to do with generating IO
>requests and pushing them through the block layer, none of them
>involve memory reclaim.


They are using direct I/O ... therefore the DMA memory transfers are mapped
directly into the user address space bypassing the pagecache altogether.

--Buddy




There are profiles from a different setup in a related thread here:

http://groups.google.com.au/groups?q=g:thl3816668183d&dq=&hl=en&lr=&ie=UTF-8
&selm=1yjKu-7qU-1%40gated-at.bofh.it&rnum=9

I think we see kmem_cache_alloc make a miserable showing for the
memory allocation team, but it wouldn't even be there if the
profile were sorted by ticks (the left hand column).


Now If you had some experiences of memory reclaim slowing down
block IO, I'd love to hear them because that is related to an area
that I am looking at currently. I'm not saying what you claim is
impossible, but it is something that shouldn't happen and we don't
relly see... You're continuing to insist there is a problem but
that simply isn't helpful without further details.

