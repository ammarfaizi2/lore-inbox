Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310341AbSCBHZa>; Sat, 2 Mar 2002 02:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310342AbSCBHZU>; Sat, 2 Mar 2002 02:25:20 -0500
Received: from ms1.din.or.jp ([210.135.65.21]:39849 "EHLO ms1.din.or.jp")
	by vger.kernel.org with ESMTP id <S310341AbSCBHZH>;
	Sat, 2 Mar 2002 02:25:07 -0500
Message-ID: <000901c1c1bb$7fee8df0$010210ac@maddog>
From: "T.Harada" <t-harada@din.or.jp>
To: <linux-kernel@vger.kernel.org>
Cc: <t-harada@din.or.jp>
Subject: limit of following symlinks
Date: Sat, 2 Mar 2002 16:25:58 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using Linux-2.4.18 on some PC.
Linux-2.4.18 limits following sequential symlinks up to 5.
(All versions Linux-2.4 seem so.)
But the code and the comment of its code are different.
The comment tells the limit is 8, but the code seems to make the limit to 5.
Which should the limit be?
Here is the code.

linux/fs/namei.c:
/*
 * This limits recursive symlink follows to 8, while
 * limiting consecutive symlinks to 40.
 *
 * Without that kind of total limit, nasty chains of consecutive
 * symlinks can cause almost arbitrarily long lookups.
 */
static inline int do_follow_link(struct dentry *dentry, struct nameidata *nd)
{
        int err;
        if (current->link_count >= 5)
                goto loop;
        if (current->total_link_count >= 40)
                goto loop;


BTW, I always rewrite the code and change the limit to 20 because 5 is
too small for my project.
About Solaris, the limit is 20 and I'm happy on Solaris.
I hope the limit is grown to 20 on Linux.

I have not subscribed LKML, please CC me for reply.


