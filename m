Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUCaP7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 10:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUCaP7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 10:59:07 -0500
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:33683 "EHLO
	rtp-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262026AbUCaP7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 10:59:02 -0500
X-BrightmailFiltered: true
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: James Morris <jmorris@redhat.com>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <Matt_Domsch@dell.com>
Subject: Re: [PATCH] lib/libcrc32c
References: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com>
	<200403302043.22938.bzolnier@elka.pw.edu.pl>
	<yqujwu52ywsy.fsf@chaapala-lnx2.cisco.com>
	<200403302149.59364.bzolnier@elka.pw.edu.pl>
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
Date: Wed, 31 Mar 2004 09:28:38 -0600
In-Reply-To: <200403302149.59364.bzolnier@elka.pw.edu.pl> (Bartlomiej
 Zolnierkiewicz's message of "Tue, 30 Mar 2004 21:49:59 +0200")
Message-ID: <yqujhdw5jas9.fsf@chaapala-lnx2.cisco.com>
User-Agent: Gnus/5.110001 (No Gnus v0.1) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Bartlomiej Zolnierkiewicz told this:

> On Tuesday 30 of March 2004 21:11, Clay Haapala wrote:
>> On Tue, 30 Mar 2004, Bartlomiej Zolnierkiewicz outgrape:
>> > +
>> > +static u32 crc32c_table[256] = {
>> >
>> > Tables are build time generated in case of CRC32
>> > (lib/gen_crc32table.c) so you can trade some performance for
>> > smaller size of the table.
>> >
>> > [ However I don't know how useful is this. ]
>>
>> As the table was statically in code in sctp and in the iSCSI driver
>> where it originally came from, I left it that way.  Why would the
>> table be of a different size?
> 
> See lib/crc32defs.h and lib/gen_crc32table.c.
> 
> lib/crc32defs.h:
> 
> /* How many bits at a time to use.  Requires a table of
> 4<<CRC_xx_BITS bytes. */ /* For less performance-sensitive, use 4 */
> #ifndef CRC_LE_BITS # define CRC_LE_BITS 8 #endif #ifndef
> CRC_BE_BITS # define CRC_BE_BITS 8 #endif
> 
> lib/gen_crc32table.c:
> 
> #define LE_TABLE_SIZE (1 << CRC_LE_BITS)
> #define BE_TABLE_SIZE (1 << CRC_BE_BITS)
> 
> static u_int32_t crc32table_le[LE_TABLE_SIZE];
> static u_int32_t crc32table_be[BE_TABLE_SIZE];
> 
> 
This is a legitimate question.

The immediate user of this crc32c is the iscsi-sfnet driver, and my
mind-set for that is always towards gigabit-ethernet wire-rate, so
that bias may prevent me from making the right choice here.

Regarding performance vs. size, we have the BITS == 8 table for "high"
performance and bigger size, and BITS == 1 bit-wise computation, for the
least size, albeit slower performance.  Is that good enough?

The last time I wrote CRC lookup code for nibble-sized tables, it was
for an 8051 microcontroller. :-)
-- 
Clay Haapala (chaapala@cisco.com) Cisco Systems SRBU +1 763-398-1056
   6450 Wedgwood Rd, Suite 130 Maple Grove MN 55311 PGP: C89240AD
		 Dyslexia meets Concealed Carry laws:
	       "Microsoft bans gnus on these premises"
