Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLGQCM>; Thu, 7 Dec 2000 11:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLGQCC>; Thu, 7 Dec 2000 11:02:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:42892 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129257AbQLGQBu>;
	Thu, 7 Dec 2000 11:01:50 -0500
Date: Thu, 7 Dec 2000 10:31:23 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: getcwd() returning -ENOENT???
In-Reply-To: <200012071503.eB7F3AS11880@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0012071025050.20144-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2000, Russell King wrote:

> Hi,
> 
> Can someone explain why I'm seeing the following on test12-pre7:
> 
> bash# /bin/pwd
> /bin/pwd: cannot get current directory: No such file or directory

Directory is unhashed. Normally it means that sucker had been deleted.

> bash# vdir /proc/self/.
> ...
> lrwxrwxrwx    1 root     root           0 Dec  7 14:52 cwd -> /net/raistlin/raistlin-v2.4/linux-ebsa285 (deleted)

Ditto.

> ...
> lrwxrwxrwx    1 root     root           0 Dec  7 14:52 root -> /
> ...
> bash# vdir
> ... <complete listing of directory> ...

Which means that it is _not_ deleted. Looks like it had been invalidated
for some reason. Try to reproduce that on -test10 - that should be before
NFS changes.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
