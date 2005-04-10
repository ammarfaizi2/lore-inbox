Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVDJUq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVDJUq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 16:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVDJUq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 16:46:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10681 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261603AbVDJUnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 16:43:18 -0400
Date: Sun, 10 Apr 2005 13:41:08 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Petr Baudis <pasky@ucw.cz>
Cc: mingo@elte.hu, willy@w.ods.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, rddunlap@osdl.org, ross@jose.lug.udel.edu
Subject: Re: [ANNOUNCE] git-pasky-0.1
Message-Id: <20050410134108.4f66dfd5.pj@engr.sgi.com>
In-Reply-To: <20050410184522.GA5902@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	<20050410024157.GE3451@pasky.ji.cz>
	<20050410162723.GC26537@pasky.ji.cz>
	<20050410173349.GA17549@elte.hu>
	<20050410174221.GD7858@alpha.home.local>
	<20050410174512.GA18768@elte.hu>
	<20050410184522.GA5902@pasky.ji.cz>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good lord - you don't need to use arrays for this.

The old-fashioned ways have their ways.  Both the 'set'
command and the 'read' command can split args and assign
to distinct variable names.

Try something like the following:

  diff-tree -r $id1 $id2 |
	sed -e '/^</ { N; s/\n>/ / }' -e 's/./& /' |
	while read op mode1 sha1 name1 mode2 sha2 name2
	do
		... various common stuff ...
		case "$op" in
		"+")
			...
			;;
		"-")
			...
			;;
		"<")
			test $name1 = $name2 || die mismatched names
			label1=$(mkbanner "$loc1" $id1 "$name1" $mode1 $sha1)
			label2=$(mkbanner "$loc2" $id2 "$name1" $mode2 $sha2)
			diff -L "$label1" -L "$label2" -u "$loc1" "$loc2"
			;;
		esac
	done

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
