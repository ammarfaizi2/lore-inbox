Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267999AbRG3VER>; Mon, 30 Jul 2001 17:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbRG3VEH>; Mon, 30 Jul 2001 17:04:07 -0400
Received: from blacksun.leftmind.net ([204.225.88.62]:35588 "HELO
	blacksun.leftmind.net") by vger.kernel.org with SMTP
	id <S267885AbRG3VDv>; Mon, 30 Jul 2001 17:03:51 -0400
Date: Mon, 30 Jul 2001 17:03:58 -0400
From: Anthony DeBoer <adb@leftmind.net>
To: linux-kernel@vger.kernel.org
Subject: rename() (was Re: ext3-2.4-0.9.4)
Message-ID: <20010730170358.A3095@leftmind.net>
In-Reply-To: <E15QAon-00061p-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Newsgroups: leftmind.lists.linux-kernel
In-Reply-To: <s5gsnfh80hw.fsf@egghead.curl.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Patrick J. LoPresti <patl@cag.lcs.mit.edu> wrote:
>The MTAs do this:
>
>    Open temp file
>    Write to temp file
>    fsync() temp file
>    rename() temp file into mail spool
>    indicate success to remote MTA

Don't forget the unlink() temp file just before or after that last step.

>As long as rename() does not return until the metadata are committed,
>this should be a reliable delivery mechanism.  ...

As I understand it, rename() was originally invented for tasks like
installing a new /bin/sh with guarantees that another process running
at the same time would not fail to find a shell, and that if the system
fell over during the install you'd still have a shell on reboot.

See http://www.qef.com/ftp/rename.ps for an interesting history from
someone who was there at the time.  It's undated, but probably a decade
old.

It's my considered opinion that rename() _should_ fsync the target
directory before returning, and between that and the fsync() call on
the file itself (an install program should do the same call sequence as
above) you get the guarantee that the file is intact before you unlink
the temp version and return success.  OTOH, link() and unlink() are not
in the business of providing guarantees like that, and should not sync.

-- 
Anthony de Boer, curator, Anthony's Home for Aged Computing Machinery
<adb@leftmind.net>
