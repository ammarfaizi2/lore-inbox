Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUFNLzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUFNLzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 07:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUFNLzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 07:55:32 -0400
Received: from holomorphy.com ([207.189.100.168]:160 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262538AbUFNLza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 07:55:30 -0400
Date: Mon, 14 Jun 2004 04:54:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm2
Message-ID: <20040614115446.GD1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040614021018.789265c4.akpm@osdl.org> <20040614111540.GB1444@holomorphy.com> <20040614115004.GA16054@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614115004.GA16054@infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 04:15:40AM -0700, William Lee Irwin III wrote:
>> The arrangement of the #include <linux/kernel.h> in list.h breaks the
>> build of documentation. The following patch moves the include to where
>> it no longer interferes with kerneldoc's operation.

On Mon, Jun 14, 2004 at 12:50:04PM +0100, Christoph Hellwig wrote:
> BUG_ON is in <asm/bug.h>, no need to pull in all the crap from kernel.h

Revised patch, then:

Index: debian-2.6.7-rc3/include/linux/list.h
===================================================================
--- debian-2.6.7-rc3.orig/include/linux/list.h	2004-06-14 03:18:03.000000000 -0700
+++ debian-2.6.7-rc3/include/linux/list.h	2004-06-14 04:06:36.000000000 -0700
@@ -5,6 +5,7 @@
 
 #include <linux/stddef.h>
 #include <linux/prefetch.h>
+#include <asm/bug.h>		/* BUG_ON */
 #include <asm/system.h>
 
 /*
@@ -158,7 +159,6 @@
  * Note: list_empty on entry does not return true after this, the entry is
  * in an undefined state.
  */
-#include <linux/kernel.h>	/* BUG_ON */
 static inline void list_del(struct list_head *entry)
 {
 	BUG_ON(entry->prev->next != entry);
