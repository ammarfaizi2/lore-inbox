Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVBPXql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVBPXql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVBPXql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:46:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:31204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262132AbVBPXqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:46:39 -0500
Date: Wed, 16 Feb 2005 15:51:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?]
Message-Id: <20050216155142.6840497f.akpm@osdl.org>
In-Reply-To: <200502161831.24357.kernel-stuff@comcast.net>
References: <20050121161959.GO3922@fi.muni.cz>
	<200502152300.15063.kernel-stuff@comcast.net>
	<20050215211210.1ea2d342.akpm@osdl.org>
	<200502161831.24357.kernel-stuff@comcast.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar <kernel-stuff@comcast.net> wrote:
>
> On Wednesday 16 February 2005 12:12 am, Andrew Morton wrote:
> > echo "size-4096 0 0 0" > /proc/slabinfo
> 
> Is there a reason X86_64 doesnt have CONFIG_FRAME_POINTER anywhere in 
> the .config?

No good reason, I suspect.

> I tried -rc4 with Manfred's patch and with CONFIG_DEBUG_SLAB and 
> CONFIG_DEBUG.

Thanks.

> I get the following output from
> echo "size-64 0 0 0" > /proc/slabinfo
> 
> obj ffff81002fe80000/0: 00000000000008a8 <0x8a8>
> obj ffff81002fe80000/1: 00000000000008a8 <0x8a8>
> obj ffff81002fe80000/2: 00000000000008a8 <0x8a8>
> :                                 3
> :                                 4
> :                                 :
> obj ffff81002fe80000/43: 00000000000008a8 <0x8a8>
> obj ffff81002fe80000/44: 00000000000008a8 <0x8a8>
>  
> How do I know what is at ffff81002fe80000? I tried the normal tricks (gdb 
> -c /proc/kcore vmlinux, objdump -d etc.) but none of the places list this 
> address.

ffff81002fe80000 is the address of the slab object.  00000000000008a8 is
supposed to be the caller's text address.  It appears that
__builtin_return_address(0) is returning junk.  Perhaps due to
-fomit-frame-pointer.

