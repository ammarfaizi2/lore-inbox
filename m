Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUBVMcU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 07:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbUBVMcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 07:32:20 -0500
Received: from smtp2.att.ne.jp ([165.76.15.138]:38854 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S261239AbUBVMcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 07:32:14 -0500
Message-ID: <18de01c3f93f$dc6d91d0$b5ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 filenames
Date: Sun, 22 Feb 2004 21:30:50 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel@mikebell.org wrote:

> So then, just about everyone agrees that if you've got a filename with
> non-ASCII characters, you should pass it to creat() as UTF-8. You have
> to pass it as something, individual encodings like BIG5 and EUC-JP
> are unacceptable, and UCS-4's benefits over UTF-8 (simplicity and in
> VERY rare cases storage size reductions) aren't worth the stuff it
> breaks. Correct?

Correct except for the following cases.  Unix users for more than 20 years
have been creating filenames encoded in EUC-JP or SJIS (yes sadly some Unix
systems used SJIS).  I don't know how long BIG5 and Korean filenames have
been supported in Unix but it's probably not much different.  Consider
converting all your ASCII filenames to UTF-16.  Let everyone share the
short-term pain for the long-term gain.  When you get everyone to agree on
UTF-16, it will be ugly, but it will be equal for everyone.

By the way, another subthread mentioned that stty puts some stuff in the
kernel that could be done in user space.  In Unix systems the same is true
for IMEs, stty options specify the encoding of the output of an IME (e.g.
EUC-JP or SJIS, which then gets forwarded as input to shells, applications,
etc.), and whether a single backspace (or whatever character deletion
character) deletes an entire input character instead of just deleting a
single byte, etc.  I keep forgetting to see if Linux has the same stty
options.  I haven't needed to set them with stty because if I need to use a
different locale then I just open a new terminal emulator window using that
locale.

I don't have time even to follow all of this thread, so if anyone has
questions then CC me personally.  I don't know if I'll have time to answer
either, but I'll try.

> As I see it, there's no way for the kernel to deal with all the legacy
> filenames out there. There's no way the kernel can magically fix them.

That's true.  Some options of mount and some options of stty can be moved to
user space, but they will always need to be available.

By the way in Windows 98 it's really neat to share a disk folder across the
network and let clients with different code pages create files.  The host
where the folder is stored can't even delete some of the files that get
created.

