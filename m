Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUBDRIk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUBDRIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:08:40 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:35401 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S263661AbUBDRHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:07:50 -0500
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, <mpm@selenic.com>
Subject: Re: [PATCH 2.6.1] Add CRC32C chksums to crypto and lib routines
References: <Xine.LNX.4.44.0402031207330.939-100000@thoron.boston.redhat.com>
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
Date: Wed, 04 Feb 2004 11:07:45 -0600
In-Reply-To: <Xine.LNX.4.44.0402031207330.939-100000@thoron.boston.redhat.com> (James
 Morris's message of "Tue, 3 Feb 2004 12:09:56 -0500 (EST)")
Message-ID: <yqujisimepsu.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, James Morris told this:
> On Tue, 3 Feb 2004, Clay Haapala wrote:
> 
>> If this patch looks good, I'd like it accepted so we can submit
>> code iSCSI driver code that makes use of it.  This may be a good
>> time, since the crypto SHA code is getting a little scrutiny right
>> now.
> 
> This will need to wait until 2.6.2 is released, and will you also
> please submit the iSCSI change for review?
> 
Thanks, Dave, for setting me straight on not posting mondo patches to
lkml. :-)

The 4.0.0.4 version of the driver, with the crypto CRC calls omitted,
has been submitted for review by the scsi maintainers.  Here is link
to a "preview" patch with the calls to the crypto CRC32C module back
in, but without any of their latest comments incorporated:

  http://home.mn.rr.com/haapi/iSCSI/iscsi-4.0.0.4-with-crypto.patch.bz2

iscsi-crc.{c,h} are just wrappers for code using the previous private
implementation.  iscsi-recv-pdu.c and iscsi-xmit-pdu.c have the code
which processes scatterlists and make calls to the crypto CRC32C
routines in the other patch.

This code has been tested successfully on 2.6.1 with udev-0.15 and late-model
sysfs, hotplug, and klibc.  The patch also contains the iscsi utilities
code, if you want to go the whole nine yards.
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
    Minnesota is a very agreeable state.  Lately even Celsius and
                   Fahrenheit have tended to agree.
