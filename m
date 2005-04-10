Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVDJWHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVDJWHv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 18:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVDJWHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 18:07:51 -0400
Received: from fmr16.intel.com ([192.55.52.70]:60639 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261616AbVDJWHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 18:07:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: more git updates..
Date: Sun, 10 Apr 2005 15:07:37 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F033DB629@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: more git updates..
Thread-Index: AcU95kUFdW5fclLmQN+Bk1hUG9vxBQAMRCEQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Petr Baudis" <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       "Ross Vandegrift" <ross@jose.lug.udel.edu>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Apr 2005 22:07:34.0480 (UTC) FILETIME=[B2CCD500:01C53E19]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Also, I did actually debate that issue with myself, and decided that even
>if we do have tons of files per directory, git doesn't much care. The
>reason? Git never _searches_ for them. Assuming you have enough memory to
>cache the tree, you just end up doing a "lookup", and inside the kernel
>that's done using an efficient hash, which doesn't actually care _at_all_
>about how many files there are per directory.

So long as the hash *is* efficient when the directory is packed full of
38 character filenames made only of [0-9a-f] ... which might not match
the test cases under which the hash was picked :-)  When there are some
full-sized kernel git images, someone should do a sanity check.

>Hey, I may end up being wrong, and yes, maybe I should have done a 
>two-level one. The good news is that we can trivially fix it later (even 
>dynamically - we can make the "sha1 object tree layout" be a per-tree 
>config option, and there would be no real issue, so you could make small 
>projects use a flat version and big projects use a very deep structure 
>etc). You'd just have to script some renames to move the files around.

It depends on how many eco-system shell scripts get built that need to
know about the layout ... if some shell/perl "libraries" encode this
filename layout (and people use them) ... then switching later would
indeed be painless.

-Tony
