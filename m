Return-Path: <linux-kernel-owner+w=401wt.eu-S1754079AbWLXFfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbWLXFfS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 00:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbWLXFfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 00:35:17 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:43647 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbWLXFfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 00:35:15 -0500
Date: Sat, 23 Dec 2006 21:35:47 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, Ian McDonald <ian.mcdonald@jandi.co.nz>,
       Thomas Meyer <thomas@m3y3r.de>, linux-cifs-client@lists.samba.org,
       Steve French <sfrench@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: WARNING: "test_clear_page_dirty" [fs/cifs/cifs.ko] undefined!
Message-Id: <20061223213547.a0ff6425.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612231152360.3671@woody.osdl.org>
References: <458BEB9D.8030709@m3y3r.de>
	<20061222223034.b29aeb5f.khali@linux-fr.org>
	<Pine.LNX.4.64.0612221615430.3671@woody.osdl.org>
	<Pine.LNX.4.64.0612231004270.3671@woody.osdl.org>
	<20061223114458.30722de7.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0612231152360.3671@woody.osdl.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2006 12:06:43 -0800 (PST) Linus Torvalds wrote:

> 
> 
> On Sat, 23 Dec 2006, Randy Dunlap wrote:
> > 
> > BTW, reiserfs has similar build problems:  it uses clear_page_dirty()
> > so it won't build.
> 
> Not any more. I fixed that one (very different issue, btw: it's not 
> actually doign writeout, it actually wanted to cancel IO on truncated 
> buffers.
> 
> However, it's certainly possible that my fix hasn't mirrored out yet, I 
> pushed it just a couple of hours ago. So if you want to test it, here are 
> the two commits in question..
> 
> (The "cancel_dirty_page()" cleanup is needed not just to do reiserfs as a 
> module, it's also to make it more robust against reiserfs possibly feeding 
> that function with strange pages, and to match the other related functions 
> in the accounting functions).
> 
> Len Brown tested the reiserfs changes, and claims that it was all good, 
> but if somebody wants to run fsx-linux or some other filesystem stress 
> testing tool that actually tests shared mmap (and truncate), that would be 
> really appreciated.

I ran fsx-linux on it for one hour... with no problems reported.

---
~Randy
