Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTIYXRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbTIYXRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:17:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:47273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262078AbTIYXRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:17:33 -0400
Date: Thu, 25 Sep 2003 15:57:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: dtor_core@ameritech.net, petero2@telia.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Extend KD?BENT to handle > 256 keycodes.
Message-Id: <20030925155728.013b6712.akpm@osdl.org>
In-Reply-To: <1064508612197@twilight.ucw.cz>
References: <10645086121089@twilight.ucw.cz>
	<1064508612197@twilight.ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
>
>   input: Create new KD?BENT ioctls with a bigger key range (int), so that
>          it's posible to recompile kbdutils on 2.6 and load keymaps for
>          keys beyond 128. kbdutils compiled on 2.4 will keep working on
>          2.6, unfortunately not vice versa, without changing kbdutils.

Doesn't compile with older gcc's

diff -puN drivers/char/vt_ioctl.c~input-06-extend-entries-fix drivers/char/vt_ioctl.c
--- 25/drivers/char/vt_ioctl.c~input-06-extend-entries-fix	Thu Sep 25 15:55:42 2003
+++ 25-akpm/drivers/char/vt_ioctl.c	Thu Sep 25 15:55:44 2003
@@ -77,7 +77,7 @@ asmlinkage long sys_ioperm(unsigned long
 static inline int
 do_kdsk_ioctl(int cmd, void *user_kbe, int perm, struct kbd_struct *kbd)
 {
-	struct kbentry tmp, *kbe = user_kbe;;
+	struct kbentry tmp, *kbe = user_kbe;
 	struct kbentry_old old, *old_kbe = user_kbe;
 	ushort *key_map, val, ov;
 

_

