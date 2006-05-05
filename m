Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWEEUic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWEEUic (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWEEUic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:38:32 -0400
Received: from cantor.suse.de ([195.135.220.2]:8100 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751004AbWEEUib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:38:31 -0400
From: Andi Kleen <ak@suse.de>
To: Alexey Toptygin <alexeyt@freeshell.org>
Subject: Re: [PATCH] sendfile compat functions on x86_64 and ia64
Date: Fri, 5 May 2006 22:38:26 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com
References: <Pine.NEB.4.62.0605050030200.18795@norge.freeshell.org>
In-Reply-To: <Pine.NEB.4.62.0605050030200.18795@norge.freeshell.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605052238.26834.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 May 2006 02:45, Alexey Toptygin wrote:
> 
> Hi,
> 
> I'm a kernel noob, so I apologise in advance if I completely misunderstood 
> something. In arch/x86_64/ia32/sys_ia32.c there is this code:
> 
> sys32_sendfile(int out_fd, int in_fd, compat_off_t __user *offset, s32 count)
> [snip]
> 	ret = sys_sendfile(out_fd, in_fd, offset ? &of : NULL, count);
> 
> However on ia32, count (a size_t) is u32. I think this is taking the u32 
> value from the 32 bit userland, sign-extending it to 64 bits, then giving 
> it to sys_sendfile in a u64. So, a count >= 1<<31 passed from the 32 bit 
> app will become a count >= ((1<<33)-1)<<31 given to sys_sendfile.
> 
> Now, I don't think this actually hurts anything, because sys_sendfile 
> passes a max of ((1<<31)-1) to do_sendfile, plus rw_verify_area will 
> reject values that are negative when cast to ssize_t; but, this is 
> certainly confusing.

With your change there wouldn't be any sign extension and rw_verify_area
couldn't reject negative values them anymore.

I think it would be a wrong change because it would differ from a native 
32bit kernel.

-Andi

