Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVBXPje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVBXPje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVBXPhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:37:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:56740 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262404AbVBXPfY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:35:24 -0500
Subject: Re: [PATCH] Fix for broken kexec on panic
From: Dave Hansen <haveblue@us.ibm.com>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <1109236432.5148.192.camel@terminator.in.ibm.com>
References: <1109236432.5148.192.camel@terminator.in.ibm.com>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 07:35:15 -0800
Message-Id: <1109259315.7244.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 14:43 +0530, Vivek Goyal wrote:
> Kexec on panic is broken on i386 in 2.6.11-rc3-mm2 because of
> re-organization of boot memory allocator initialization code.  Primary
> kernel does not boot if kexec is enabled and crashkernel=X@Y command
> line parameter is passed. After re-organization, kexec is trying to call
> reserve_bootmem before boot memory allocator has initialized.
> 
> This patch fixes the problem. I have moved the call to
> reserved_bootmem() for kexec for both discontig and contig memory into
> new setup_bootmem_allocator().
> 
> This patch has been generated against 2.6.11-rc4-mm1

Looks like a good change, especially since it reduces the total amount
of code (and the size of your patch).

Although, to make any potential merging easier, it is almost always
better to put those kinds of things in functions #ifdef'd in a header.
The fact that there are other #ifdefs in setup_bootmem_allocator() is a
partial excuse, but not a very good one. :)

-- Dave

