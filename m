Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292420AbSBZSyL>; Tue, 26 Feb 2002 13:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292701AbSBZSyD>; Tue, 26 Feb 2002 13:54:03 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:15089 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292420AbSBZSx3>;
	Tue, 26 Feb 2002 13:53:29 -0500
Date: Tue, 26 Feb 2002 11:52:28 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226115228.M12832@lynx.adilger.int>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Mike Fedyk <mfedyk@matchmail.com>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020226171634.GL4393@matchmail.com> <Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Feb 26, 2002 at 01:34:27PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2002  13:34 -0500, Richard B. Johnson wrote:
> johnson[4]$ ls -laR /home/users/lost+found/rjohnson
> total 5428
> drwxr-xr-x  17 rjohnson guru         4096 Feb 13 16:54 .
> drwxrwxrwx  21 root     root         4096 Feb 26 05:34 ..
> -rw-r--r--   1 rjohnson guru            6 Oct 15  1998 .XF86_S3
> :
> :
> -rwxr-xr-x   1 rjohnson guru         8141 Oct  9 16:08 xxx

A shorter example would have sufficed...

> All the deleted files, with the correct path(s), are now in the
> top directory file the file-system ../lost+found directory.
> To enable such a function (after modifing the C library), just make
> lost+found world-writable.

Making lost+found world-writable is a terrible idea (even world readable
is bad) because it exposes potentially sensitive files to the world if
it happens that fsck moves a file there after some filesystem problem.
It may be that the sensitive file was in a secure directory, and now it
is world readable.

I would stronly suggest using some other directory for this purpose,
since if you are changing lost+found to be world writable, you could
just as easily do "mkdir .undelete".

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

