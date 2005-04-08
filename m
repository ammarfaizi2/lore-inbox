Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVDHUM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVDHUM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 16:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbVDHUM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 16:12:27 -0400
Received: from [217.149.127.10] ([217.149.127.10]:24286 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP id S262898AbVDHUMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 16:12:22 -0400
Date: Fri, 8 Apr 2005 22:11:51 +0200
From: Ragnar =?iso-8859-15?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Uncached stat performace [ Was: Re: Kernel SCM saga.. ]
Message-ID: <20050408201150.GL20644@vestdata.no>
References: <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <20050408171518.GA4201@taniwha.stupidest.org> <Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org> <20050408180540.GA4522@taniwha.stupidest.org> <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org> <20050408191638.GA5792@taniwha.stupidest.org> <Pine.LNX.4.58.0504081232430.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0504081232430.28951@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-Zet.no-MailScanner-Information: Please contact the ISP for more information
X-Zet.no-MailScanner: Found to be clean
X-MailScanner-From: ragnark@stine.vestdata.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 12:39:26PM -0700, Linus Torvalds wrote:
> One of the reasons I do inode numbers in the "index" file (apart from 
> checking that the inode hasn't changed) is in fact that "stat()" is damn 
> slow if it causes seeks. Since your stat loop is entirely 
> 
> You can optimize your stat() patterns on traditional unix-like filesystems
> by just sorting the stats by inode number (since the inode number is
> historically a special index into the inode table - even when filesystems
> distribute the inodes over several tables, sorting will generally do the
> right thing from a seek perspective). It's a disgusting hack, but it
> literally gets you orders-of-magnitude performance improvments in many
> real-life cases.

It does, so why isn't there a way to do this without the disgusting
hack? (Your words, not mine :) )

E.g, wouldn't a aio_stat() allow simular or better speedups in a way
that doesn't depend on ext2/3 internals?

I bet it would make a significant difference from things like "ls -l" in
large uncached directories and imap-servers with maildir?



-- 
Ragnar Kjørstad
Software Engineer
Scali - http://www.scali.com
Scaling the Linux Datacenter
