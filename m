Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSGYRe3>; Thu, 25 Jul 2002 13:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSGYReC>; Thu, 25 Jul 2002 13:34:02 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:55796 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315946AbSGYRdo>; Thu, 25 Jul 2002 13:33:44 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
To: <joe@fib011235813.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF9ECAF9FC.61CBF3AC-ON85256BFF.00540683@pok.ibm.com>
From: "Ben Rafanello" <benr@us.ibm.com>
Date: Thu, 25 Jul 2002 12:36:45 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 07/25/2002 01:36:54 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tues, Jul 23, 2002 at 3:10 am, Joe Thornber wrote:
>On Mon, Jul 22, 2002 at 01:31:11PM -0500, Ben Rafanello wrote:
>> I believe you are referring to Device Mapper, which could, in theory,
>> handle the AIX metadata layout.  However, AFAIK, there are no tools
>> currently available or under development for Device Mapper to make
>> this happen.  Currently, EVMS is the only way to read/write to AIX
>> volumes under Linux.
>
>This is absolutely correct, LVM2 does not currently support AIX
>metadata.  However the LVM2 tools were designed to support multiple
>metadata formats, and it really would be very little work to write the
>code to do this (after all this is just a little bit of userland code,
>rather than kernel code in EVMS).  ATM Sistina are not willing to pay
>for this work, so it will have to come from some other part of the
>community.

After a quick look through the device mapper code, it appears that
device mapper knows nothing of the metadata format of the
volumes/partitions/etc. that it is mapping.  This will work well for
cases where the metadata for the volume/volume group does not have to be
updated at runtime.  However, it appears that device mapper needs a
kernel module to handle those cases where the volume metadata must
be updated during runtime (cases such as RAID 5, Mirroring -
particularly the fancier forms with features like smart resync
and hot spot mirroring, bad block relocation, etc.).  Thus, to
support AIX (or any other enterprise level volume manager since
they all tend to have similar features) would require more than
"just a little bit of userland code", it would require a significant
amount of kernel code as well.

>There is a little tool called dmsetup:
>
>http://people.sistina.com/~thornber/dmsetup_8.html
>
>that is essentially a very simple volume manager.  But it does give
>you full access to all the facilities of device-mapper.  eg, I just

Thanks for the link!  I'll give it a try.


Ben Rafanello
EVMS Team Lead
IBM Linux Technology Center
(512) 838-4762
benr@us.ibm.com


