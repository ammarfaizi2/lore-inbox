Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130376AbRAZWQO>; Fri, 26 Jan 2001 17:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130695AbRAZWQF>; Fri, 26 Jan 2001 17:16:05 -0500
Received: from gw2-int.ensim.com ([38.186.181.2]:11766 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S130376AbRAZWP7>; Fri, 26 Jan 2001 17:15:59 -0500
X-mailer: xrn 8.03-beta-26
From: Paul Menage <pmenage@ensim.com>
Subject: Re: Undoing chroot?
To: Paul Powell <moloch16@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D04E323@nasdaq.ms.ensim.com>
Message-Id: <E14MH9w-0008Cd-00@pmenage-dt.ensim.com>
Date: Fri, 26 Jan 2001 14:15:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D04E323@nasdaq.ms.ensim.com>,
you write:
>
>So how do you reverse a CHROOT?
>

Assuming your process doesn't drop its root privileges, before you do
the initial chroot() you could do:

old_root = open("/", O_RDONLY);

Then later do

fchdir(oldroot);
chroot(".");

But the cleaner and more portable solution is probably to have a child
process executing inside the chroot, and have its parent eject the CD
when the child exists.

Paul
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
