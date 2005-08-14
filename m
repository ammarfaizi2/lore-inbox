Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVHNQu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVHNQu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 12:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVHNQu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 12:50:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55998 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932565AbVHNQu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 12:50:26 -0400
Date: Sun, 14 Aug 2005 09:50:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 2.6.13-rc6] Fix kmem read on 32-bit archs
In-Reply-To: <200508141214_MC3-1-A731-BBE9@compuserve.com>
Message-ID: <Pine.LNX.4.58.0508140944570.3553@g5.osdl.org>
References: <200508141214_MC3-1-A731-BBE9@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Aug 2005, Chuck Ebbert wrote:
> 
>   It's ugly but so is the existing code.  And it won't fix 64-bit
> archs AFAICT.  Tested on 2.6.11, patch offsets fixed up for 2.6.13-rc6.

Btw, if you really want to allow negative ("huge positive") loff_t, then
you should do it the way we did "file->f_maxcount", and just have a u64
"file->f_maxpos" that we initialize to LONG_LONG_MAX or something like
that by default.

Then, the kmem_open() routine could set it to ULONG_LONG_MAX, and the
rw_verify_area check would change from comparing pos for being negative to
an unsigned compare of pos against "f_maxpos".

(That would also allow filesystems to limit the position to 32-bit values
if they wanted to, and felt that they didn't want to even handle anything
else).

			Linus
