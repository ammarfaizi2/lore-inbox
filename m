Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUEMIGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUEMIGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 04:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUEMIGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 04:06:47 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:13584 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263943AbUEMIGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 04:06:20 -0400
Date: Thu, 13 May 2004 09:06:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       David Gibson <david@gibson.dropbear.id.au>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Adam Litke <agl@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: More convenient way to grab hugepage memory
Message-ID: <20040513090608.A6992@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Adam Litke <agl@us.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040513055520.GF27403@zax> <20040513084903.B6631@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040513084903.B6631@infradead.org>; from hch@infradead.org on Thu, May 13, 2004 at 08:49:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 08:49:03AM +0100, Christoph Hellwig wrote:
> Please don't do this.  It's messing all over sensitive codepathes in the
> kernel, creating special cases and bloat of what you could with simple a
> simpe hugetlb_mmap() wrapper ala (pseudocode)

another thing is that you could also simply override the mmap symbol from
glibc do transparently use hugetlb pages.

Another problem with this interface is that hugetlb_zero_setup bypassed
directory based permissions, aka it's has the same design bug as the
broken sysv shm extension for hugetlb pages and thus needs privilegues
or one of the horrible hacks discussed on lkml the last days.

