Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265217AbTLKTPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbTLKTPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:15:40 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:58477 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S265217AbTLKTPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:15:33 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Andy Isaacson'" <adi@hexapodia.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Is there a "make hole" (truncate in middle) syscall?
Date: Thu, 11 Dec 2003 11:15:28 -0800
Organization: Cisco Systems
Message-ID: <017c01c3c01b$232bd130$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20031211125806.B2422@hexapodia.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The abstract interface for make_hole() is simple, but it turns into a
> pretty expensive filesystem operation, I think.  After many cycles of
> free/allocate, your file would be badly fragmented across the
> filesystem.  

Understood. Two filesystems we are using: tmpfs and ext3. For the
former, fragmentation doesn't matter.

Hey, I think when I get some cycles I can try to implement this for
tmpfs (since it's simpler) myself, and post a patch. :-) But before
that, I want to make sure it's doable.

> You'll probably get better overall performance by keeping
> track of how "sparse" your file is (you could compare st_blocks versus
> how many blocks you have allocated in your tree structure) 
> and re-write
> it when you're wasting more than, say, 20% of the allocated space.
> 
> It turns into an interesting problem if you don't want to double your
> space requirements during the re-write process.  You could write the
> new file "backwards", one MB at a time, truncating the 
> previous file at
> each step to free up the blocks.  You'd end up with contiguous 1MB
> chunks, which given your tree organization is probably good 
> enough.  If
> you wanted really good streaming performance you'd want to do bigger
> chunks (or just write the file from the beginning, or use the
> pre-allocation APIs that I think XFS provides).
> 
> -andy
> 

