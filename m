Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbUCMVn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 16:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbUCMVn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 16:43:58 -0500
Received: from terminus.zytor.com ([63.209.29.3]:7572 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S263193AbUCMVn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 16:43:56 -0500
Message-ID: <40538091.9050707@zytor.com>
Date: Sat, 13 Mar 2004 13:43:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 very early memory detection cleanup patch breaks the build
References: <1079198139.2512.19.camel@mulgrave>
In-Reply-To: <1079198139.2512.19.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> The attached should fix it again.

Could you perhaps describe which architecture this is a problem on, and 
what its entry condition looks like?

> This tampering with the trampoline was extraneous to the actual patch. 
> The rule should be that if you don't understand what something is doing,
> don't try to fix it.

I removed it because I removed the VISWS dependency, thus making it 
redundant.  What you seem to be saying is that the dependency should 
have been on SMP not X86_SMP; if that's the issue then please make it so.

I think you just needed to apply your own rule to the above statement.

> In this case CONFIG_X86_TRAMPOLINE is needed for the subarch's that
> provide their own SMP code but still use the standard trampoline.  I
> always thought the visws used the trampoline even in UP boot, but if it
> doesn't, just take out the X86_VISWS dependency.

It doesn't anymore.  The only reason it did was because of stupid 
partitioning between head.S and trampoline.S, which the patch cleans up.

	-hpa
