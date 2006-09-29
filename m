Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161250AbWI2BOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250AbWI2BOr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 21:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbWI2BOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 21:14:47 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:48850 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1161250AbWI2BOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 21:14:46 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Fri, 29 Sep 2006 01:14:32 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <efhs1o$h5d$1@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <1159396436.3086.51.camel@laptopd505.fenrus.org> <eff0dv$poj$1@taverner.cs.berkeley.edu> <9a8748490609271638q590f10c3o8fb7d5e478e4dec2@mail.gmail.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159492472 17581 128.32.168.222 (29 Sep 2006 01:14:32 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Fri, 29 Sep 2006 01:14:32 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
>Below are some examples of how I've used noexec in the past and found
>it useful.

Ok, but every one of those examples is pretty much orthogonal to how
the Linux kernel treats mmap(PROT_EXEC).  The only thing you are relying
upon is that ld.so knows how to avoid unintentionally execute programs
that live on noexec partitions.  As long as ld.so has some way to tell
the kernel "please check for me whether this program lives on a noexec
partition; if it does, please bail out", then you'll get all of the benefits
you list and all of your use cases will be unaffected, no matter what
other semantics are assigned to mmap().



Here were your examples:

>1) Providing home directories for users that are mounted noexec
>prevents the situation where a user downloads a malicious program and
>accidentally executes it (for example by clicking on it in his GUI
>filemanager by mistake).  With the dir mounted noexec the application
>fails to run and the user (and admin) is spared some grief and
>possibly backup restores.
>
>2) serving static web pages from a filesystem mounted noexec offers a
>bit of protection against script kiddies who have found a hole in my
>webserver allowing them to exec a program from the web filesystem. It
>won't protect against clever attackers who have found a security hole
>big enough to allow them to work around noexec, but it does protect
>against lot of script kiddies who just found some "hackme.exe" that
>tries to just execute a few things (which I believe are the vast
>majority).
>
>3) I've often used noexec on filesystems used to store backup data,
>simply to guard against my own mistakes. Working with many shells on
>many boxes you sometimes make mistakes about what box you are on and
>if the backup box holds a complete copy of a filesystem hierarchy
>similar to the box you think you are on you may try executing some app
>on the backup box - possibly with the bad result of modifying your
>backup data. I know I've made that mistake in the past, but having the
>backup fs noexec prevented the programs to run and saved me some
>trouble.
