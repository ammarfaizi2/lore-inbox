Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUCIRan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUCIRan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:30:43 -0500
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:5265 "EHLO
	rtp-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S262068AbUCIRal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:30:41 -0500
To: James Morris <jmorris@redhat.com>
Cc: Jouni Malinen <jkmaline@cc.hut.fi>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
References: <Xine.LNX.4.44.0403090045390.24848-100000@thoron.boston.redhat.com>
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
Date: Tue, 09 Mar 2004 11:30:36 -0600
In-Reply-To: <Xine.LNX.4.44.0403090045390.24848-100000@thoron.boston.redhat.com> (James
 Morris's message of "Tue, 9 Mar 2004 00:55:42 -0500 (EST)")
Message-ID: <yquj7jxuudvn.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004, James Morris uttered the following:
> On Mon, 8 Mar 2004, Jouni Malinen wrote:
>> If you prefer, I can make a new type crypto alg type
>> (CRYPTO_ALG_TYPE_KEYED_DIGEST) and make it a clone of the
>> CRYPTO_ALG_TYPE_DIGEST with the only change of adding a new
>> callback, setkey, in the way I added in the patch for
>> CRYPTO_ALG_TYPE_DIGEST. This would leave the digest type
>> unmodified, but would result in copying most of the digest code. I
>> do not see much benefit of this because the dia_setkey function
>> pointer does not seem to change the old digest functionality at all
>> since it is optional and since this function pointer does not even
>> enlarge struct crypto_alg due to the cra_u union already being a
>> bit larger than the current struct digest_alg.
> 
> Agreed.  I really wanted to keep digests 'pure', and not implement a
> setkey method, but it seems like the simplest way at this stage.
> 
I had the same thought in my attempt at adding CRC32C to the crypto
routines, that what was needed was "digests + setkey".  But I didn't
want to add the key baggage to digests, and so created a new alg type
(CHKSUM), with pretty much identical code to digest, but with a
modified init and a new setkey interface.

So, we could modify digests now, or perhaps Jouni and I could combine
our code into a new KEYED_DIGEST type and leave digests 'pure'.
What's best?

-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
  Windows XP 'Reloaded'?  *Reloaded?*  Have they no sense of irony?
