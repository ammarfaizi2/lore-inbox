Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVBOJwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVBOJwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 04:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVBOJwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 04:52:03 -0500
Received: from ns.suse.de ([195.135.220.2]:55223 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261663AbVBOJv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 04:51:59 -0500
Date: Tue, 15 Feb 2005 10:51:53 +0100
From: Andi Kleen <ak@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, paulus@samba.org, anton@samba.org,
       davem@davemloft.net, ralf@linux-mips.org, tony.luck@intel.com,
       ak@suse.de, willy@debian.org, schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate compat_sys_waitid
Message-ID: <20050215095153.GB13952@wotan.suse.de>
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 02:01:49PM +1100, Stephen Rothwell wrote:
> +asmlinkage long compat_sys_waitid(u32 which, u32 pid,
> +		struct compat_siginfo __user *uinfo, u32 options,
> +		struct compat_rusage __user *uru)
> +{
> +	siginfo_t info;
> +	struct rusage ru;
> +	long ret;
> +	mm_segment_t old_fs = get_fs();
> +
> +	memset(&info, 0, sizeof(info));
> +
> +	set_fs(KERNEL_DS);
> +	ret = sys_waitid(which, pid, (siginfo_t __user *)&info, options,
> +			 uru ? (struct rusage __user *)&ru : NULL);
> +	set_fs(old_fs);

I don't think this will work for sparc64/s390/UML etc.
They cannot access kernel data inside KERNEL_DS. You would need to use
compat_alloc_user_space() for ru

-Andi
