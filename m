Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269210AbUJFLzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269210AbUJFLzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 07:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269213AbUJFLzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 07:55:53 -0400
Received: from colin2.muc.de ([193.149.48.15]:62980 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S269210AbUJFLzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 07:55:52 -0400
Date: 6 Oct 2004 13:55:50 +0200
Date: Wed, 6 Oct 2004 13:55:50 +0200
From: Andi Kleen <ak@muc.de>
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, Riley@Williams.Name, davej@codemonkey.org.uk,
       hpa@zytor.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386/gcc bug with do_test_wp_bit
Message-ID: <20041006115550.GA58628@muc.de>
References: <41634E21.6020808@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41634E21.6020808@vmware.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 06:45:05PM -0700, Zachary Amsden wrote:
> Playing around with gcc 3.3.3, I compiled a 2.6 series kernel for i386 
> and discovered it panics on boot.  The problem was gcc 3.3.3 can inline 
> functions even if declared after their call sites.  This causes i386 to 
> not boot, since do_test_wp_bit() must not exist in the __init section.  
> Similar problems may exist in the boot code for other architectures, but 
> I can't confirm that at this time.  x86_64 is not affected.

That should have been fixed long ago by sorting the exception
table. I checked and the code is still there: 

asmlinkage void __init start_kernel(void)
{
	...
        sort_main_extable();


Something must be rotten in your setup. I definitely don't see the
same problems with a unit-at-a-time 3.3 gcc. 

Can you double check that the sort is really done?

The patch is imho not needed.

-Andi
