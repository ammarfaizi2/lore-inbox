Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317608AbSFMM60>; Thu, 13 Jun 2002 08:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317612AbSFMM6Z>; Thu, 13 Jun 2002 08:58:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49797 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317608AbSFMM6Z>; Thu, 13 Jun 2002 08:58:25 -0400
Date: Thu, 13 Jun 2002 09:00:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: write-permission check for root
In-Reply-To: <Pine.GSO.4.05.10206111821320.18111-100000@mausmaki.cosy.sbg.ac.at>
Message-ID: <Pine.LNX.3.95.1020613085331.1340A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, Thomas 'Dent' Mirlacher wrote:

> hi list,
> 
> i was wondering if if it's reasonable to disable root write access
> for procfs,driverfs files (which have file permissions set to read
> only)

It is never reasonable. Check what root can do with any file...

Script started on Thu Jun 13 08:56:22 2002
# >foo
# ls -la
total 12
drwxrwxrwx   2 root     root         4096 Jun 13 08:56 .
drwxr-xr-x  24 root     root         4096 Jun 13 04:09 ..
-rw-rw-rw-   1 root     root            4 Jun 13 08:49 .811.117b9a
-rw-r--r--   1 root     root            0 Jun 13 08:56 foo
-rw-r--r--   1 root     root            0 Jun 13 08:56 typescript
# chmod 444 foo        # File set to Readonly
# ls -la 
total 12
drwxrwxrwx   2 root     root         4096 Jun 13 08:56 .
drwxr-xr-x  24 root     root         4096 Jun 13 04:09 ..
-rw-rw-rw-   1 root     root            4 Jun 13 08:49 .811.117b9a
-r--r--r--   1 root     root            0 Jun 13 08:56 foo
-rw-r--r--   1 root     root            0 Jun 13 08:56 typescript
# ls -la >foo		# Now, root can write to a readonly file.
# ls -la
total 16
drwxrwxrwx   2 root     root         4096 Jun 13 08:56 .
drwxr-xr-x  24 root     root         4096 Jun 13 04:09 ..
-rw-rw-rw-   1 root     root            4 Jun 13 08:49 .811.117b9a
-r--r--r--   1 root     root          316 Jun 13 08:56 foo
-rw-r--r--   1 root     root            0 Jun 13 08:56 typescript
# cat foo
total 12
drwxrwxrwx   2 root     root         4096 Jun 13 08:56 .
drwxr-xr-x  24 root     root         4096 Jun 13 04:09 ..
-rw-rw-rw-   1 root     root            4 Jun 13 08:49 .811.117b9a
-r--r--r--   1 root     root            0 Jun 13 08:56 foo
-rw-r--r--   1 root     root            0 Jun 13 08:56 typescript
# exit
exit

Script done on Thu Jun 13 08:57:06 2002


The ability for root to do anything, including ignoring file-permissions,
is not going to go away.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

