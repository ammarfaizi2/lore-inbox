Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVBQBUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVBQBUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 20:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVBQBUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 20:20:23 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:59090 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262188AbVBQBTo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 20:19:44 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?]
Date: Wed, 16 Feb 2005 20:19:09 -0500
User-Agent: KMail/1.7.92
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050121161959.GO3922@fi.muni.cz> <200502161831.24357.kernel-stuff@comcast.net> <20050216155142.6840497f.akpm@osdl.org>
In-Reply-To: <20050216155142.6840497f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502162019.10102.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 February 2005 06:51 pm, Andrew Morton wrote:
> ffff81002fe80000 is the address of the slab object.  00000000000008a8 is
> supposed to be the caller's text address.  It appears that
> __builtin_return_address(0) is returning junk.  Perhaps due to
> -fomit-frame-pointer.
I tried manually removing -fomit-frame-pointer from Makefile and adding 
-fno-omit-frame-pointer but with same results - junk return addresses. 
Probably a X86_64 issue.

>So it's probably an ndiswrapper bug? 
I looked at ndiswrapper mailing lists and found this explanation for the same 
issue of growing size-64 with ndiswrapper  -
----------------------------------
"It looks like the problem is kernel-version related, not ndiswrapper. 
 ndiswrapper just uses some API that starts the memory leak but the 
 problem is indeed in the kernel itself. versions from 2.6.10 up to 
 .11-rc3 have this problem afaik. haven"t tested rc4 but maybe this one 
 doesn"t have the problem anymore, we will see"
----------------------------------

I tested -rc4 and it has the problem too.  More over, with plain old 8139too 
driver, the slab still continues to grow albeit slowly. So there is a reason 
to suspect kernel leak as well. I will try binary searching...

Parag
