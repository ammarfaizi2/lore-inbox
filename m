Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966001AbWKIN7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966001AbWKIN7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 08:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966002AbWKIN7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 08:59:37 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:20356 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S966001AbWKIN7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 08:59:36 -0500
Date: Thu, 9 Nov 2006 13:59:55 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: gniuxiao <gniuxiao.mailinglist@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is there limited number of permanent memory mappings in kernel on x86?
Message-ID: <20061109135955.GA18583@linux-mips.org>
References: <3dd9a95e0611090134l74c181eemc1662e533b8e62d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd9a95e0611090134l74c181eemc1662e533b8e62d2@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 05:34:30PM +0800, gniuxiao wrote:

> So we have to use kmap() to map high memory to kernel address???

Several reasons:

 o on i386 kernel address space is limited to just 1GB of which most that
   is on the order of 970MB is used for mapping lowmem.  The remainder is
   used for ioremap'ed memory, vmalloc'ed memory, highmem mappings and
   fixmap mappings, so there really on is very little address space.
 o highmem mappings are assumed to be very shortlived so at any time there
   will only be a small number of mappings active.
 o The algorithm to allocate a virtual address for a non-atomic kmap is
   somewhat simpleminded with O(n) worst case where n is the max. number
   of mappable pages and will be the slower the more pages are actually
   mapped.

  Ralf
