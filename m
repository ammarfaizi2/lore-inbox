Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVCZClV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVCZClV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 21:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVCZClV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 21:41:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28831 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261918AbVCZClR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 21:41:17 -0500
Date: Fri, 25 Mar 2005 18:39:25 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: tmv@comcast.net, jengelh@linux01.gwdg.de, maillist@zuco.org,
       linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
Message-Id: <20050325183925.79359c2e.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
	<Pine.LNX.4.62.0503221656310.2683@dragon.hyggekrogen.localhost>
	<200503231740.09572.maillist@zuco.org>
	<Pine.LNX.4.61.0503231829570.1481@yvahk01.tjqt.qr>
	<20050323174925.GA3272@zero>
	<Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yep, check `-noleaf' in find(1).

No.

At least the copy of find that I just looked at now, in
findutils-4.1.20, makes no such assumption that "." and ".." are the
first two directory entries.

Rather what it does is allow you to suppress an optimization, on file
systems that don't manage their directory link counts so that the link
count on a directory is exactly two more than the number of child
directories, which optimization avoids stat'ing every entry if you are
using some set of find options that are only looking at names, not other
stat data, and if by the link count on the directory, you've already
stat'd all the child directories.  The documentation for find -noleaf
spells this out.

The find command is enabling you to adapt to differing file system
directory link counts with this option.  It is not brokenly forcing a
wrong assumption on you, and in any case, it is an issue of directory
link counts, not of the opendir-readdir order of "." and ".." (if
present).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
