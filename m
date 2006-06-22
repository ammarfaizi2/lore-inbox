Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbWFVWpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWFVWpz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWFVWpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:45:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:58601 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750779AbWFVWpy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:45:54 -0400
Message-ID: <449B1D95.4090705@zytor.com>
Date: Thu, 22 Jun 2006 15:45:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Is the x86-64 kernel size limit real?
References: <20060622204627.GA47994@dspnet.fr.eu.org> <e7f2jq$r17$1@terminus.zytor.com> <20060622220057.GB52945@dspnet.fr.eu.org>
In-Reply-To: <20060622220057.GB52945@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> On Thu, Jun 22, 2006 at 02:38:02PM -0700, H. Peter Anvin wrote:
>> It turns out x86-64, unlike i386, does still have a hardcoded limit,
>> but the limit in build.c is wrong:
>>
>> kernel/head.S:
>>         /* 40MB kernel mapping. The kernel code cannot be bigger than that.
>>            When you change this change KERNEL_TEXT_SIZE in page.h too. */
>>         /* (2^48-(2*1024*1024*1024)-((2^39)*511)-((2^30)*510)) = 0 */
>>
>> So this should be replaced by KERNEL_TEXT_SIZE in page.h, or better,
>> this should be done dynamically in x86-64 too.
> 
> Interesting.  KERNEL_TEXT_SIZE wouldn't work though, since that's the
> decompressed size while the 4Mb limit is on the compressed size.  As a
> datapoint, though, the uncompressed image is 15.7Mb, for a 4.5Mb
> compressed image.
> 

Oh, right.  In fact, the 4 MB "limit" for i386 was actually an 8 MB uncompressed limit, 
with a 2:1 ratio assumed... not very accurate.

The limit should be removed from the boot tools; since we're talking uncompressed limits 
those should be tested in the linker script if anywhere.

	-hpa

