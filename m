Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbUBCTZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUBCTYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:24:40 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:31324 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S266019AbUBCTNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 14:13:54 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib
 routines
References: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com>
	<Xine.LNX.4.44.0402031213120.939-100000@thoron.boston.redhat.com>
	<20040203175006.GA19751@chaapala-lnx2.cisco.com>
	<20040203185111.GA31138@waste.org>
From: Clay Haapala <chaapala@cisco.com>
Organization: Cisco Systems, Inc. SRBU
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXl5ufMrp3a4OLr6ujO
 lXzChGmsblZzRzjF1+ErFRAz+KIaAAACVElEQVR4nG3TQW/aMBQAYC9IO88dguyWUomqt0DQ
 do7koO22SXFQb6uE7XIMKrFya+mhPk8D43+79+wMyrp3gnx59nvxMxmNEnIWycgH+U9E55CO
 rkZJ8hYipbXTdfcvQK/Xy6JF2zqI+qpbjZAszSDG2oXYp0FI5mOqbAeuDtLBdeuO8fNVxkzr
 E9jklKEgQWsppYYf9v4IE3i/4RiVRPneQTpoXSM8QA7un3QZQ2cl54wXIH7VDwEmrdOiZBgF
 V5BiLwLM4B3BS0ZpB24d4IvzW+QIc7/JIcAQIadF2eeUzn3FAa6xWFYUotjIRmLB7vEvCC4t
 VAugpTrC2FleLBm2wVnlAc7Dl2u5L1UozgWCjTxMW+vb4GVVFhWWFSCdKmgDMhaNFoxL3bSH
 rc/Irn1/RcWlh+UqNgHeNwishJ1L6LCpjdmGz76RmFGyuSwLgLUxJhyUlLA7fHMpeSGVPsFA
 wqtK4voI8RE+I3DsDpfamSNMpIBTKrF1yIpPMA0AzQPU5gSwCTyC/aEAtX4NM6gLM3CCziBT
 jRR+StQ/AA8a7AMuwxn0YAmcRKnVGwDRiOcw3uMWlajgAJsAPbw4OIpwrH3/vdq9B7hpl7GD
 w61A4PxwSqyH9J25gePnYdqhYjjZ5s6QCb3bwvOLJWPBFvCvWVDSthYmcff44IcacOUOt1Yv
 yGCF1+twuQtQCPjzZIaK/Lrx9+6b7TKEdXTwgz8R+uJv5K1jOcWMnO7NJ3v/QlprnzP1deUe
 8j4CpVE82MRj4j5SHGDnfvul8uGwjqNnpf4Ak4pzJDIy3lkAAAAASUVORK5CYII=
Date: Tue, 03 Feb 2004 13:13:48 -0600
In-Reply-To: <20040203185111.GA31138@waste.org> (Matt Mackall's message of
 "Tue, 3 Feb 2004 12:51:12 -0600")
Message-ID: <yqujad40j7rn.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, Matt Mackall uttered the following:

> On Tue, Feb 03, 2004 at 11:50:06AM -0600, Clay Haapala wrote:
> 
>> + * This program is free software; you can redistribute it and/or
>> + modify it * under the terms of the GNU General Public License as
>> + published by the Free * Software Foundation; either version 2 of
>> + the License, or (at your option) * any later version.
> ...
>> +MODULE_LICENSE("GPL and additional rights");
> 
> "additional rights?"
> 
Take it up with Matt_Domsch@dell.com -- it's his code that I
cribbed, so that's the license line I used.

>> +#if __GNUC__ >= 3 /* 2.x has "attribute", but only 3.0 has "pure
>> +*/ #define attribute(x) __attribute__(x) #else #define
>> +attribute(x) #endif
> 
> This sort of thing ought to be added to linux/compiler.h if it's not
> there already.
> 
+/*
+ * Haven't generated a big-endian table yet, but the bit-wise version
+ * should at least work.
+ */
> 
> Big-endian in this context means, of course, the order of the bits in
> the byte rather than bytes in a word, and as this CRC polynomial was
> chosen especially for its robustness on noise bursts in little-endian
> transmission (aka standard serial and network *bit* transmission
> ordering), I think we should intentionally omit BE support and make
> note of it.
> 
Yes, it is about transmission bit-order.  Is the crc32 BE code also
not necessary?  Does it deal with how various networking hardware
and architecture combos present this data?

>> +static inline void crypto_chksum_final(struct crypto_tfm *tfm, u32 *out)
>> +{
>> +	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CHKSUM);
> 
> A lot of these BUG_ONs seem to be overkill. You're not going to get
> here by someone accidentally misusing the interface. You can only get
> here by some very willful abuse of the interface or by extremely
> unlikely fandango on core, neither of which is worth trying to defend
> against.

That would be a worth changing in a clean-up pass over all of
crypto, then.
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
 The marketing flacks who thought the Super Bowl half-time show was the
 best way to reach 25-49-year-old males
