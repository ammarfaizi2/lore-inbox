Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbUB0TXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 14:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbUB0TXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 14:23:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:16005 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262947AbUB0TXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 14:23:03 -0500
Date: Fri, 27 Feb 2004 11:28:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
cc: linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PATCH] Add getdents32t syscall
In-Reply-To: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz>
Message-ID: <Pine.LNX.4.58.0402271111180.2563@ppc970.osdl.org>
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Jakub Jelinek wrote:
> 
> Because no 32-bit getdents syscall provides this field to userland,
> glibc needs to use getdents64 syscall even for 32-bit getdents
> (and readdir etc.) and convert dirent entries from struct dirent64
> to struct dirent.  The code is quite complicated and as the former
> is bigger and the size of 64-bit dirents cannot be predicted accurately,
> it can happen that glibc reads too many entries and has to seek back
> on the dir etc.

Ok, I just committed the "add hidden d_type to the 32-bit getdents" thing, 
and I'd like to have people verify that it works (I just verified that it 
didn't break anything, but hey, nothing is using the data, so..)

However, the more I look at the above, the more confused I get. Your 
explanation simplty doesn't make any sense.

The thing is, it's _trivial_ to convert from the bigger format into the 
smaller format. It would be much harder to convert the other way. What's 
the problem with just using he getdents64 format and converting the data 
in-place?

			Linus
