Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284882AbRLPWYq>; Sun, 16 Dec 2001 17:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284886AbRLPWYh>; Sun, 16 Dec 2001 17:24:37 -0500
Received: from balder.inter.net.il ([192.114.186.15]:32321 "EHLO
	balder.inter.net.il") by vger.kernel.org with ESMTP
	id <S284882AbRLPWYc>; Sun, 16 Dec 2001 17:24:32 -0500
Message-ID: <000201c18680$95368a80$41e008d5@user>
From: "Amir Noam" <adnoam@zahav.net.il>
To: <linux-kernel@vger.kernel.org>
Cc: "Amir Noam" <adnoam@zahav.net.il>
In-Reply-To: <001301c1866d$97ec7d60$720d4084@user> <002101c1866d$ccbbc6e0$720d4084@user>
Subject: possible bug in fs/proc/generic.c
Date: Sun, 16 Dec 2001 22:11:51 +0200
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

I've just noticed how horribly formatted this post came out, so I'm
sending it again. Hopefully this time it will be readable. Sorry about
that.

Please CC me on any reply, since I'm not subscribed to the list.

I've stumbled upon something that looks like a bug, but since I'm
fairly new to kernel programming, it can easily be a misunderstanding
on my part.

The problem is that proc_register() (in fs/proc/generic.c) can fail
(returning -EAGAIN) if there are no more free node numbers in the
/proc fs. However, no one is actually checking the return value of
proc_remove(). The result, as I see it, is that when trying to create
a new /proc entry while the maximal number of entries already exist,
the new entry is successfully allocated, but cannot be linked to the
rest of the /proc entries (via the pointers 'parent', 'subdir',
etc...), and therefore cannot be accessed through the file system.

Furthermore, this new entry can never be de-allocated, since there is
no match for its name in the /proc fs.

So, is this an actual bug, or am I missing something completely
obvious here?

Thanks in advance,
Amir Noam




