Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbUAOAi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbUAOAi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:38:26 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:44428 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264565AbUAOAiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:38:02 -0500
Date: Wed, 14 Jan 2004 16:37:49 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: paulus@samba.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040114163749.7df1a372.pj@sgi.com>
In-Reply-To: <20040115002703.GA20971@tsunami.ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been working on-and-off on fixing the equivalent endian problem
> in __mask_parse_len.  How is that part going for you?  I haven't yet
> decided if I want to post it.

I have coded both - it was a simple matter of replacing each:

  wordp[i]

with:

  wordp[M32X(i)]

where M32X (for "Mask 32-bit indeX") is defined:

#include <asm/byteorder.h>
#if BITS_PER_LONG == 64 && defined(__BIG_ENDIAN)
#define M32X(i) ((i)^1)
#elif BITS_PER_LONG == 32 || defined(__LITTLE_ENDIAN)
#define M32X(i) (i)
#endif

I spent more time writing the comments explaining it than I did writing
the code.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
