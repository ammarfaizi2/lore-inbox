Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUAEBkv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 20:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUAEBkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 20:40:51 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:38580 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265840AbUAEBkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 20:40:49 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
References: <20040103040013.A3100@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
	<20040103141029.B3393@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031423180.2162@home.osdl.org>
	<20040104000840.A3625@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031802420.2162@home.osdl.org>
	<20040104034934.A3669@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031856130.2162@home.osdl.org>
	<20040104142111.A11279@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
	<20040104230104.A11439@pclin040.win.tue.nl>
	<200401042335.i04NZqQZ029910@turing-police.cc.vt.edu>
From: Jeremy Maitin-Shepard <jbms@attbi.com>
Date: Sun, 04 Jan 2004 20:43:27 -0500
In-Reply-To: <200401042335.i04NZqQZ029910@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Sun, 04 Jan 2004 18:35:51 -0500")
Message-ID: <87k747w4ow.fsf@jbms.ath.cx>
User-Agent: Gnus/5.1005 (Gnus v5.10.5) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> On Sun, 04 Jan 2004 23:01:04 +0100, Andries Brouwer said:
>> A common Unix idiom is testing for the identity
>> of two files by comparing st_ino and st_dev.
>> A broken idiom?

> Comparing two of these obtained at the same time is *usually* a good
> test, although racy even on current systems. (Consider the case of an
> unlink()/creat() pair between the two stat() calls - there's been more than
> one race condition resulting in a security hole based on THIS one).  It's
> only safe if you actually have an open reference to both files before you
> fstat() either one.  And yes, it has to be fstat(), as you can't guarantee
> that the file referenced by path in stat() is the one you did an
> open() on.

Unfortunately, programs such as tar depend on inode numbers of distinct
files being distinct even when the file is not open over a period of
several minutes/seconds.  This is needed to avoid dumping hard links
more than once.  Furthermore, there is no efficient way to write
programs such as tar without depending on this capability.  Thus, if
st_ino cannot be used reliably for this purpose, it would be useful for
there to be a system call for retrieving a true
unique-within-the-filesystem identifier for the file.

-- 
Jeremy Maitin-Shepard
