Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbTDITlN (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263712AbTDITlM (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:41:12 -0400
Received: from mcomail01.maxtor.com ([134.6.76.15]:58635 "EHLO
	mcomail01.maxtor.com") by vger.kernel.org with ESMTP
	id S263687AbTDITlL (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 15:41:11 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D0B1@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Oliver S.'" <Follow.Me@gmx.net>, linux-kernel@vger.kernel.org
Subject: RE: questions regarding Journalling-FSes and w-cache reordering
Date: Wed, 9 Apr 2003 13:52:44 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
>
> Is a ATA-harddisk allowed to reorder the operations from in 
> w-cache ?

ATA hard drives are allowed to reorder/merge/etc their write caches if write
cache is enabled.  With write caching enabled, there is no guarantee that
dirty data will be flushed in any specific order, nor does the ATA protocol
support any such ordering beyond the global flush cache command.

No order preference is supported in TCQ either except for the optional FUA
extensions for ATA-7.

There is nothing in the ATA specification that guarantees data integrity at
any given instant in time on the media without a flush cache.  (e.g. I am in
the process of writing data A, and data B is an arriving overlapping write
splice, what do I actually put on the media and in what order)

Power cycling a dirty, busy drive, especially in the middle of error
recovery/reallocation, is always a dangerous proposition.


--eric

--
Eric Mudama                              Maxtor Corporation
eric_mudama@maxtor.com      2452 Clover Basin Drive - BC163
303.682.4758 (x4758)                     Longmont, CO 80503
                      cell: 303.478.3180
 


