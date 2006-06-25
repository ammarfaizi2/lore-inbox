Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWFYRzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWFYRzl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 13:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWFYRzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 13:55:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:58911 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750727AbWFYRzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 13:55:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KZdQuDPXWLlQeJ8H7wjRrLCWLG2CIfenNVXmNlDBXIeIqyC1kkfSXi79hLBP2DftYnxQTj+uzUs+A6RtpDVrHRoD6+bVnjqAyAO/66Y5+9rekl5OYGtN+nlDRtdsNj77evKnit94xEsgHixFmCSM4xOUoH+j85V7ShCjHBH10DY=
Message-ID: <449ECE2E.3080804@gmail.com>
Date: Sun, 25 Jun 2006 19:55:58 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [patch] 2.6.17: lockless pagecache
References: <20060625163930.GB3006@wotan.suse.de>
In-Reply-To: <20060625163930.GB3006@wotan.suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin napisał(a):
> Updated lockless pagecache patchset available here:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.17/lockless.patch.gz
> 

Here is my fix for this warnings
WARNING: /lib/modules/2.6.17.1/kernel/fs/ntfs/ntfs.ko needs unknown symbol add_to_page_cache
WARNING: /lib/modules/2.6.17.1/kernel/fs/ntfs/ntfs.ko needs unknown symbol add_to_page_cache

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/mm/filemap.c linux-work/mm/filemap.c
--- linux-work-clean/mm/filemap.c	2006-06-25 19:47:47.000000000 +0200
+++ linux-work/mm/filemap.c	2006-06-25 19:50:43.000000000 +0200
@@ -445,6 +445,8 @@ int add_to_page_cache(struct page *page,
 	return error;
 }

+EXPORT_SYMBOL(add_to_page_cache);
+
 /*
  * Same as add_to_page_cache, but works on pages that are already in
  * swapcache and possibly visible to external lookups.

