Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266676AbUGLAPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266676AbUGLAPO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 20:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266677AbUGLAPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 20:15:14 -0400
Received: from holomorphy.com ([207.189.100.168]:3979 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266676AbUGLAPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 20:15:10 -0400
Date: Sun, 11 Jul 2004 17:15:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] hugetlbfs private mappings.
Message-ID: <20040712001502.GS21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	David Gibson <david@gibson.dropbear.id.au>
References: <40F139BA.F1F10B22@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F139BA.F1F10B22@tv-sign.ru>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 04:59:38PM +0400, Oleg Nesterov wrote:
> Hugetlbfs silently coerce private mappings of hugetlb files
> into shared ones. So private writable mapping has MAP_SHARED
> semantics. I think, such mappings should be disallowed.
> First, such behavior allows open hugetlbfs file O_RDONLY, and
> overwrite it via mmap(PROT_READ|PROT_WRITE, MAP_PRIVATE), so
> it is security bug.
> Second, private writable mmap() should fail just because kernel
> does not support this.
> I beleive, it is ok to allow private readonly hugetlb mappings,
> sys_mprotect() does not work with hugetlb vmas.
> There is another problem. Hugetlb mapping is always prefaulted,
> pages allocated at mmap() time. So even readonly mapping allows
> to enlarge the size of the hugetlbfs file, and steal huge pages
> without appropriative permissions.
> Patch on top of vm_pgoff fixes, see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108938233708584

This probably doesn't break anything worth caring about, but it may
make people happier to just force MAP_SHARED on.


-- wli
