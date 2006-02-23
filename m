Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWBWAFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWBWAFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWBWAFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:05:44 -0500
Received: from terminus.zytor.com ([192.83.249.54]:46526 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750899AbWBWAFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:05:44 -0500
Message-ID: <43FCFC53.20505@zytor.com>
Date: Wed, 22 Feb 2006 16:05:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: sys_mmap2 on different architectures
References: <43FCDB8A.5060100@zytor.com> <20060222.135430.44726149.davem@davemloft.net>
In-Reply-To: <20060222.135430.44726149.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> 
> Right.
> 
> On sparc32 we had the issue where we had a 8K page size
> platform (sun4) and the rest were using 4K page size.
> 
> I can't even think why we do that fixed shift actually.  I think Jakub
> Jalinek thought this might be a way to make applications assuming
> 4K page size work on the 8K page size machines.
> 
> I'm going to say that you can feel free to fix this to use PAGE_SHIFT
> correctly all the time.  Applications should be calling getpagesize()
> and not assume what that value might be.
> 

Okay, what I'll do is that I'll hard-code 12 on i386, SPARC and ARM; on 
other architectures I'll use getpagesize().  Of course, on 64-bit 
architectures this is not an issue; there I just call sys_mmap.

	-hpa
