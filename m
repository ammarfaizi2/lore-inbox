Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLQQAL>; Sun, 17 Dec 2000 11:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbQLQQAB>; Sun, 17 Dec 2000 11:00:01 -0500
Received: from sweet.diamond.org ([208.5.57.115]:21517 "EHLO mx1.diamond.org")
	by vger.kernel.org with ESMTP id <S129370AbQLQP7x>;
	Sun, 17 Dec 2000 10:59:53 -0500
Date: Sun, 17 Dec 2000 10:29:54 -0500 (EST)
From: Glen Shere <linux-kernel@lists.diamond.org>
To: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: using kernel headers from user space
Message-ID: <Pine.LNX.4.21.0012170954180.1876-100000@sweet.diamond.org>
X-Easter-Egg: Best Wishes from Glen Shere
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens wrote:
> Linus has spoken, it is an error for user space applications to
> include kernel headers.  Even modutils does not include
> linux/module.h, instead it has a portable (2.0 through 2.4) local
> definition of struct module.

Oh my.  This isn't clear to the part-time kernel hacker; to install
[...]linux/include/linux in /usr/include/linux implies that those headers
can and should be used in user-space.  I've already done this several
times, in order to use kernel structures from user space.  Whoops :-)

Perhaps the header files that are intended to be used only within the
kernel tree could be moved to a seperate directory, and then not installed
in /usr/include.  Obviously 2.5 material, if Linus is so inclined.

I would rather a build break when what's defined in a kernel header file
gets changed (such as a critical structure, or the like) and further
maintenance of the user-space utilities is needed; a "heads-up" to the
maintainer if nothing else.  The recent episode with klogd is a fine
example of how well that would work.  If klogd had its own copies of
headers and built fine, we all would quite possibly still not know about
the inconsistency.

-Glen



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
