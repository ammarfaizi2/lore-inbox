Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbULNSSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbULNSSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbULNSSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:18:04 -0500
Received: from psych.st-and.ac.uk ([138.251.11.1]:11465 "EHLO
	psych.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id S261611AbULNSNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:13:49 -0500
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412141812250.5600@yvahk01.tjqt.qr>
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>
	 <41ACA7C9.1070001@namesys.com>
	 <1103043518.21728.159.camel@pear.st-and.ac.uk>
	 <Pine.LNX.4.61.0412141812250.5600@yvahk01.tjqt.qr>
Content-Type: text/plain
Message-Id: <1103047919.28291.13.camel@pear.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Dec 2004 18:11:59 +0000
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 17:21, Jan Engelhardt wrote:
> Recently I discovered that calling "joe /etc" on FreeBSD opens the directory 
> itself (rather than erroring out with EISDIR). The byte string looked like a 
> number of "struct dirent"s. Did it break apps in BSD? I donot think so.

I don't imagine anyone would miss that behaviour, we can probably have
something more useful than a
cat: /etc: Is a directory
message.

> >(I am not sure whether the access method, e.g. read() vs. readdir() is
> >sufficient to distinguish the meaning. Another way may be putting a "/"
> >after the objectname to indicate that you want it as a directory.)
> 
> I would not rely on that. Many apps strip a trailing slash (just to add it 
> later again) or vice versa!

ok, I don't really care about the trailing slash. The reading method
(read() vs. readdir()) may be enough to distinguish the uses. The
trailing / is still a useful (and logical) visual notation though for
the different meanings, so something like ls could give both versions.

> What will ls do? 

list both /etc/passwd and /etc/passwd/ perhaps?

> Consider this on a "normal" filesystem:
> 
> ls -l /etc/passwd
> -rw-r--r--  1 root root 1614 Dec 12 23:57 /etc/passwd
> ls -l /etc
> [lots of files]
> 
> 
> What will happen on v4 then?
> ls -l /etc
> -rw-r--r-- 1 root root 123456 Dec 01 23:45 /etc
> ls -l /etc/passwd
> -rw-r--r-- 1 root root 1234 Dec 01 23:45 root
> -rw-r--r-- 1 root root 1234 Dec 01 23:45 jengelh
> -rw-r--r-- 1 root root 1234 Dec 01 23:45 daemon
> -rw-r--r-- 1 root root 1234 Dec 01 23:45 sys
> -rw-r--r-- 1 root root 1234 Dec 01 23:45 stduser
> 
> It's because "ls" checks the type of the argument to decide what to do (unless
> you add -d).
> 
> 
> Jan Engelhardt

