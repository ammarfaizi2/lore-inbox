Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWHPWTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWHPWTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWHPWTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:19:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:15717 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932277AbWHPWTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:19:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cao78kezwzj+rh7Ap76jbDRuEqf7qBzN6LbYT3bzHPyZ0mDNCHyM1x4W6hJxhnT4znBcgF5hl9Xg0JjFPq2X2WYBbZtKKEv34IECeCsrUgq559MJ2bLy0Z6pTIyywLVYJGsDndebYlIMnwr3+CPBoB0yM69bhIkunpEiZJGY5Cs=
Message-ID: <3f250c710608161519o54433300heb1c79de6cbf6ce5@mail.gmail.com>
Date: Wed, 16 Aug 2006 18:19:50 -0400
From: "Mauricio Lin" <mauriciolin@gmail.com>
To: catalin.marinas@gmail.com
Subject: Some issues about the kernel memory leak detector: __scan_block() function
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

I have tested your latest kernel memory leak detector on my ARM device
and for curiosity I have checked some part of your patch to figure out
how the memory is scanned and compared to radix tree for detecting
orphan pointer.

Let's suppose the a kmalloc() was executed without storing the
returned pointer to the memory area and its fictitious returned value
would be the address 0xb7d73000 as:

kmalloc(32, GFP_KERNEL);  // Cause memory leak

Is there any possibility the __scan_block() scans a memory block that
contains the memory area allocated by the previous kmalloc?

If this is possible, during the  "for (ptr = start; ptr < end; ptr++)
{} " loop in the __scan_block(), the ptr variable can assume the
address 0xb7d73000 and the radix_tree_lookup() returns the
corresponding  memleak_pointer and thus such pointer to this memory
area is not considered orphan (indeed it is an orphan pointer), right?

BR,

Mauricio Lin.
