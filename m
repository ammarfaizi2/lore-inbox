Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVHDKXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVHDKXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 06:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVHDKXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 06:23:51 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:29340 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262462AbVHDKXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 06:23:50 -0400
Message-ID: <42F1E914.1060107@gentoo.org>
Date: Thu, 04 Aug 2005 11:08:20 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] util-linux 2.13-pre1
References: <20050802230751.GB4029@stusta.de>
In-Reply-To: <20050802230751.GB4029@stusta.de>
Content-Type: multipart/mixed;
 boundary="------------080005020701030805050405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080005020701030805050405
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Adrian,

Adrian Bunk wrote:
> util-linux 2.13-pre1 is available at
>   ftp://ftp.kernel.org/pub/linux/utils/util-linux/testing/util-linux-2.13-pre1.tar.gz

Any comments on the mount patch I sent to you?

Attaching it again now. Please apply.

Thanks,
Daniel

--------------080005020701030805050405
Content-Type: text/x-patch;
 name="util-linux-mount-umask.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="util-linux-mount-umask.patch"

From: Daniel Drake <dsd@gentoo.org>

Some filesystems such as FAT will default to using the umask of the current
process if the user did not specify a umask option.

Currently, mount.c calls umask(022) early on, removing the possibility of the
user-specified umask (at shell level) being used by default.

Removing the umask(022) call solves the problem.

This appears safe to do, because the code which creates files already does this
safely (saves umask, sets umask 022, creates file, restores umask).

Please apply.

--- util-linux-2.13-pre1/mount/mount.c.orig	2005-08-04 11:00:50.000000000 +0100
+++ util-linux-2.13-pre1/mount/mount.c	2005-08-04 11:00:58.000000000 +0100
@@ -1466,8 +1466,6 @@ main(int argc, char *argv[]) {
 	if ((p = strrchr(progname, '/')) != NULL)
 		progname = p+1;
 
-	umask(022);
-
 	/* People report that a mount called from init without console
 	   writes error messages to /etc/mtab
 	   Let us try to avoid getting fd's 0,1,2 */


--------------080005020701030805050405--
