Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279264AbRJ2MTO>; Mon, 29 Oct 2001 07:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279262AbRJ2MTE>; Mon, 29 Oct 2001 07:19:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52228 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279261AbRJ2MSr>; Mon, 29 Oct 2001 07:18:47 -0500
Subject: Re: Does VFS cache individual files? Is the linker involved?
To: Magnus.Sundberg@dican.se (Magnus Sundberg)
Date: Mon, 29 Oct 2001 12:26:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BDD4593.74988F93@dican.se> from "Magnus Sundberg" at Oct 29, 2001 01:03:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yBUP-0002Zr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does VFS cache the content of a file?

It caches arbitary pages of the file.

> Does VFS consult memory instead of disk, when accessing a file that is
> already linked to a process that is running?

Depends if the block is already in memory. If it is paged in then it will
used a shared read only copy when there is one. If not then it will load it

> One night, when the PHP runtime of apache had crashed, tripwire reported
> checksum error of
> /usr/lib/apache/libphp4.so
> The next night, when apache was restarted, there where no checksum
> errors of the file.
> 
> I have seen checksum errors of /lib/libc-2.2.2.so, rpm also reported md5
> checksum error when I
> used rpm to verify the installation of glibc.

That is consistent with in memory file cache corruption yes. Since the error
never got written back to disk (and its probably in a clean page) it
vanished when the cached copy did
