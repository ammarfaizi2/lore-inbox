Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbUAHJz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 04:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUAHJz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 04:55:29 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:49571 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S264257AbUAHJz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 04:55:28 -0500
Date: Thu, 8 Jan 2004 10:54:27 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: Performance drop 2.6.0-test7 -> 2.6.1-rc2
Message-ID: <20040108105427.E20265@fi.muni.cz>
References: <20040107023042.710ebff3.akpm@osdl.org> <20040107215240.GA768@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040107215240.GA768@frodo>; from nathans@sgi.com on Thu, Jan 08, 2004 at 08:52:40AM +1100
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
: On Wed, Jan 07, 2004 at 02:30:42AM -0800, Andrew Morton wrote:
: > 
: > Nathan, did anything change in XFS which might explain this?
: 
: Just been back through the revision history, and thats a definate
: "no" - very little changed in 2.6 XFS while the big 2.6 freeze was
: on, and since then too (he says, busily preparing a merge tree).
: 
: > I see XFS has some private readahead code.   Anything change there?
: 
: No, and that readahead code is used for metadata only - for file data
: we're making use of the generic IO path code.
: 
	I have done further testing:

- this is reliable: repeated boot back to 2.6.1-rc2 makes the problem
	appear again (high load, system slow has hell), booting back
	to -test7 makes it disappear.
- this is probably not a compiler/toolchain issue (tried to compile the kernel
	using two different versions of gcc and system environment (RedHat 9
	one and the latest Gentoo).
- I have seen something similar on my fileserver (altough I was not able
	to research it thoroughly, because I had to went back to 2.4).
	The fileserver is dual Athlon MP, 1GB RAM, 2TB of storage on
	RAID-5 array on the 3ware controller. Most of its load is serving
	home directories via NFS (cca 2200 users), and few Windows clients
	via Samba 3.0.1. Filesystem is XFS as well, but I dont know whether
	this can be a problem. I have tried 2.6.0 only, not earlier or
	later revisions. 2.4.24-pre (XFS) works OK here.

	If I can guess, I think it would be a problem with block layer
or I/O request scheduling rather than XFS.
	
-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|  I actually have a lot of admiration and respect for the PATA knowledge  |
| embedded in drivers/ide. But I would never call it pretty:) -Jeff Garzik |
