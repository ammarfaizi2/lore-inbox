Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUANWMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264342AbUANWMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:12:43 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:20548 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S264310AbUANWMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:12:39 -0500
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Add CRC32C chksums to crypto routines
References: <Xine.LNX.4.44.0401141643560.12649-100000@thoron.boston.redhat.com>
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
Date: Wed, 14 Jan 2004 16:12:31 -0600
In-Reply-To: <Xine.LNX.4.44.0401141643560.12649-100000@thoron.boston.redhat.com> (James
 Morris's message of "Wed, 14 Jan 2004 16:45:49 -0500 (EST)")
Message-ID: <yqujzncq2n8w.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004, James Morris stated:
> On Wed, 14 Jan 2004, Clay Haapala wrote:
> 
>> This patch against 2.6.1 adds CRC32C checksumming capabilities to
>> the crypto routines.  The structure of it is based wholly on the
>> existing digest (md5) routines, the main difference being that
>> chksums are often used in an "accumulator" fashion, effectively
>> requiring one to set the seed, and the digest algorithms don't do
>> that.
> 
> This looks interesting; do you know of any other chksum algorithms
> which might need to be implemented in the kernel?
> 
I reference the one other user of CRC32C in my code, that would be the
sctp network driver, at this time.

Of course, there is library/crc32, which I did make an attempt to
implement companion code to it, but we really need the "work over
scatterlists" feature of the crypto routines.

I took the design goals the of the library/crc32 routines (flexible
XOR policy, flexible initial values) and tried to allow that in the
crypto chksum routines.  CRC32 could be moved into it, but the uses of
CRC32 are often quick accumulation over packet fragments, rather than
computing digests over scatterlists describing would can be many K of
data.
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
	 Funny, I didn't think Haliburton was into aerospace.
