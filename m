Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVD0Mi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVD0Mi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 08:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVD0Mi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 08:38:57 -0400
Received: from colin.muc.de ([193.149.48.1]:10771 "EHLO colin2.muc.de")
	by vger.kernel.org with ESMTP id S261541AbVD0Miy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 08:38:54 -0400
Date: 27 Apr 2005 14:38:52 +0200
Date: Wed, 27 Apr 2005 14:38:52 +0200
From: Andi Kleen <ak@muc.de>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, racing.guo@intel.com
Subject: Re: [PATCH]porting lockless mce from x86_64 to i386
Message-ID: <20050427123852.GD12597@muc.de>
References: <200504261327.30928.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504261327.30928.luming.yu@intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 01:27:30PM +0800, Yu, Luming wrote:
> 
> Forward a patch :

Some comments: 

The asmlinkage on x86-64 is not really needed. You can remove
the ifdef. fastcall is fine, although it is a nop.

The u64 tsc[NR CPUS] on the stack is a stack overflow with big
NR_CPUS. I have
a patch locally here to fix it, but you could just apply it
anyways when you move the code. Fix is to use kmalloc here.

-Andi

