Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268056AbUHFOOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268056AbUHFOOg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUHFOOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:14:36 -0400
Received: from smtp.rol.ru ([194.67.21.9]:35707 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S268056AbUHFOOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:14:33 -0400
Message-ID: <411392E0.6080507@vlnb.net>
Date: Fri, 06 Aug 2004 18:17:04 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040512
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
References: <20040805200622.GA17324@logos.cnet>
In-Reply-To: <20040805200622.GA17324@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, is there any way to workaround this problem, i.e. prevent bit 
operations reordering on non-x86 architectures? Some kinds of memory 
barriers?

Vlad

Marcelo Tosatti wrote:
> Hi, 
> 
> Back when we were discussing the need for a memory barrier in sync_page(), 
> it came to me (thanks Andrea!) that the bit operations can be perfectly 
> reordered on architectures other than x86. 
> 
> I think the commentary on i386 bitops.h is misleading, its worth 
> to note that that these operations are not guaranteed not to be 
> reordered on different architectures. 
> 
> clear_bit() already does that:
> 
>  * clear_bit() is atomic and may not be reordered.  However, it does
>  * not contain a memory barrier, so if it is used for locking purposes,
>  * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
>  * in order to ensure changes are visible on other processors.
> 
> What you think of the following
