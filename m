Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261630AbTCKVuw>; Tue, 11 Mar 2003 16:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261632AbTCKVuw>; Tue, 11 Mar 2003 16:50:52 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34316 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261630AbTCKVuw>; Tue, 11 Mar 2003 16:50:52 -0500
Date: Tue, 11 Mar 2003 16:57:22 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Bug 417] New: htree much slower than regular ext3
In-Reply-To: <m34r6fyya8.fsf@lexa.home.net>
Message-ID: <Pine.LNX.3.96.1030311165045.20920A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Mar 2003, Alex Tomas wrote:

> The problem is that getdents(2) returns inodes out of order and
> du causes many head seeks. I tried to solve the problem by patch
> I included in. The idea of the patch is pretty simple: just try
> to sort dentries by inode number in readdir(). It works because
> inodes sits at fixed places in ext2/ext3. Please, look at results
> I just got:

Any change in the order of dentries returned is likely to run into problem
when seeking in a directory. Given that readdir() is usully followed by
either zero or many stat()s, perhaps when the first stat() comes along you
could pre-read the inodes in optimal order and cace them. However you
tuned the size of your sort should work exactly as well as the size of the
pre-read.

This seems consistent with readahead and AS disk io.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

