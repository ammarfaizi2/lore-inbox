Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288633AbSADNtc>; Fri, 4 Jan 2002 08:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288635AbSADNtW>; Fri, 4 Jan 2002 08:49:22 -0500
Received: from [202.54.64.2] ([202.54.64.2]:62222 "EHLO ganesh.ctd.hctech.com")
	by vger.kernel.org with ESMTP id <S288633AbSADNtM>;
	Fri, 4 Jan 2002 08:49:12 -0500
Message-ID: <EF836A380096D511AD9000B0D021B5274A1C9B@narmada.ctd.hcltech.com>
From: "Eshwar D - CTD, Chennai." <deshwar@ctd.hcltech.com>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Reg: SCSI
Date: Fri, 4 Jan 2002 19:15:45 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hai all,
	In my project while reading/writing the data in to scsi disk, I need
to block the device using RESERVE UNIT and RELEASE UNIT. Can any one help me
how to send SCSI command to SCSI device. I know that this can be done under
user level using SCSI generic interface. I  required function in kernel
version 2.4.2. level.

Thanks u
D.Eshwar,
Member Techinical Staff,
HCL Techonologies Ltd.,
D-12 & 12-B, 3rd South Street,
SIDCO Industrial Estate,
Ambattur,
Chennai - 600 058.

Disclaimer:
This document is intended for transmission to the named recipient only.  If
you are not that person, you should note that legal rights reside in this
document and you are not authorized to access, read, disclose, copy, use or
otherwise deal with it and any such actions are prohibited and may be
unlawful. The views expressed in this document are not necessarily those of
HCL Technologies Ltd. Notice is hereby given that no representation,
contract or other binding obligation shall be created by this e-mail, which
must be interpreted accordingly. Any representations, contractual rights or
obligations shall be separately communicated in writing and signed in the
original by a duly authorized officer of the relevant company.




-----Original Message-----
From: Urban Widmark [mailto:urban@teststation.com]
Sent: Thursday, December 27, 2001 7:07 PM
To: Eshwar D - CTD, Chennai.
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMBFS reading & Time sync problem


On Thu, 27 Dec 2001, Eshwar D - CTD, Chennai. wrote:

> Hai,
> 	I am using kernel version 2.4.2. and samba version is 2.2.0. and

2.4.3 may have a fix for this if the size of the file changes. Upgrade to
a newer kernel and see if this doesn't work better there.

smbfs does not really support this kind of sharing anyway. It caches
things without having an "oplock" on the server. Without an oplock it
should always re-read everything (hard to do for mmap'ed files).

There is also an assumption in a lot of the code that the file does not
change on the server.


>  To avoid this problem my suggestion is
> 
> 	1. While every write the modified time to be notified to sever by
> sending SMBsetattr.

That will cut the transfer rate in half (roughly) and there is no
guarantee that it will work as some servers do not seem to respond with
the recently written attributes.

I don't think that is the best way to do this. oplocks + proper
invalidation should be a lot safer. Setting attributes depends on the
clocks of the machines being somewhat in sync.


Please test 2.4.17 (or a more recent kernel from your vendor). If that
doesn't work could you then send me a testprogram/script that triggers
this. Thanks.

/Urban
