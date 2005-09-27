Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbVI0XGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbVI0XGc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbVI0XGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:06:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21171 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965228AbVI0XGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:06:31 -0400
Date: Wed, 28 Sep 2005 00:06:19 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Hirokazu Takata <takata@linux-m32r.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
Message-ID: <20050927230619.GV7992@ftp.linux.org.uk>
References: <E1EJlNM-00059K-R8@ZenIV.linux.org.uk> <20050927.151301.189720995.takata.hirokazu@renesas.com> <20050927071025.GS7992@ftp.linux.org.uk> <CFD86C0A-0BE4-4D39-BAAE-F985D997AFD2@mac.com> <20050927163455.GT7992@ftp.linux.org.uk> <44F9E519-C94E-422B-9CA7-B24C2F76B78D@mac.com> <20050927175526.GU7992@ftp.linux.org.uk> <3B320087-2A36-4106-AB85-0A1B626234A1@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B320087-2A36-4106-AB85-0A1B626234A1@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 02:37:09PM -0400, Kyle Moffett wrote:
> >And no, sparse (or any other C compiler) is not required to have  
> >the same pile as gcc does.
> 
> But when we're using sparse to check kernel sources, it should have a  
> similar set to what the regular compiler (IE: gcc) has when building  
> kernel sources.

Have you ever looked at that set of defines?  Note that even with gcc
most of them are supposed to be only used in gcc headers.  Most of
those are never used in the kernel code, and for a good reason.  Only
two are actually used - stdarg.h and (for raid6 with CONFIG_ALTIVEC)
altivec.h.  Guess what?  The former doesn't use any of these defines
and in case of the latter the only define used would be a lie - sparse
does *not* handle -maltivec.

It gets even better when you get to defines that describe compiler capacities.
sparse, for example, does *not* support wchar_t et.al.; gcc does.  Should
we lie about that support?  Should sparse binary that kinda-sorta imitates
e.g. builtins of gcc 3.3 (and declares __GNUC... accordingly) pick bogus
ones from gcc4 you are using for build?

There are very few defines we really want out of that pile.  "Take everything"
is nowhere near sanity, especially if you consider the differences between
gcc versions (and gcc builds, while we are at it).
