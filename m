Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314658AbSD1BxK>; Sat, 27 Apr 2002 21:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314660AbSD1BxJ>; Sat, 27 Apr 2002 21:53:09 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:60153 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S314658AbSD1BxJ>; Sat, 27 Apr 2002 21:53:09 -0400
Date: Sat, 27 Apr 2002 18:52:38 -0700
From: Chris Wright <chris@wirex.com>
To: Colin Slater <hoho@binbash.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        davej@suse.de
Subject: Re: [PATCH] Various suser() -> capable() chang
Message-ID: <20020427185238.A31285@figure1.int.wirex.com>
Mail-Followup-To: Colin Slater <hoho@binbash.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	davej@suse.de
In-Reply-To: <E171XNI-0000Ji-00@the-village.bc.nu> <1019949402.7399.3101.camel@neptune>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Colin Slater (hoho@binbash.net) wrote:
> 
> I figured that it would be functionaly equivilent and didn't pay mutch
> more attention to the issue. I've gone through it all again, and changed
> alot of them to CAP_SYS_TTY_CONFIG and CAP_RAW_IO. New patch attached.

Thanks for working on this change, it's been on the LSM todo list as well.
It looks like the patch is still all CAP_SYS_ADMIN, perhaps you attached
the wrong one.  I see one fsuser() check in fs/ufs/balloc.c that should
be converted also.

cheers,
-chris

--- 1.8/fs/ufs/balloc.c	Sun Feb 10 04:27:35 2002
+++ edited/fs/ufs/balloc.c	Sat Apr 27 18:40:22 2002
@@ -288,7 +288,7 @@
 	/*
 	 * There is not enough space for user on the device
 	 */
-	if (!fsuser() && ufs_freespace(usb1, UFS_MINFREE) <= 0) {
+	if (!capable(CAP_SYS_RESOURCE) && ufs_freespace(usb1, UFS_MINFREE) <= 0) {
 		unlock_super (sb);
 		UFSD(("EXIT (FAILED)\n"))
 		return 0;
