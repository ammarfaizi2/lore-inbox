Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262331AbSJKDqG>; Thu, 10 Oct 2002 23:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262334AbSJKDqF>; Thu, 10 Oct 2002 23:46:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:42937 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262331AbSJKDqE>; Thu, 10 Oct 2002 23:46:04 -0400
Importance: Normal
Sensitivity: 
Subject: Re: MD4 and MD5 library routines (was CIFS filesystem for Linux 2.5_
To: Andi Kleen <ak@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF7527F406.BAF41604-ON87256C4F.00141231@boulder.ibm.com>
From: "Steven French" <sfrench@us.ibm.com>
Date: Thu, 10 Oct 2002 22:51:41 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/10/2002 09:51:43 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> sfrench@us.ibm.com said:
>> >  fs/cifs/md4.c                      |  209 +++
>> >  fs/cifs/md5.c                      |  363 +++++
>> >  fs/cifs/md5.h                      |   38
>>
>> Unless these are somehow CIFS-specific, they should live in linux/lib/
>
>This would have the disadvantage that they would need to be always
compiled into the
>kernel, even though it may not need it. And we already have code bloat
problems,
>no need to make it worse.
>
>Making them modular also isn't good. Each module takes a 4k page at least,
so you
>would waste a lot of memory because they're smaller than 4k.
>
>As long as they are not used by anything else it's probably best to keep
it
>where they are.
>
>-Andi

The routines are small enough, less than 500 loc total, that it would not
make a whole lot of difference either way.   Although I noticed a few
different places where MD5 is implemented in other parts of the kernel, the
HMAC-MD5 support (in md5.c) needed for signing smb frames is probably not
needed by anyone else (except PPP?).   I did not see any places (other than
cifs) that depend on md4 so that seems like it would not make sense to move
even though the code is pretty generic.    The ASN decoding routines on the
other hand (used e.g. by snmp and also will be needed in the future by the
cifs vfs for simple SPNEGO-like parsing of the session establishment frame)
might end up being useful to move into a common library in the long run.

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com


