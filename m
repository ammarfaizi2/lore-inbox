Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310346AbSCBHib>; Sat, 2 Mar 2002 02:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310347AbSCBHiW>; Sat, 2 Mar 2002 02:38:22 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:22583 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S310346AbSCBHiL> convert rfc822-to-8bit; Sat, 2 Mar 2002 02:38:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Urban Widmark <urban@teststation.com>,
        Cyrille Chepelov <cyrille@chepelov.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smbfs codepage fixes for 2.4.18
Date: Sat, 2 Mar 2002 08:38:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>
In-Reply-To: <Pine.LNX.4.33.0203012220240.22195-200000@cola.teststation.com>
In-Reply-To: <Pine.LNX.4.33.0203012220240.22195-200000@cola.teststation.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16h45n-0005bn-00@mrvdomng1.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark wrote:
> Attached is a patch vs 2.4.18 that fixes these issues for me. Please test
> and let me know.

There is no OOPS, which is good.

> If I select a codepage/charset combination that doesn't match I now get a
> somewhat cryptic message instead of an oops (just a temporary thing).
>     "smbfs: filename charset conversion failed"

I see a lot of them.

my smb.conf:
character set = ISO8859-1
client code page = 850


But I think, that my local code page is actually 8859-15 (I have euro-support 
so it has to be 15)
Is that a problem? AFAIK the only difference between 1 and 15 is the 
Euro-sign.


> The smbfs remote codepage can never be utf8 since there are no smb servers
> that talk utf8. It can be one of the dos codepages, it can be blank or
> with additional patches it can be a 2 byte little endian unicode format.
>
> Furthermore, the local charset must be one that matches the chars used in
> the remote set. Otherwise you get conversion errors. A few known good
> combinations are:
>
> cp850 <-> iso8859-1
> cp866 <-> koi8-r
> cp932 <-> euc-jp
> (the right is the local = linux side)

> But even with these it seems to be possible to create chars that do not
> match, and I think it is caused by windows trying to map unicode to a
> codepage and not finding a matching char to use.

The computer I mount has samba 2.0.7. But I don't know which code page it is 
running. If it is of interest I will ask.


> Local utf8 always matches the remote and is preferred if your system is
> setup to handle it.

I will try  that someday. If I had the choice I would introduce 4Byte Unicode 
for everthing and forbid everything else......

>     smb_proc_readdir_long: name=<directory> result=-2, rcls=1, err=2

If I run a find over all shares I still get some rare:

smb_proc_readdir_long: name=directory\*, result=-13, rcls=1, err=5

and

smb_proc_readdir_long: name=directory\*, result=-2, rcls=1, err=2

messages. 
These directories are empty, as you posted above.


greetings

CHristian
