Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbUDGLbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 07:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUDGLbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 07:31:13 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:56171 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263039AbUDGLbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 07:31:07 -0400
Date: Wed, 7 Apr 2004 04:27:54 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, colpatch@us.ibm.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
Message-Id: <20040407042754.6b487ace.pj@sgi.com>
In-Reply-To: <20040406235000.6c06af9a.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
	<20040401131240.00f7d74d.pj@sgi.com>
	<20040406043732.6fb2df9f.pj@sgi.com>
	<200404070855.03742.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040406235000.6c06af9a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few hours ago, I sketched the following code:

> 	for (
> 	      ({ i = 0; while(!node_set(i, mask) && i < MAX_NUMNODES) i++; i; });
> 	      i < MAX_NUMNODES; 
> 	      ({ i++; while(!node_set(i, mask) && i < MAX_NUMNODES) i++; i; })
> 	)


I've reduced this to a pair of bitmap.h operators:

> #define find_next_bit_in_bitmap(src, nbits, n)			\
> 	({ int i = (n); while(i < (nbits) && !test_bit(i, (src))) i++; i; })
> 
> #define find_first_bit_in_bitmap(src, nbits)			\
> 	find_next_bit_in_bitmap((src), (nbits), 0)

which are plug compatible with bitops find_first_bit() and find_next_bit(),
but smaller.  These alternatives can then be used in the for-loop defines.

The above is not yet compiled or tested ...  Use at own risk.

My next mask patchset will have these.  Following the excellent
recommendations of Rusty however, my next mask patchset won't have
masks ;).  Just cpumasks bolted directly on top of souped up bitmaps.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
