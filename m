Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTLKFN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 00:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTLKFNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 00:13:55 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:55843 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S263697AbTLKFNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 00:13:53 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: <rob@landley.net>, <linux-kernel@vger.kernel.org>
Subject: RE: Is there a "make hole" (truncate in middle) syscall?
Date: Wed, 10 Dec 2003 21:13:49 -0800
Organization: Cisco Systems
Message-ID: <011e01c3bfa5$8fb5a0e0$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <200312041432.23907.rob@landley.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for digging out this old discussion.

This would be a tremendous enhancement to Linux filesystems, and one of
my current projects actually needs this capability badly.

The project is a lightweight user-space library which implements a
file-based database. Each database has several files. The files are all
block-based, and each block is always a multiple of 512 byte (and we
could make it a multiple of 4K, in case this feature existed).

Blocks are organized as a B+ tree, so we have a root block, which points
to its child blocks, and in turn they point to the next level. There is
a free block list too.

The problem is with a lot of add/delete, there are a lot of free blocks
inside the file. So essentially we'd have to manually shrink these files
when it grows too big and eats up too much space. If we could just "dig
a hole", it would be trivial to return those blocks to the filesystem
without doing an expensive defragmentation.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Rob Landley
> Sent: Thursday, December 04, 2003 12:32 PM
> To: linux-kernel@vger.kernel.org
> Subject: Is there a "make hole" (truncate in middle) syscall?
> 
> 
> You can make a file with a hole by seeking past it and never 
> writing to that 
> bit, but is there any way to punch a hole in a file after the 
> fact?  (I mean 
> other with lseek and write.  Having a sparse file as the result....)
> 
> What are the downsides of holes?  (How big do they have to be 
> to actually save 
> space, is there a performance penalty to having a file with 
> 1000 4k holes in 
> it, etc...)
> 
> Rob
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

