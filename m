Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282860AbRLLW7U>; Wed, 12 Dec 2001 17:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282861AbRLLW7L>; Wed, 12 Dec 2001 17:59:11 -0500
Received: from odin.inter.net.il ([192.114.186.10]:44304 "EHLO
	odin.inter.net.il") by vger.kernel.org with ESMTP
	id <S282860AbRLLW7G>; Wed, 12 Dec 2001 17:59:06 -0500
Message-ID: <000c01c18360$c1fa7400$c5e308d5@user>
From: "Amir Noam" <adnoam@zahav.net.il>
To: <linux-kernel@vger.kernel.org>
Cc: <adnoam@zahav.net.il>
Subject: possible bug in fs/proc/generic.c
Date: Thu, 13 Dec 2001 01:00:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Please CC me on any reply, since I'm not subscribed to the list.

I've stumbled upon something that looks like a bug, but since I'm
fairly new
to kernel programming, it can easily be a misunderstanding on my part.

The problem is that proc_register() (in fs/proc/generic.c) can fail
(returning -EAGAIN) if there are no more free node numbers in the
/proc fs.
However, no one is actually checking the return value of
proc_remove(). The
result, as I see it, is that when trying to create a new /proc entry
while
the maximal number of entries already exist, the new entry is
successfully
allocated, but cannot be linked to the rest of the /proc entries (via
the
pointers 'parent', 'subdir', etc...), and therefore cannot be accessed
through the file system.

Furthermore, this new entry can never be de-allocated, since there is
no
match for its name in the /proc fs.

So, is this an actual bug, or am I missing something completely
obvious
here?

Thanks in advance,
Amir Noam


