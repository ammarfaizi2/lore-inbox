Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135532AbREFAPB>; Sat, 5 May 2001 20:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135599AbREFAOw>; Sat, 5 May 2001 20:14:52 -0400
Received: from pC19F9CBE.dip.t-dialin.net ([193.159.156.190]:63757 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S135532AbREFAOg> convert rfc822-to-8bit;
	Sat, 5 May 2001 20:14:36 -0400
Message-ID: <3AF4974C.D5D85498@baldauf.org>
Date: Sun, 06 May 2001 02:14:04 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org, Xuan Baldauf <xuan--lkml@baldauf.org>
Subject: Re: [PATCH][RFT] smbfs bugfixes for 2.4.4
In-Reply-To: <Pine.LNX.4.30.0103162326530.28939-200000@cola.teststation.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Urban Widmark wrote:

> Hello all
>
> This patch have been building up for a while, without reaching some
> undefined level of readiness. I would like some feedback from other smbfs
> users before submitting this for 2.4.4-something. Particularly from people
> mounting win9x shares.
>
> * win9x will sometimes not give back the right filesize, this can cause
>   problems when cp'ing a file over an existing one. When truncating the
>   file to 0 bytes the server keeps reporting the old size and much
>   confusion arises.
>   (reported by Xuan Baldauf, could you verify that this fixes it? If it
>    does it's a much better fix than the workaround you got before.)

Hello Urban,

it does not fix|work around the bug completely:

1. windows: Create a file, e.g. with 741 bytes.
2. linux: "ls -la" will show you the file with the correct size (741)
3. linux: read the file into your smbfs cache (e.g. "less file")
4. windows: add some contents to the file, e.g. so that it is now 896 bytes
long
5. linux: "ls -la" will show you the file with the correct size (896)
6. linux: read the file (e.g. "less file")

What you should see, on the linux box, are the new contents of the file. What
you will see are the old contents of the file plus a lot "^@^@^@^@^@^@^@"
(which mean null bytes) at the end of the old contents.

The file sizes used here should be arbitrary, but this concrete case just
happened now. They do not need to have to cross a 512-byte-block boundary or
so.

Also, "ls" is correct every time, only the content is incorrect.

So maybe, if reader and writer are the same smbfs, the bug might be fixed, but
if the writer is another machine than the reader, it is not.

Xuân.


