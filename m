Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265543AbUEZMRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265543AbUEZMRE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUEZMQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:16:17 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:24017 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265540AbUEZMPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:15:42 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'John Bradford'" <john@grabjohn.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 05:19:34 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <40B48620.6000309@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDGJri0zDL2uZVQPOMqcMjgPS7PwAAfr5w
Message-Id: <S265540AbUEZMPm/20040526121543Z+487@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> 3) once physical memory is full, file system I/O will only benefit from
>> reads that incur a minor fault. All other file system operations 
>> are bound
>> by the rate you can reclaim pages from physical memory.
>> 

> No, typically we can reclaim memory very quickly and the operations
> are bound by the speed of the block device.

So if all physical memory is full with either pagecache or anonymous memory,
where are you going to put these operations that are bound by the speed of
the block device?

You have to evict pages at the same rate your reading them in or writing to
the filesystem else you have nowhere to put them. This means that the rate
you can access the filesystem is governed by the rate you can evict pages
from memory.

Couple that with the fact that there are many pte's pointing at the same
physical page (shared page) in many cases where many processes are running
on the system. Because all of the references to that page must be removed
before the page can be evicted, there are some absolute limitations in the
rate that pages can be evicted from memory as the number of processes
running on the system and the total amount of memory increases.

--Buddy

