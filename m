Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUJYQzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUJYQzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUJYQyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:54:35 -0400
Received: from mailbox.surfeu.se ([213.173.154.11]:58053 "EHLO surfeu.fi")
	by vger.kernel.org with ESMTP id S262049AbUJYQyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:54:01 -0400
Message-ID: <417D2FEE.D0FB3C99@users.sourceforge.net>
Date: Mon, 25 Oct 2004 19:55:10 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-crypto@nl.linux.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v2.2c file/swap crypto package
References: <417BE3D6.BB54FE7D@users.sourceforge.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu wrote:
> - Added random key setup option to mount and losetup. This can be used to
>   encrypt /tmp with random keys.

As some of you may have noticed, new example 4 of loop-AES README file was
fucked up. One important step was missing from example 4 instructions, and
if those instructions were followed literally, /tmp partition most likely
ended up being unwritable by non-root users.

Below is the fix in patch form, and URL of full corrected README file:

http://loop-aes.sourceforge.net/loop-AES.README

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD


--- ../loop-AES-v2.2c/README	Sun Oct 24 19:19:00 2004
+++ ./README	Mon Oct 25 19:15:39 2004
@@ -1,4 +1,4 @@
-Written by Jari Ruusu <jariruusu@users.sourceforge.net>, October 24 2004
+Written by Jari Ruusu <jariruusu@users.sourceforge.net>, October 25 2004
 
 Copyright 2001,2002,2003,2004 by Jari Ruusu.
 Redistribution of this file is permitted under the GNU Public License.
@@ -616,7 +616,10 @@
 
  /dev/hda555   /tmp   ext2   defaults,loop=/dev/loop2,encryption=AES128,phash=random   0   0
                                       ^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^ ^^^^^^^^^^^^       ^
-Third, run "mount /tmp" command and you are done.
+Third, run "mount /tmp" and "chmod a+rwxt /tmp" commands.
+
+Fourth, make sure that "chmod a+rwxt /tmp" command is run by init scripts
+somewhere after "mount -a" command is run.
 
 Encryption keys and plaintext data on above type mount vanish on unmount or
 power off. Using journaled file system in such case does not make much
