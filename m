Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUC2FKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 00:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUC2FKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 00:10:13 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:51742 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262652AbUC2FKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 00:10:07 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: wli@holomorphy.com, colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7] 
In-reply-to: Your message of "Thu, 25 Mar 2004 23:14:12 -0800."
             <20040325231412.2a3d1c15.pj@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Mar 2004 15:08:46 +1000
Message-ID: <4865.1080536926@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004 23:14:12 -0800, 
Paul Jackson <pj@sgi.com> wrote:
>Does your way work if NR_CPUS is less than BITS_PER_LONG?
>Won't gcc complain upon seeing something like, for say
>NR_CPUS = 4 on a 32 bit system:
>
>   { [ 0 ... -1 ] = ~0UL, ~0UL << 28 }
>
>with the errors and warnings:
>
>  error: empty index range in initializer
>  warning: excess elements in struct initializer

I only did one case, to concentrate on the value for the last word.  A
full implementation has to cater for NR_CPUS < BITS_PER_LONG as well.

>and shouldn't the last word be inverted: ~(~0UL << NR_CPUS_UNDEF) ?

For big endian, ~0UL << NR_CPUS_UNDEF is right.  For little endian, it
depends on how you represent an incomplete bit map.  Is it represented
as a pure bit string, i.e. as if the arch were big endian?  Or is it
represented as a mapping onto the bytes of the underlying long?

