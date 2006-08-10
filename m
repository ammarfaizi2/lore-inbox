Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161486AbWHJR15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161486AbWHJR15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161484AbWHJR15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:27:57 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:24758 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161481AbWHJR14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:27:56 -0400
Message-ID: <44DB6C83.5030402@us.ibm.com>
Date: Thu, 10 Aug 2006 10:27:31 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] 48-bit block numbers for extended attributes
References: <1155172929.3161.87.camel@localhost.localdomain> <20060809234100.9337162d.akpm@osdl.org>
In-Reply-To: <20060809234100.9337162d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> On Wed, 09 Aug 2006 18:22:09 -0700
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
> 
>>As we are planning to support 48-bit block numbers for ext4,
>>we need to support 48-bit block numbers for extended attributes.
>>In the short term, we can do this by reuse (on-disk) 16-bit
>>padding (linux2.i_pad1 currently used only by "hurd") as high 
>>order bits for xattr. This patch basically does that.
> 
> 
> Short-term tends to become medium-term, then you're stuck with it.
> 
> What is the plan here?

At the time we discuss how to support 48 bit xattr in the current inode, 
we were thinking about patching ext3, thus it's not likely we will going 
to do a deep surgery on the on-disk ext3 inode itself to have room for 
another 16bit xattr. So the plan at that is to steal some unused bits 
and construct with existing 32bit xattr to come with a 48bit xattr in total.

Given the fact that we are creating a new filesystem ext4, the ideal way 
(long term) probably we should support 64bit xattr in the ext4 inode, 
that is possible. The plan is to focus on support 48bit ext4 first, then 
probably move on next few things that also requires on-disk format 
changes, this is an experiment filesystem at this moment....

Thanks,
Mingming

