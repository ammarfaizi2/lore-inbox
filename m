Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265157AbUGDQgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbUGDQgw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 12:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbUGDQgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 12:36:52 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:63501 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265157AbUGDQgu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 12:36:50 -0400
To: Ali Akcaagac <aliakc@web.de>
Cc: linux-kernel@vger.kernel.org, aebr@win.tue.nl
Subject: Re: [BUG] FAT broken in 2.6.7-bk15
References: <1088951695.596.7.camel@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 05 Jul 2004 01:36:42 +0900
In-Reply-To: <1088951695.596.7.camel@localhost>
Message-ID: <877jtjwwyt.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ali Akcaagac <aliakc@web.de> writes:

> Ok after some further research I figured this out. My last working
> version of the Linux Kernel was 2.6.7 which worked with my rescue
> system. I now applied the bk* patches upwards to check which one caused
> the issue and I figured that this happened between bk3 to bk4 (so the
> problem occoured with the bk4 patch). The diskimage was created with
> mtools 3.9.9 and worked perfectly before.

Ah, my fault. I changed the handling of "codepage" options, but it wasn't
mentioned on changelog at all. (Sorry, I didn't notice this changes.)

Now, the codepage option recognizes only real NLS codepage module.
(It uses FAT_DEFAULT_CODEPAGE, not NLS_DEFAULT. And FAT_DEFAULT_CODEPAGE
only recognizes the numbers.)

Previously, it recognized/loaded all NLS modules via CONFIG_NLS_DEFAULT,
if it can't load the nls_cp437.ko or specified codepage.

But this is seriously wrong. For example, if fatfs using the
nls_utf8.ko for codepage, it will store the wrong 8.3-alias to
disk. (At least, windows can't read this. And several peoples reported
this problem.)

Anyway, could you please check FAT_DEFAULT_CODE/FAT_DEFAULT_IOCHARSET
and NLS_xxx in your .config.

Yes, this should be done automatically by config system. However...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
