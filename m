Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbQKQTEt>; Fri, 17 Nov 2000 14:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQKQTEj>; Fri, 17 Nov 2000 14:04:39 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:35597 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129664AbQKQTE0>; Fri, 17 Nov 2000 14:04:26 -0500
Message-ID: <3A15792F.D8891A69@timpanogas.org>
Date: Fri, 17 Nov 2000 11:30:07 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: ORACLE and 2.4-test10
In-Reply-To: <E13wq1g-0000zo-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

When we ported Oracle to NetWare, we found that making changes to the
core file systems in NetWare that Oracle needed would tank FS
performance, so we came up with something called direct FS, a separate
File System interface just for Oracle.  The SOSD layer inside of Oracle
allows them, via simple config statements, to redirect to different file
systems, even specialized ones, so this is trivial for them to
instrument.  The whole O_SYNC thing accross the entire OS could be
problematic to support.  

In NetWare, directFS was little more than a "raw" interface that
bypassed the file cache.  It would be like having an API to a direct
physical file system that never cached data in the buffer cache.  In
Linux, this may be tough to pull off, but Al Viro could instrument a
raw_read, raw_write function table entry that would do something
similiar that would allow Oracle to detect if an FS had a raw mode,
since this is what they actually need.

My 2 cents anyway.

8)

Jeff

Alan Cox wrote:
> 
> > Can anybody on tell me whatever there are still
> > serious pitfalls in running Oracle-8.1.6.1R2 on the
> 
> Yes.
> 
> > If I rememeber correctly there where some problems with
> > SHM handling still left to resolve...
> 
> SHM is resolved but O_SYNC is not yet fixed. You could therefore easily lose
> your entire database
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
