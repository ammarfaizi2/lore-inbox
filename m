Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265842AbUAEB73 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 20:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbUAEB72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 20:59:28 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:33734 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265842AbUAEB7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 20:59:25 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: st_dev:st_ino
References: <Pine.LNX.4.58.0401031423180.2162@home.osdl.org>
	<20040104000840.A3625@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031802420.2162@home.osdl.org>
	<20040104034934.A3669@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031856130.2162@home.osdl.org>
	<20040104142111.A11279@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
	<20040104230104.A11439@pclin040.win.tue.nl>
	<200401042335.i04NZqQZ029910@turing-police.cc.vt.edu>
	<87k747w4ow.fsf@jbms.ath.cx> <20040105014755.GB24410@mark.mielke.cc>
From: Jeremy Maitin-Shepard <jbms@attbi.com>
Date: Sun, 04 Jan 2004 21:02:02 -0500
In-Reply-To: <20040105014755.GB24410@mark.mielke.cc> (Mark Mielke's message
 of "Sun, 4 Jan 2004 20:47:55 -0500")
Message-ID: <87llontap1.fsf@jbms.ath.cx>
User-Agent: Gnus/5.1005 (Gnus v5.10.5) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke <mark@mark.mielke.cc> writes:

> On Sun, Jan 04, 2004 at 08:43:27PM -0500, Jeremy Maitin-Shepard wrote:
>> Unfortunately, programs such as tar depend on inode numbers of distinct
>> files being distinct even when the file is not open over a period of
>> several minutes/seconds.  This is needed to avoid dumping hard links
>> more than once.  Furthermore, there is no efficient way to write
>> programs such as tar without depending on this capability.  Thus, if
>> st_ino cannot be used reliably for this purpose, it would be useful for
>> there to be a system call for retrieving a true
>> unique-within-the-filesystem identifier for the file.

> We already have that: st_nlink

> I think you mean a system call that would allow you to be certain that
> two file descriptors refer to the same file. Then, any files with
> st_nlink >= 2 would have to use the system call to match them up.

In order to efficiently implement tar, it is necessary to store the
inode numbers for files with a link count greater than 1 in a hash
table.  It would not be practical to keep open all of these files in
order to ensure that the inode numbers remain valid.  Thus, a different
unique identifier is needed, which is unique even for files that are not
open.

-- 
Jeremy Maitin-Shepard
