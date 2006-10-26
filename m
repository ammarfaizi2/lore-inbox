Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423447AbWJZG63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423447AbWJZG63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 02:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423454AbWJZG63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 02:58:29 -0400
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:4836
	"EHLO saville.com") by vger.kernel.org with ESMTP id S1423447AbWJZG62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 02:58:28 -0400
Message-ID: <45405C9F.60105@saville.com>
Date: Wed, 25 Oct 2006 23:58:39 -0700
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How-to change a pages pte
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've created a simple device driver that maps a single page of kernel memory into user space using the technique described in chapter 15 (pg 431) of Linux Device Drivers 3rd edition. But I've simplified it further, I map only one page at driver initialization time with a call to get_zeroed_page. When vm_open is called I set vm_flags & vm_page_prot to the values I want and when vm_nopage is called I use virt_to_page to return a struct page*. This seems to working fine on my Intel Core 2 Duo running a x86_64 kernel I've built.

My question is how can I change the protection bits (pte) of the kernel's view of the page returned by get_zeroed_page?

In looking at the kernel sources, the code in mm/mprotect.c such as, change_protection, is the closest to what I think I want, but it works with vm_area_struct's not page_struct's.

Regards,

Wink Saville
