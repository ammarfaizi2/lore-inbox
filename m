Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbTFLBLA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbTFLBLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:11:00 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.36.229]:48800 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S264670AbTFLBK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:10:56 -0400
Message-ID: <3EE7D659.2000003@austin.rr.com>
Date: Wed, 11 Jun 2003 20:24:41 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel with SuSE 8.2/gcc 3.3
References: <3EE6B7A2.3000606@austin.rr.com.suse.lists.linux.kernel> <p73he6x59hf.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although it fixes it for building on 32 bit architectures, won't changing


	__u64 uid = 0xFFFFFFFFFFFFFFFF;
to

	__u64 uid = 0xFFFFFFFFFFFFFFFFULL;

generate a type mismatch warning on ppc64 and similar 64 bit
architecutres since __u64 is not a unsigned long long on ppc64 
(it is unsigned long)?  My gut reaction is to just ingore the three
places that cause warnings and the remaining two places that cause 
signed/unsigned compare warnings of unsigned int local variables 
to #defined literals (which presumably are treated as signed by default).

Andi Kleen wrote:

>Steve French <smfrench@austin.rr.com> writes:
>
>>... and the similar ones in the same file
>>(fs/cifs/inode.c):
>>
>>	__u64 uid = 0xFFFFFFFFFFFFFFFF;
>>
>>generates a warning saying the value is too long for a long on x86
>>SuSE 8.2 with gcc 3.3
>>
>
>Define it with ULL   (= long long) 
>
>
>AFAIK the problem is that it has no default promotion for constants to 
>long long (normally they are int, long, unsigned long etc. depending on
>their value) It's some C99 thing. Or maybe a gcc bug. Anyways ULL 
>makes it clear that it is unsigned long long.
>


