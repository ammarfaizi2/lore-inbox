Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbSKWTTd>; Sat, 23 Nov 2002 14:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbSKWTTa>; Sat, 23 Nov 2002 14:19:30 -0500
Received: from zork.zork.net ([66.92.188.166]:64393 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S267050AbSKWTSo>;
	Sat, 23 Nov 2002 14:18:44 -0500
To: "Sathyanarayana.A.N - 01cs6002" <san@cse.iitkgp.dhs.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: insmod
References: <Pine.LNX.4.33L2.0211240020330.16811-100000@pcs-2.cse.iitkgp.ernet.in>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: HATE SPEECH, GRAVE ILL-JUDGEMENT
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: "Sathyanarayana.A.N - 01cs6002" <san@cse.iitkgp.dhs.org>,
 <linux-kernel@vger.kernel.org>
Date: Sat, 23 Nov 2002 19:25:44 +0000
In-Reply-To: <Pine.LNX.4.33L2.0211240020330.16811-100000@pcs-2.cse.iitkgp.ernet.in> ("Sathyanarayana.A.N
 - 01cs6002"'s message of "Sun, 24 Nov 2002 00:27:27 +0530 (IST)")
Message-ID: <6ulm3krsuf.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Sathyanarayana.A.N - 01cs6002 quotation:

> I have written a kernel Virtual file system which merges different
> filesystem directories. For this I am using a VFS function
> inode_dir_notify() function to notify the parent inodes. Now I want
> my virtual file system to be converted as a module. I am facing
> problems while inserting the module. When I do a insmod it is giving
> Unresolved symbol inode_dir_notify even though it is defined in the
> kernel VFS. It is working in case of statically linked version.
>
> Can somebody please suggest me why this is happening?

Looks to me (a kernel know-nothing, looking at 2.4.19) that since
inode_dir_notify is defined as a static inline function (in
include/linux/dnotify.h), no separate definition is being emitted.
(This inline seems to check whether a notify needs to be done, and
calls __inode_dir_notify if necessary.)  __inode_dir_notify *is* a
regular function, but it doesn't seem to be exported, which I believe
means it can't be referenced by a module.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
