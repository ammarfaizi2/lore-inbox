Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWHBNoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWHBNoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 09:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWHBNoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 09:44:15 -0400
Received: from web25814.mail.ukl.yahoo.com ([217.146.176.247]:13651 "HELO
	web25814.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751133AbWHBNoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 09:44:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type;
  b=rGDA7fCbpUbtCg4RNhxWlGkzzXeMNTMgHYcbl/We45cn5kFKsNw3Hin6c76pK2vU00GURxzzbC1RQ5HyrPj2IwHwBq0zOnWgDjc9wJegbJUZ79Cvar8tQ4vTbFvcpFtSuw44+oybx95qNTgmiqdazBNXMSo5mgNqJtnC39iy7Yw=  ;
Message-ID: <20060802134413.63901.qmail@web25814.mail.ukl.yahoo.com>
Date: Wed, 2 Aug 2006 13:44:13 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: sparsemem usage
To: linux-kernel@vger.kernel.org
Cc: apw@shadowen.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My board has a really weird mem mapping.

MEM1: 0xc000 0000 - 32 Mo
MEM2: 0xd000 0000 - 8 Mo
MEM3: 0xd800 0000 - 128 Ko

MEM3 has interesting properties, such as speed and security,
and I really need to use it.

I think that sparsemem can deal with such mapping. But I
encounter an issue when choosing the section bit size. I choose
SECTION_SIZE_BITS = 17. Therefore the section size is
equal to the smallest size of my memories. But I get a
compilation error which is due to this:

#if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
#error Allocator MAX_ORDER exceeds SECTION_SIZE
#endif

I'm not sure to understand why there's such check. To fix this
I should change MAX_ORDER to 6.

Is it the only way to fix that ?

Thanks

Francis


