Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVCaKj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVCaKj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVCaKj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:39:26 -0500
Received: from ns.suse.de ([195.135.220.2]:23188 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261329AbVCaKij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:38:39 -0500
Date: Thu, 31 Mar 2005 12:38:34 +0200
From: Andi Kleen <ak@suse.de>
To: blaisorblade@yahoo.it
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch 2/3] x86_64: remove duplicated sys_time64
Message-ID: <20050331103834.GC1623@wotan.suse.de>
References: <20050330173216.426CFEFECF@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050330173216.426CFEFECF@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 07:32:16PM +0200, blaisorblade@yahoo.it wrote:
> 
> CC: Andi Kleen <ak@suse.de>
> 
> Keeping this function does not makes sense because it's a copied (and buggy)
> copy of sys_time. The only difference is that now.tv_sec (which is a time_t,
> i.e. a 64-bit long) is copied (and truncated) into a int (32-bit).
> 
> The prototype is the same (they both take a long __user *), so let's drop this
> and redirect it to sys_time (and make sure it exists by defining
> __ARCH_WANT_SYS_TIME).
> 
> Only disadvantage is that the sys_stime definition is also compiled (may be
> fixed if needed by adding a separate __ARCH_WANT_SYS_STIME macro, and defining
> it for all arch's defining __ARCH_WANT_SYS_TIME except x86_64).
> 
> Not compile-tested, sorry.


Nack. The generic sys_time still writes to int, not long.
That is why x86-64 has a private one. Please keep that.


-Andi
