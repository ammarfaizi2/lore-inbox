Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSFOOUO>; Sat, 15 Jun 2002 10:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSFOOUN>; Sat, 15 Jun 2002 10:20:13 -0400
Received: from hera.cwi.nl ([192.16.191.8]:29066 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315414AbSFOOUM>;
	Sat, 15 Jun 2002 10:20:12 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 15 Jun 2002 16:20:11 +0200 (MEST)
Message-Id: <UTC200206151420.g5FEKBF25783.aeb@smtp.cwi.nl>
To: adilger@clusterfs.com, tomaz.susnik@hermes.si
Subject: Re: 2.4.18 kernel lseek() bug
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >      a call to lseek() fails with EINVAL under the following conditions:
    >         - it is called on a disk device file
    >         - required offset is larger than the target disk device size

    Is this behaviour mandated in a standard, or is it just different from
    previous behaviour?  I'm not saying it _isn't_ a bug, but I don't see
    how seeking past the end of a block device is very useful.

I know many programs that use this. They seek and do not expect
an error, because the standard says no error is to be expected,
and then try to read or write.

Let me quote POSIX 1003.1-2001.

...
The lseek() function shall allow the file offset to be set beyond the
end of the existing data in the file.
...

[EINVAL] 
          The whence argument is not a proper value, or the resulting
          file offset would be negative for a regular file, block special
          file, or directory. 


Andries
