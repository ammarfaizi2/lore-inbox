Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137192AbREKR5q>; Fri, 11 May 2001 13:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137193AbREKR5h>; Fri, 11 May 2001 13:57:37 -0400
Received: from host-64-65-206-13.choiceone.net ([64.65.206.13]:12850 "EHLO
	isaiah.tpr-east.com") by vger.kernel.org with ESMTP
	id <S137192AbREKR51>; Fri, 11 May 2001 13:57:27 -0400
Message-ID: <3AFC2806.DFBFB343@tpr.com>
Date: Fri, 11 May 2001 13:57:26 -0400
From: Mark Bratcher <bratcher@tpr.com>
Organization: Torrey Pines Research
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: bratcher@tpr.com
Subject: ATAPI failure in 2.4.4, not in 2.2.17 (UPDATE)
Content-Type: multipart/mixed;
 boundary="------------2788C2EB35602E3369BDB3AA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2788C2EB35602E3369BDB3AA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I upgraded from kernel 2.2.17 to 2.4.4. I used "make oldconfig" to be sure I
had as many of the prior settings as possible. Didn't change any of the old
settings. I am running under RedHat 6.2. And, yes, I did all the updates
required
to go to the 2.4.4 kernel.

I use a Seagate ATAPI tape drive, model STT20000A.
I have no problems in 2.2.17 doing IDE tape backups using dump, restore, and mt.

In kernel 2.4.4, I get the following repeatable scenarios (which all work in
2.2.17):

* In a full tape dump of about 50MB or so, everything goes smoothly. No errors.

* In a full tape dump of a little over 1GB (to a 10GB tape), I get the following
errors
immediately after the backup completes and I try to write a file mark with "mt":

May  9 16:50:49 isaiah kernel: ide-tape: Reached idetape_chrdev_open 
May  9 16:52:05 isaiah kernel: hdd: irq timeout: status=0xd0 { Busy } 
May  9 16:52:05 isaiah kernel: hdd: ATAPI reset complete 
May  9 16:52:05 isaiah kernel: ide-tape: Couldn't write a filemark 
May  9 16:52:06 isaiah kernel: ide-tape: Reached idetape_chrdev_open 
May  9 16:54:06 isaiah kernel: ide-tape: ht0: DSC timeout 
May  9 16:54:06 isaiah kernel: hdd: ATAPI reset complete 
May  9 16:54:06 isaiah kernel: ide-tape: ht0: I/O error, pc = 10, key =  2, asc
=  4,
ascq =  1 
May  9 16:54:06 isaiah kernel: ide-tape: ht0: I/O error, pc = 34, key =  2, asc
=  4,
ascq =  1 

* In a full tape dump of between 6GB and 7GB, the backup completes, I
successfully write a tape file mark with "mt", rewind, then attempt to compare.
I get:

May  9 04:21:18 isaiah kernel: ide-tape: Reached idetape_chrdev_open 
May  9 04:22:35 isaiah kernel: ide-tape: bh == NULL in
idetape_copy_stage_to_user 
May  9 04:22:35 isaiah kernel: ide-tape: bh == NULL in
idetape_copy_stage_to_user 
May  9 04:22:36 isaiah kernel: ide-tape: Reached idetape_chrdev_open 

I also tried SCSI emulation mode (something I didn't have to do in 2.2.17)
and it didn't work either. In SCSI emulation mode, my CD-ROM drive worked
OK in SCSI emulation, but the tape drive still did not work. When I tried:

   mt -f /dev/st0 rewind

I got the following errors:

May 10 07:49:33 isaiah kernel: st0: Error with sense data: [valid=0] Info
fld=0x0,
Current st09:00: sense key Illegal Request 
May 10 07:49:33 isaiah kernel: Additional sense indicates Invalid command
operation code 

I've reverted back to 2.2.17 kernel just so I can do successful IDE tape
backups until I can get this problem with 2.4.4 resolved.

Any helpful input appreciated. Please reply directly, as I'm not a member
of this list. If I'm not stating the problem clearly, or if I haven't provided
enough data, please let me know.

Thanks,
Mark Bratcher
--------------2788C2EB35602E3369BDB3AA
Content-Type: text/x-vcard; charset=us-ascii;
 name="bratcher.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Mark Bratcher
Content-Disposition: attachment;
 filename="bratcher.vcf"

begin:vcard 
n:Bratcher;Mark
tel;fax:716/288-4604
tel;work:716/288-7220
x-mozilla-html:FALSE
url:www.tpr.com
org:Torrey Pines Research
version:2.1
email;internet:bratcher@tpr.com
title:Director of Software Development
adr;quoted-printable:;;565 Blossom Road=0D=0ASuite A;Rochester;New York;14610;USA
x-mozilla-cpt:;19472
fn:Bratcher, Mark
end:vcard

--------------2788C2EB35602E3369BDB3AA--

