Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbUAEB6a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 20:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265842AbUAEB6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 20:58:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28823 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265839AbUAEB63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 20:58:29 -0500
Date: Mon, 5 Jan 2004 01:58:28 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeremy Maitin-Shepard <jbms@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040105015828.GA4176@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <200401042335.i04NZqQZ029910@turing-police.cc.vt.edu> <87k747w4ow.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k747w4ow.fsf@jbms.ath.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 08:43:27PM -0500, Jeremy Maitin-Shepard wrote:

> Unfortunately, programs such as tar depend on inode numbers of distinct
> files being distinct even when the file is not open over a period of
> several minutes/seconds.  This is needed to avoid dumping hard links
> more than once.  Furthermore, there is no efficient way to write
> programs such as tar without depending on this capability.  Thus, if
> st_ino cannot be used reliably for this purpose, it would be useful for
> there to be a system call for retrieving a true
> unique-within-the-filesystem identifier for the file.

No such thing.  It's not the matter of having a syscall to extract such
identifier - it's that on a lot of filesystems (including many common Unix
ones) there's nothing that would qualify.

Note that tar et.al. do not behave well if used on actively modified directory
tree and ->st_ino reuse is the least of the problems in that area.
