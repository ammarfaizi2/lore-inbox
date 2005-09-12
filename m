Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVILSUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVILSUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVILSUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:20:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:12239 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932119AbVILSUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:20:04 -0400
Subject: Re: 2.6.13-mm2
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <150330000.1126548402@flay>
References: <20050908053042.6e05882f.akpm@osdl.org>
	 <201750000.1126494444@[10.10.2.4]> <20050912050122.GA3830@muc.de>
	 <150330000.1126548402@flay>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 11:19:56 -0700
Message-Id: <1126549196.5892.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 11:06 -0700, Martin J. Bligh wrote:
> Crashes on boot
> 
> http://test.kernel.org/12589/debug/console.log
> 
> May or may not be anything to do with what you were doing.

diff -puN arch/i386/mm/init.c~highmem-debug arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~highmem-debug	2005-09-09 08:50:15.000000000 -0700
+++ memhotplug-dave/arch/i386/mm/init.c	2005-09-09 08:50:15.000000000 -0700
@@ -278,6 +278,7 @@ void __init add_one_highpage_init(struct
 {
 	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
 		ClearPageReserved(page);
+		free_new_highpage(page);
 	} else
 		SetPageReserved(page);
 }
_


-- Dave

