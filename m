Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUASVQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUASVQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:16:04 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:55425 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S263539AbUASVP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:15:58 -0500
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Add CRC32C chksums to crypto routines
References: <Xine.LNX.4.44.0401191512140.1564-100000@thoron.boston.redhat.com>
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
Date: Mon, 19 Jan 2004 15:15:53 -0600
In-Reply-To: <Xine.LNX.4.44.0401191512140.1564-100000@thoron.boston.redhat.com> (James
 Morris's message of "Mon, 19 Jan 2004 15:13:15 -0500 (EST)")
Message-ID: <yquj8yk31vxy.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, James Morris stated:
> On Wed, 14 Jan 2004, Clay Haapala wrote:
> 
>> This patch against 2.6.1 adds CRC32C checksumming capabilities to
>> the crypto routines.  The structure of it is based wholly on the
>> existing digest (md5) routines, the main difference being that
>> chksums are often used in an "accumulator" fashion, effectively
>> requiring one to set the seed, and the digest algorithms don't do
>> that.
> 
> Looks good to me.
> 
In other email, Matt Mackall suggested a slightly different
integration with the kernel that would allow more general usage of the
CRC32C.  His suggestion was to put the implementation under /lib, next
to the crc32 routines, and make the crypto routine a wrapper that calls
it.  Selecting the CRYPTO_CRC32C module would SELECT the lib CRC32C
module, in other words.

The benefit of this would be to allow easy usage by other routines
(with no premption side-affects, a concern Matt has) while still being
there for routines that process scatterlist.  And the table/code is
still in one place.

Patch to follow in a day or two, after I can test it.  Implementation
was simple.
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
	 Funny, I didn't think Haliburton was into aerospace.
