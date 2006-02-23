Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWBWRrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWBWRrc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWBWRrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:47:31 -0500
Received: from terminus.zytor.com ([192.83.249.54]:8632 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932084AbWBWRra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:47:30 -0500
Message-ID: <43FDF52C.6020407@zytor.com>
Date: Thu, 23 Feb 2006 09:47:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: "David S. Miller" <davem@davemloft.net>, klibc@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: sys_mmap2 on different architectures
References: <43FCDB8A.5060100@zytor.com> <20060223001411.GA20487@kvack.org> <20060222.164347.12864037.davem@davemloft.net> <20060223173907.GF27682@kvack.org>
In-Reply-To: <20060223173907.GF27682@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Wed, Feb 22, 2006 at 04:43:47PM -0800, David S. Miller wrote:
> 
>>Aha, that part I didn't catch.  Thanks for the clarification
>>Ben.
>>
>>I wonder why we did things that way with a fixed shift...
> 
> 
> Without that trick, we'd have needed an extra parameter for the syscall 
> on x86, which is already at the maximum number of registers with 6 
> arguments.  This was easier than changing the syscall ABI. =-)
> 

Well, there is always the trick of making it a pointer.  It was needed 
for pselect() anyway.  A real sys_mmap64 would definitely have been 
cleaner, and will be needed to deal with the 16 TB barrier anyway :)

I personally think the S390 people had the right idea... once you run 
out of registers, just make it a defined part of the ABI that we pass in 
a single pointer to all the arguments.

	-hpa
