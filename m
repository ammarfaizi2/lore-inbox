Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTDUPo6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTDUPo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:44:58 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:39057 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261449AbTDUPo4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:44:56 -0400
Message-ID: <3EA41339.3090909@cox.net>
Date: Mon, 21 Apr 2003 08:50:17 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.5.68 oops booting with initrd
References: <E197OVO-0008VR-00@gondolin.me.apana.org.au>
In-Reply-To: <E197OVO-0008VR-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Kevin P. Fleming <kpfleming@cox.net> wrote:
> 
>>Very small and simple kernel configuration (includes devfs, which is 
>>where this problem came from), using Etherboot to load it along with a 
>>small (768K) initrd.
> 
> 
>>Call Trace:
>> [<c0114000>] default_wake_function+0x0/0x20
>> [<c01099cc>] __down_failed+0x8/0xc
>> [<c01772d9>] .text.lock.util+0x55/0x7c
> 
> 
> This should fix it.

The patch you supplied (check disk->minors != 1 before calling 
devfs_remove_partitions) did not apply do 2.5.68; the code in 
fs/partitions/check.c has changed since your base version. However, 
hand-editing to do the same check has solved the problem.

I'll Christoph supply a patch, since he's the one that's been working in 
that whole devfs area.

