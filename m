Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264413AbRFIANw>; Fri, 8 Jun 2001 20:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264414AbRFIANn>; Fri, 8 Jun 2001 20:13:43 -0400
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:50939 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S264413AbRFIANc>; Fri, 8 Jun 2001 20:13:32 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880AA9@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: chamb@almaden.ibm.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RE: question about scsi generic behavior
Date: Fri, 8 Jun 2001 18:13:30 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, 

Hardcoding  of block size to 512 bytes for disk devices is what currently 
either the block device driver or the sd driver is doing. Because, if
I run dd to the same device using the corresponding block device (sde)
it runs fine. So, I feel that either the sg driver or the block device
driver
or sd driver needs to be fixed. 
One more thing is that, sg driver can find out from READ_CAPACITY the
current
block size on the device. So, if dd specifies bs=4096 and count=1, then
accordingly, the sg driver should set the count to 8 and bs to the bs of
the device. IMHO, untimately, the total transfer length is what matters.

Regards,
-hiren
(408)970-3062
hiren_mehta@agilent.com

> -----Original Message-----
> From: David Chambliss [mailto:chamb@almaden.ibm.com]
> Sent: Friday, June 08, 2001 4:49 PM
> To: hiren_mehta@agilent.com
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: question about scsi generic behavior
> 
> 
> 
> I think you need to set bpt=8 .
> 
> It is possible to set some drives to block sizes other than 
> 512 bytes, and
> hardcoding 512 is not a good idea, especially in code that 
> might last a
> while.  In a few years we might have 4096-byte blocks to let 
> the drives use
> more powerful error correcting codes.
> 
> David Chambliss
> Research Staff Member, Computer Science /Storage Systems
> IBM Research Division
> (408) 927-2243  (TL 457-2243)
> FAX (408) 927-3497
> 
