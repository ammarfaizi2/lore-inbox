Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbUBUSLM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 13:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbUBUSLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 13:11:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:50056 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261594AbUBUSLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 13:11:10 -0500
Date: Sat, 21 Feb 2004 10:15:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Ingo Molnar <mingo@elte.hu>, Tridge <tridge@samba.org>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(),
 O_CLEAN
In-Reply-To: <20040221080426.GO31035@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0402211012190.3301@ppc970.osdl.org>
References: <20040219163838.GC2308@mail.shareable.org>
 <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org>
 <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu>
 <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220170438.GA19722@elte.hu>
 <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org> <20040220184822.GA23460@elte.hu>
 <20040221075853.GA828@elte.hu> <20040221080426.GO31035@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> If we are demanding specific filesystems, we could simply say "use
> JFS in case-insensitive mode" and be done with that.  Which deals
> with all problems, since fs code will guarantee uniqueness, etc.

Don't be silly. You can't use JFS in case-insensitive mode and do anything 
sane.

That will terminally confuse a lot of UNIX applications, including NFS
serving.  Which makes the whole thing completely useless _except_ as a
pure Windows-compatible partition.

If you are going to limit a partition to _only_ doing Samba serving, then 
you have no problems _anyway_, since then samba can do all locking and all 
name translation totally on its own.

In short, a case-insensitive filesystem is fundamentally uninteresting. It 
buys _nothing_ that samba can't do already, since it only means that you 
can't really do anything else on it.

		Linus
