Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263686AbUJ3LE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbUJ3LE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263690AbUJ3LE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:04:27 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:27014 "EHLO
	midnight.suse.cz") by vger.kernel.org with ESMTP id S263686AbUJ3LEW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:04:22 -0400
Date: Sat, 30 Oct 2004 13:04:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Sami Farin <7atbggg02@sneakemail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.9-ac5 - more stupid FAT filesystems
Message-ID: <20041030110414.GA3130@ucw.cz>
References: <1099060831.13098.33.camel@localhost.localdomain> <20041030090308.GA6060@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030090308.GA6060@m.safari.iki.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 12:03:08PM +0300, Sami Farin wrote:

> On Fri, Oct 29, 2004 at 03:40:32PM +0100, Alan Cox wrote:
> > This update adds some of the more minor fixes as well as a fix
> > for a nasty __init bug. Nothing terribly pressing for non-S390 users
> > unless they are hitting one of the bugs described or need the new
> > driver bits.
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.9/
> > 
> > 2.6.9-ac5
> > o	Fix oops in and enable IT8212 driver		(me)
> > o	Minor delkin driver fix				(Mark Lord)
> > o	Fix NFS mount hangs with long FQDN		(Jan Kasprzak)
> > 	| I've used this version as its clearly correct for 2.6.9 
> > 	| although it might not be the right future solution
> > o	Fix overstrict FAT checks stopping reading of	(Vojtech Pavlik)
> > 	some devices like Nokia phones
> 
> I guess Canon IXUS 400 is overstupid or something.

No, the patch from me (included in -ac) is completely bogus. The correct
patch is attached.

diff -urN linux-2.6.8/fs/fat/inode.c linux-2.6.8-fat/fs/fat/inode.c
--- linux-2.6.8/fs/fat/inode.c	2004-09-30 15:27:58.343661051 +0200
+++ linux-2.6.8-fat/fs/fat/inode.c	2004-09-30 15:33:32.820915377 +0200
@@ -1003,6 +1003,8 @@
 		/* all is as it should be */
 	} else if (media == 0xf8 && FAT_FIRST_ENT(sb, 0xfe) == first) {
 		/* bad, reported on pc9800 */
+	} else if (media == 0xf8 && FAT_FIRST_ENT(sb, 0xff) == first) {
+		/* bad, reported on Nokia phone with USB storage */
 	} else if (media == 0xf0 && FAT_FIRST_ENT(sb, 0xf8) == first) {
 		/* bad, reported with a MO disk on win95/me */
 	} else if (first == 0) {

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
